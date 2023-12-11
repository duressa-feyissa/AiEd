import { Types } from "mongoose";
import CustomError from "../../config/error";
import Submission, { ISubmission } from "../../domain/entities/submission";
import ContestModel from "../database/models/contest";
import SubmissionModel from "../database/models/submission";

export type ISubmissionRepositoryImpl = () => {
    findById: (id: string) => Promise<ISubmission>
    submit: (submission: ReturnType<typeof Submission>) => Promise<ISubmission>
    deleteSubmission: (id: string) => Promise<ISubmission>
}

export default function submissionRepositoryMongoDB() {

    const findById = (id: string): Promise<ISubmission> => {
        if (!Types.ObjectId.isValid(id)) {
            throw new CustomError(`${id} is not a valid submission id`, 400)
        }
        return SubmissionModel.findById(id)
            .then((submission: ISubmission | null) => {
                if (!submission) {
                    throw new CustomError(`Submission with id ${id} not found`, 404)
                }
                return submission
            })
    }

    const submit = (submission: ReturnType<typeof Submission>) => {
        return SubmissionModel.create({
          contest: submission.getContest(),
          problem: submission.getProblem(),
          user: submission.getUser(),
          userAnswer: submission.getUserAnswer(),
          point: submission.getPoint(),
          isCorrect: submission.getIsCorrect(),
          attemptedAt: submission.getAttemptedAt(),
        }).then((createdSubmission: ISubmission) => {
          if (createdSubmission) {
            return ContestModel.findByIdAndUpdate(
              createdSubmission.contest,
              {
                $push: {
                  submissions: createdSubmission._id,
                },
                $addToSet: {
                  'participants.$.submissions': createdSubmission._id,
                },
              },
              { new: true }
            )
          }
          return createdSubmission;
        });
      };
      

    const deleteSubmission = (id: string) => {
        if (!Types.ObjectId.isValid(id)) {
            throw new CustomError(`${id} is not a valid submission id`, 400)
        }
        return SubmissionModel.findByIdAndDelete(id)
            .then((submission: any) => {
                if (!submission) {
                    throw new CustomError(`Submission with id ${id} not found`, 404)
                }
                return submission
            })
    }

    return {
        findById,
        submit,
        deleteSubmission,
    }
}


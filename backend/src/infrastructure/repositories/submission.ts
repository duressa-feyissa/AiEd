import { Types } from 'mongoose'
import CustomError from '../../config/error'
import { IProblem } from '../../domain/entities/problem'
import Submission, { ISubmission } from '../../domain/entities/submission'
import ContestModel from '../database/models/contest'
import ProblemModel from '../database/models/problem'
import SubmissionModel from '../database/models/submission'

export type ISubmissionRepositoryImpl = () => {
  findById: (id: string) => Promise<ISubmission>
  submit: (submission: ReturnType<typeof Submission>) => Promise<ISubmission>
  deleteSubmission: (id: string) => Promise<ISubmission>
  findContestSubmissions: (
    userId: string,
    participationId: string,
  ) => Promise<ISubmission[]>
}

export default function submissionRepositoryMongoDB() {
  const findById = (id: string): Promise<ISubmission> => {
    if (!Types.ObjectId.isValid(id)) {
      return Promise.reject(
        new CustomError(`${id} is not a valid submission id`, 400),
      )
    }

    return SubmissionModel.findById(id).then(
      (submission: ISubmission | null) => {
        if (!submission) {
          return Promise.reject(
            new CustomError(`Submission with id ${id} not found`, 404),
          )
        }
        return submission
      },
    )
  }

  const submit = async (submission: ReturnType<typeof Submission>) => {
    const problemId = submission.getProblem()
    const userId = submission.getUser()
    const contestId = submission.getContest()
    const participationId = submission.getParticipation()
    const second = submission.getSecond()

    if (!Types.ObjectId.isValid(problemId!)) {
      return Promise.reject(
        new CustomError(`${problemId} is not a valid problem id`, 400),
      )
    }

    if (!Types.ObjectId.isValid(userId!)) {
      return Promise.reject(
        new CustomError(`${userId} is not a valid user id`, 400),
      )
    }

    if (contestId && !Types.ObjectId.isValid(contestId)) {
      if (!Types.ObjectId.isValid(contestId)) {
        return Promise.reject(
          new CustomError(`${contestId} is not a valid contest id`, 400),
        )
      }

      if (!Types.ObjectId.isValid(participationId!)) {
        return Promise.reject(
          new CustomError(
            `${participationId} is not a valid participation id`,
            400,
          ),
        )
      }
    }

    const existingProblem = (await ProblemModel.findById(problemId).select(
      'answer point',
    )) as IProblem
    if (!existingProblem) {
      return Promise.reject(
        new CustomError(`Problem with id ${problemId} not found`, 404),
      )
    }

    if (contestId && participationId) {
      const existingContest = await ContestModel.findOne({
        _id: contestId,
        problems: problemId,
        'participants._id': participationId,
      }).select('problems description sponsors submissions')

      if (!existingContest) {
        return Promise.reject(
          new CustomError(`Participation not found in this contest`, 404),
        )
      }
    }

    // let point = 0
    // let isCorrect = false
    // if (existingProblem.answer.type === 'options') {
    //   if (
    //     existingProblem.answer.options &&
    //     existingProblem.answer.options.correct === submission.getUserAnswer()
    //   ) {
    //     point = existingProblem.point.correct
    //     isCorrect = true
    //   } else {
    //     point = existingProblem.point.wrong
    //   }
    // } else if (existingProblem.answer.type === 'short') {
    //   if (
    //     existingProblem.answer.short &&
    //     existingProblem.answer.short.correct === submission.getUserAnswer()
    //   ) {
    //     point = existingProblem.point.correct
    //     isCorrect = true
    //   } else {
    //     point = existingProblem.point.wrong
    //   }
    // } else if (existingProblem.answer.type === 'trueFalse') {
    //   if (
    //     existingProblem.answer.trueFalse &&
    //     existingProblem.answer.trueFalse === submission.getUserAnswer()
    //   ) {
    //     point = existingProblem.point.correct
    //     isCorrect = true
    //   } else {
    //     point = existingProblem.point.wrong
    //   }
    // }

    // if (participationId) {
    //   const submission = await SubmissionModel.findOne({
    //     contest: contestId,
    //     participation: participationId,
    //     problem: problemId,
    //   })
    //   if (submission) {
    //     return Promise.reject(
    //       new CustomError(
    //         `You have already submitted this problem in this contest`,
    //         400,
    //       ),
    //     )
    //   }
    // }

    return SubmissionModel.create({
      problem: problemId,
      user: userId,
      contest: contestId,
      participation: participationId,
      second: second,
      userAnswer: submission.getUserAnswer(),
      point: 1,
      isCorrect: 1,
      attemptedAt: submission.getAttemptedAt() || new Date(),
    }).then((submission: ISubmission) => {
      ContestModel.findByIdAndUpdate(
        contestId,
        {
          $push: {
            submissions: submission._id,
          },
        },
        { new: true },
      ).then((contest: any) => {
        if (!contest) {
          return Promise.reject(
            new CustomError(`Contest with id ${contest._id} not found`, 404),
          )
        }
      })
      return submission
    })
  }

  const deleteSubmission = (id: string) => {
    if (!Types.ObjectId.isValid(id)) {
      return Promise.reject(
        new CustomError(`${id} is not a valid submission id`, 400),
      )
    }
    return SubmissionModel.findByIdAndDelete(id).then((submission: any) => {
      if (!submission) {
        return Promise.reject(
          new CustomError(`Submission with id ${id} not found`, 404),
        )
      }

      ContestModel.updateOne(
        { _id: submission.contest },
        { $pull: { submissions: id } },
      ).then((contest: any) => {
        if (!contest) {
          return Promise.reject(
            new CustomError(`Contest with id ${contest._id} not found`, 404),
          )
        }
      })

      return submission
    })
  }

  const findContestSubmissions = (userId: string, participationId: string) => {
    return SubmissionModel.find({
      user: userId,
      participation: participationId,
    }).then((submissions: any) => {
      if (!submissions) {
        return Promise.reject(
          new CustomError(
            `Submissions with user id ${userId} and participation id ${participationId} not found`,
            404,
          ),
        )
      }

      return submissions
    })
  }

  const findContestStanding = (contestId: string) => {
    return ContestModel.findById(contestId).select('submissions').populate({
      path: 'submissions',
      select: 'user point',
      populate: {
        path: 'user',
        select: 'firstName lastName username image',
      },
    })

  }

  return {
    findById,
    submit,
    deleteSubmission,
    findContestSubmissions,
  }
}

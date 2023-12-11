import { Types } from "mongoose";
import CustomError from "../../config/error";
import Contest, { IContest } from "@/domain/entities/contest";
import ContestModel from "../database/models/contest";

interface ViewAllContestParams {
  skip: number;
  limit: number;
  search?: string;
  sort?: Record<string, 1 | -1>;
}

export type IContestRepositoryImpl = () => {
  findById: (id: string) => Promise<IContest>;
  viewAllContest: (params: ViewAllContestParams) => Promise<IContest[]>;
  deleteContest: (id: string) => Promise<IContest>;
  updateContest: (
    id: string,
    contest: ReturnType<typeof Contest>
  ) => Promise<IContest>;
  createContest: (contest: ReturnType<typeof Contest>) => Promise<IContest>;
};

export default function contestRepositoryMongoDB() {
  const findById = (id: string): Promise<IContest> => {
    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid contest id`, 400);
    }
    return ContestModel.findById(id).then((contest: IContest | null) => {
      if (!contest) {
        throw new CustomError(`Contest with id ${id} not found`, 404);
      }
      return contest;
    });
  };

  const viewAllContest = (params: ViewAllContestParams) => {
    const { skip, limit, search, sort } = params;

    const query: { [key: string]: unknown } = {};
    if (search) {
      query.$or = [
        { source: { $regex: search, $options: "i" } },
        { details: { $regex: search, $options: "i" } },
      ];
    }

    return ContestModel.find(query)
      .sort(sort)
      .skip(skip)
      .limit(limit)
      .then((contests: IContest[]) => contests.map((contest) => contest));
  };

  const createContest = (contest: ReturnType<typeof Contest>) => {
    return ContestModel.create({
      title: contest.getTitle(),
      mode: contest.getMode(),
      description: contest.getDescription(),
      sponsor: contest.getSponsor(),
      problems: contest.getProblems(),
      startTime: contest.getStartTime(),
      duration: contest.getDuration(),
      participants: contest.getParticipants(),
      creator: contest.getCreator(),
    }).then((contest: IContest) => contest);
  };

  const deleteContest = (id: string) => {
    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid contest id`, 400);
    }

    return ContestModel.findByIdAndDelete(id).then((contest: any) => {
      if (!contest) {
        throw new CustomError(`Contest with id ${id} not found`, 404);
      }
      return contest;
    });
  };

  const updateContest = (id: string, contest: ReturnType<typeof Contest>) => {
    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid contest id`, 400);
    }

    return ContestModel.findByIdAndUpdate(id, contest, { new: true }).then(
      (contest: any) => {
        if (!contest) {
          throw new CustomError(`Contest with id ${id} not found`, 404);
        }
        return contest;
      }
    );
  };

  return {
    findById,
    viewAllContest,
    createContest,
    deleteContest,
    updateContest,
  };
}

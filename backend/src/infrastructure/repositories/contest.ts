import mongoose, { Types } from "mongoose";
import CustomError from "../../config/error";
import Contest, { IContest } from "../../domain/entities/contest";
import ContestModel from "../database/models/contest";

interface ViewAllContestParams {
  skip: number;
  limit: number;
  search?: string;
  sort?: Record<string, 1 | -1>;
}

export type IContestRepositoryImpl = () => {
  findById: (id: string) => Promise<IContest>;
  findContestInfo: (id: string) => Promise<IContest>;
  viewAllContest: (params: ViewAllContestParams) => Promise<IContest[]>;
  deleteContest: (id: string) => Promise<IContest>;
  updateContest: (
    id: string,
    contest: ReturnType<typeof Contest>
  ) => Promise<IContest>;
  createContest: (contest: ReturnType<typeof Contest>) => Promise<IContest>;
  addProblem: (id: string, problemId: string) => Promise<IContest>;
  removeProblem: (id: string, problemId: string) => Promise<IContest>;
  addParticipant: (id: string, userId: string) => Promise<IContest>;
  removeParticipant: (id: string, userId: string) => Promise<IContest>;
  getParticipants: (id: string, query: any) => Promise<IContest>;
  getProblems: (id: string, query: any) => Promise<IContest>;
  getCreator: (id: string) => Promise<IContest>;
};

export default function contestRepositoryMongoDB() {
  const findById = (id: string): Promise<IContest> => {
    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid contest id`, 400);
    }
    return ContestModel.findById(id)
    .select('-participants -problems')
    .then((contest: IContest | null) => {
      if (!contest) {
        throw new CustomError(`Contest with id ${id} not found`, 404);
      }
      return contest;
    });
  };

  const findContestInfo  = (id: string): Promise<IContest> => {

    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid contest id`, 400);
    }

   return ContestModel.aggregate([
      { $match: { _id: new mongoose.Types.ObjectId(id) } },
      {
        $lookup: {
          from: 'participants',
          localField: 'participants',
          foreignField: '_id',
          as: 'participants',
        },
      },
      {
        $lookup: {
          from: 'users',
          localField: 'creator',
          foreignField: '_id',
          as: 'creator',
          let: { creatorId: '$creator' },
          pipeline: [
            {
              $match: {
                $expr: { $eq: ['$_id', '$$creatorId'] },
              },
            },
            {
              $project: {
                password: 0, 
                createdAt: 0,
                updatedAt: 0,
                __v: 0, 
              },
            },
          ],
        },
      },
      {
        $project: {
          participants: { $ifNull: ['$participants', []] },
          problems: { $ifNull: ['$problems', []] },
          title: 1,
          mode: 1,
          description: 1,
          sponsor: 1,
          image: 1,
          startTime: 1,
          duration: 1,
          creator: { $arrayElemAt: ['$creator', 0] },
        },
      },
      {
        $addFields: {
          numberOfParticipants: { $size: '$participants' },
          numberOfProblems: { $size: '$problems' },
        },
      },
      {
        $project: {
          participants: 0,
          problems: 0,
        },
      },
    ])
    .then((contest: IContest[]) => {
      if (!contest) {
        throw new CustomError(`Contest with id ${id} not found`, 404);
      }
      return contest[0];
    });
    
    
  }

  const viewAllContest = (params: ViewAllContestParams) => {
    const { skip, limit, search, sort } = params;
  
    const query: { [key: string]: unknown } = {};
    if (search) {

      query.title = new RegExp(search, 'i');
    }
  
    return ContestModel.find(query)
      .sort(sort)
      .skip(skip)
      .limit(limit)
      .select('-participants -problems')
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
      image: contest.getImage(),
    }).then((contest: IContest) => contest);
  };

  const deleteContest = (id: string) => {
    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid contest id`, 400);
    }

    return ContestModel.findByIdAndDelete(id)
    .select('-participants -problems')
    .then((contest: any) => {
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

    return ContestModel.findByIdAndUpdate(id, {
      title: contest.getTitle(),
      mode: contest.getMode(),
      description: contest.getDescription(),
      sponsor: contest.getSponsor(),
      startTime: contest.getStartTime(),
      duration: contest.getDuration(),
      creator: contest.getCreator(),
      image: contest.getImage(),
    }, 
     { new: true })
     .select('-participants -problems')
     .then(
      (contest: any) => {
        if (!contest) {
          throw new CustomError(`Contest with id ${id} not found`, 404);
        }
        return contest;
      }
    );
  };

  const addProblem = async (id: string, problemId: string) => {
    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid contest id`, 400);
    }

    if (!Types.ObjectId.isValid(problemId)) {
      throw new CustomError(`${problemId} is not a valid problem id`, 400);
    }

    const exisitingContest = await ContestModel.findById(id).select('-participants -description -sponsor')

    if (!exisitingContest) {
      throw new CustomError(`Contest with id ${id} not found`, 404);
    } 

    if (exisitingContest.problems.includes(problemId))
    throw new CustomError(`Problem with id ${problemId} already exists`, 400);

    exisitingContest.problems.push(problemId)
    return await exisitingContest.save().then(contest => contest as IContest)
  }

  const removeProblem = async (id: string, problemId: string) => {
    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid contest id`, 400);
    }

    if (!Types.ObjectId.isValid(problemId)) {
      throw new CustomError(`${problemId} is not a valid problem id`, 400);
    }

    const exisitingContest = await ContestModel.findById(id).select('-participants -description -sponsor')

    if (!exisitingContest) {
      throw new CustomError(`Contest with id ${id} not found`, 404);
    }

    if (!exisitingContest.problems.includes(problemId))
    throw new CustomError(`Problem with id ${problemId} does not exist`, 400);

    exisitingContest.problems = exisitingContest.problems.filter((problem: string) => problem.toString() !== problemId) as [string]
    return exisitingContest.save().then(contest => contest as IContest)
  }

  const addParticipant = async (id: string, userId: string) => {
    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid contest id`, 400);
    }

    if (!Types.ObjectId.isValid(userId)) {
      throw new CustomError(`${userId} is not a valid user id`, 400);
    }


    const exisitingContest = await ContestModel.findById(id).select('-problems -description -sponsor, -creator')

    if (!exisitingContest) 
      throw new CustomError(`Contest with id ${id} not found`, 404);

    if (exisitingContest.participants === undefined) 
      throw new CustomError(`Contest with id ${id} does not have participants`, 404);

    if (exisitingContest.participants.find((participant: any) => participant.user.toString() === userId))
      throw new CustomError(`User with id ${userId} already exists`, 400);

    exisitingContest.participants.push({
      user: userId,
      registeredAt: new Date()
    })

    return await exisitingContest.save().then(contest => contest as IContest)
    
  }

  const removeParticipant = async (id: string, userId: string) => {

    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid contest id`, 400);
    }

    if (!Types.ObjectId.isValid(userId)) {
      throw new CustomError(`${userId} is not a valid user id`, 400);
    }

    const exisitingContest = await ContestModel.findOne({ _id: id, 'participants.user': userId }).select('-problems -description -sponsor')
    if (!exisitingContest) 
      throw new CustomError(`Contest with id ${id} not found`, 404);

    if (exisitingContest.participants === undefined || exisitingContest.participants.length === 0)
      throw new CustomError(`Contest with id ${id} does not have participants`, 404);

    if (!exisitingContest.participants.find((participant: any) => participant.user.toString() === userId))
      throw new CustomError(`User with id ${userId} does not exist`, 400);

    exisitingContest.participants = exisitingContest.participants.filter((participant: any) => participant.user.toString() !== userId) as [any]
    return await exisitingContest.save().then(contest => {
      contest.participants = []
      return contest as IContest
    })
  }

  const parseSortParameter = (
    sort: string | undefined
  ): Record<string, 1 | -1> => {
    if (sort) {
      const [field, order] = sort.split(':')
      const sortOrder = order === 'desc' ? -1 : 1

      return { [field]: sortOrder }
    }

    return { createdAt: 1 }
  }

  const getParticipants = (id: string, query: any): Promise<IContest> => {
    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid contest id`, 400);
    }

    const { skip, limit, sort } = query;

    const options = {
      skip: parseInt(typeof skip === "string" ? skip : "0", 10),
      limit: parseInt(typeof limit === "string" ? limit : "10", 10),
      sort: typeof sort === "string" ? parseSortParameter(sort) : undefined,
    };
    
    return ContestModel.findById(id)
      .select('-problems -description -sponsor -participants.submissions -participants._id')
      .populate({
        path: 'participants.user',
        select: '-password -createdAt -updatedAt -__v',
        options: options
      })
      .then((contest: IContest | null) => {
        if (!contest) {
          throw new CustomError(`Contest with id ${id} not found`, 404);
        }
        return contest;
      });
  };

  const getProblems = (id: string, query: any): Promise<IContest> => {
    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid contest id`, 400);
    }

    const { skip, limit, sort } = query;

    const options = {
      skip: parseInt(typeof skip === "string" ? skip : "0", 10),
      limit: parseInt(typeof limit === "string" ? limit : "10", 10),
      sort: typeof sort === "string" ? parseSortParameter(sort) : undefined,
    };

    return ContestModel.findById(id)
      .select('-participants -description -sponsor')
      .populate({
        path: 'problems',
        select: '-createdAt -updatedAt -__v',
        options: options
      })
      .then((contest: IContest | null) => {
        if (!contest) {
          throw new CustomError(`Contest with id ${id} not found`, 404);
        }
        return contest;
      });
  };

  const getCreator = (id: string) => {
    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid contest id`, 400);
    }

    return ContestModel.findById(id).select('-participants -description -sponsor -problems')
      .populate({
        path: 'creator',
        select: '-password -createdAt -updatedAt -__v'
      }).then((contest: any) => {
      if (!contest) {
        throw new CustomError(`Contest with id ${id} not found`, 404);
      }
      return contest;
    });

   
  }

  return {
    findById,
    viewAllContest,
    createContest,
    deleteContest,
    updateContest,
    addProblem,
    removeProblem,
    addParticipant,
    removeParticipant,
    getParticipants,
    getProblems,
    getCreator,
    findContestInfo
  };
}

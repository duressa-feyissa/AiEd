import mongoose, { Types } from 'mongoose'
import CustomError from '../../config/error'
import Contest, {
  IContest,
  IContestRegistration,
} from '../../domain/entities/contest'
import ContestModel from '../database/models/contest'

interface ViewAllContestParams {
  skip: number
  limit: number
  search?: string
  sort?: Record<string, 1 | -1>
}

export type IContestRepositoryImpl = () => {
  findById: (id: string) => Promise<IContest>
  findContestInfo: (id: string) => Promise<IContest>
  viewAllContest: (params: ViewAllContestParams) => Promise<IContest[]>
  deleteContest: (id: string) => Promise<IContest>
  updateContest: (
    id: string,
    contest: ReturnType<typeof Contest>,
  ) => Promise<IContest>
  createContest: (contest: ReturnType<typeof Contest>) => Promise<IContest>
  addProblem: (id: string, problemId: string) => Promise<IContest>
  removeProblem: (id: string, problemId: string) => Promise<IContest>
  getProblems: (id: string, query: any) => Promise<IContest>
  getCreator: (id: string) => Promise<IContest>
  registerParticipantForContest: (
    contestId: string,
    userId: string,
    data: IContestRegistration,
  ) => Promise<any>
  getContestStanding: (
    contestId: string,
    skip: number,
    limit: number,
    second: number,
  ) => Promise<any>
  getContestSubmissions: (
    contestId: string,
    participantId: string,
  ) => Promise<any>
}

export default function contestRepositoryMongoDB() {
  // Verified
  const findById = (id: string): Promise<IContest> => {
    if (!Types.ObjectId.isValid(id)) {
      return Promise.reject(new CustomError(`${id} is not a valid id`, 400))
    }
    return ContestModel.findById(id)
      .select('-participants -problems')
      .then((contest: IContest | null) => {
        if (!contest) {
          return Promise.reject(
            new CustomError(`Contest with id ${id} not found`, 404),
          )
        }
        return contest
      })
  }

  // Verified
  const findContestInfo = (id: string): Promise<IContest> => {
    if (!Types.ObjectId.isValid(id)) {
      return Promise.reject(new CustomError(`${id} is not a valid id`, 400))
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
    ]).then((contest: IContest[]) => {
      if (!contest) {
        return Promise.reject(
          new CustomError(`Contest with id ${id} not found`, 404),
        )
      }
      return contest[0]
    })
  }

  // Verified
  const viewAllContest = (params: ViewAllContestParams) => {
    const { skip, limit, search, sort } = params

    const query: { [key: string]: unknown } = {}
    if (search) {
      query.title = new RegExp(search, 'i')
    }

    return ContestModel.find(query)
      .select('-participants -problems')
      .sort(sort)
      .skip(skip)
      .limit(limit)
      .then((contests: IContest[]) => contests.map(contest => contest))
  }

  // Verified
  const createContest = (contest: ReturnType<typeof Contest>) => {
    return ContestModel.create({
      title: contest.getTitle(),
      mode: contest.getMode(),
      description: contest.getDescription(),
      sponsor: contest.getSponsor(),
      problems: contest.getProblems(),
      participants: contest.getParticipants(),
      startTime: contest.getStartTime(),
      duration: contest.getDuration(),
      creator: contest.getCreator(),
      image: contest.getImage(),
    }).then((contest: IContest) => contest)
  }

  // Verified
  const deleteContest = (id: string) => {
    if (!Types.ObjectId.isValid(id)) {
      return Promise.reject(new CustomError(`${id} is not a valid id`, 400))
    }

    return ContestModel.findByIdAndDelete(id)
      .select('-participants -problems')
      .then((contest: any) => {
        if (!contest) {
          return Promise.reject(
            new CustomError(`Contest with id ${id} not found`, 404),
          )
        }
        return contest
      })
  }

  // Verified
  const updateContest = (id: string, contest: ReturnType<typeof Contest>) => {
    if (!Types.ObjectId.isValid(id)) {
      return Promise.reject(new CustomError(`${id} is not a valid id`, 400))
    }

    return ContestModel.findByIdAndUpdate(
      id,
      {
        title: contest.getTitle(),
        mode: contest.getMode(),
        description: contest.getDescription(),
        sponsor: contest.getSponsor(),
        startTime: contest.getStartTime(),
        duration: contest.getDuration(),
        creator: contest.getCreator(),
        image: contest.getImage(),
      },
      { new: true },
    )
      .select('-participants -problems')
      .then((contest: any) => {
        if (!contest) {
          return Promise.reject(
            new CustomError(`Contest with id ${id} not found`, 404),
          )
        }
        return contest
      })
  }

  // Verified
  const addProblem = async (id: string, problemId: string) => {
    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid contest id`, 400)
    }

    if (!Types.ObjectId.isValid(problemId)) {
      return Promise.reject(
        new CustomError(`${problemId} is not a valid problem id`, 400),
      )
    }

    const exisitingContest = await ContestModel.findById(id).select(
      '-participants -description -sponsor',
    )

    if (!exisitingContest) {
      return Promise.reject(
        new CustomError(`Contest with id ${id} not found`, 404),
      )
    }

    if (exisitingContest.problems.includes(problemId))
      return Promise.reject(
        new CustomError(`Problem with id ${problemId} already exists`, 400),
      )

    exisitingContest.problems.push(problemId)
    return await exisitingContest.save().then(contest => contest as IContest)
  }

  // Verified
  const removeProblem = async (id: string, problemId: string) => {
    if (!Types.ObjectId.isValid(id))
      return Promise.reject(
        new CustomError(`${id} is not a valid contest id`, 400),
      )

    if (!Types.ObjectId.isValid(problemId))
      return Promise.reject(
        new CustomError(`${problemId} is not a valid problem id`, 400),
      )

    const exisitingContest = await ContestModel.findById(id).select(
      '-participants -description -sponsor',
    )

    if (!exisitingContest)
      return Promise.reject(
        new CustomError(`Contest with id ${id} not found`, 404),
      )

    if (!exisitingContest.problems.includes(problemId))
      return Promise.reject(
        new CustomError(`Problem with id ${problemId} does not exist`, 400),
      )

    exisitingContest.problems = exisitingContest.problems.filter(
      (problem: string) => problem.toString() !== problemId,
    ) as [string]
    return exisitingContest.save().then(contest => contest as IContest)
  }

  const parseSortParameter = (
    sort: string | undefined,
  ): Record<string, 1 | -1> => {
    if (sort) {
      const [field, order] = sort.split(':')
      const sortOrder = order === 'desc' ? -1 : 1

      return { [field]: sortOrder }
    }

    return { createdAt: 1 }
  }

  // verified
  const getProblems = (id: string, query: any): Promise<IContest> => {
    if (!Types.ObjectId.isValid(id))
      return Promise.reject(
        new CustomError(`${id} is not a valid contest id`, 400),
      )

    const { skip, limit, sort } = query

    const options = {
      skip: parseInt(typeof skip === 'string' ? skip : '0', 10),
      limit: parseInt(typeof limit === 'string' ? limit : '10', 10),
      sort: typeof sort === 'string' ? parseSortParameter(sort) : undefined,
    }

    return ContestModel.findById(id)
      .select('-participants -description -sponsor')
      .populate({
        path: 'problems',
        select: '-createdAt -updatedAt -__v',
        options: options,
      })
      .then((contest: IContest | null) => {
        if (!contest) {
          return Promise.reject(
            new CustomError(`Contest with id ${id} not found`, 404),
          )
        }
        return contest
      })
  }

  // verified
  const getCreator = (id: string) => {
    if (!Types.ObjectId.isValid(id))
      return Promise.reject(
        new CustomError(`${id} is not a valid contest id`, 400),
      )

    return ContestModel.findById(id)
      .select('-participants -description -sponsor -problems')
      .populate({
        path: 'creator',
        select: '-password -createdAt -updatedAt -__v',
      })
      .then((contest: any) => {
        if (!contest) {
          return Promise.reject(
            new CustomError(`Contest with id ${id} not found`, 404),
          )
        }
        return contest
      })
  }

  const registerParticipantForContest = (
    contestId: string,
    userId: string,
    data: IContestRegistration,
  ) => {
    const currentTime = new Date().getTime()

    if (!Types.ObjectId.isValid(contestId)) {
      return Promise.reject(
        new CustomError(`${contestId} is not a valid contest id`, 400),
      )
    }

    if (!Types.ObjectId.isValid(userId)) {
      return Promise.reject(
        new CustomError(`${userId} is not a valid user id`, 400),
      )
    }

    if (data.type !== 'live' && data.type !== 'virtual') {
      return Promise.reject(
        new CustomError(
          `Contest with id ${contestId} is not live or virtual`,
          400,
        ),
      )
    }

    if (
      data.type === 'virtual' &&
      data.startAt &&
      data.startAt.getTime() < currentTime
    ) {
      return Promise.reject(
        new CustomError(
          `Contest with id ${contestId} has already started`,
          400,
        ),
      )
    }

    return ContestModel.findById(contestId)
      .select('-submissions -problems -creator -description -sponsor')
      .then((contest: any) => {
        if (!contest) {
          return Promise.reject(
            new CustomError(`Contest with id ${contestId} not found`, 404),
          )
        }

        const participant = contest.participants.find(
          (participant: any) => participant.user.toString() === userId,
        )
        if (data.type === 'live' && participant) {
          return Promise.reject(
            new CustomError(
              `User with id ${userId} is already registered for this contest`,
              400,
            ),
          )
        }

        if (data.type == 'live' && currentTime > contest.startTime.getTime()) {
          return Promise.reject(
            new CustomError(
              `Contest with id ${contestId} has already started`,
              400,
            ),
          )
        }

        if (
          data.type == 'virtual' &&
          currentTime <
            contest.startTime.getTime() + contest.duration * 60 * 1000
        ) {
          return Promise.reject(
            new CustomError(
              `Contest with id ${contestId} has not allowed for virtual participation`,
              400,
            ),
          )
        }

        if (
          contest.participants.find(
            (p: any) =>
              p.user.toString() === userId &&
              p.type === 'virtual' &&
              p.startAt.getTime() + contest.duration * 60 * 1000 < currentTime,
          )
        )
          return Promise.reject(
            new CustomError(
              `User with id ${userId} has already participated in this contest`,
              400,
            ),
          )
        let date = new Date()
        date.setMinutes(date.getMinutes() + 5)

        const newParticipant = {
          user: userId,
          isRegistered: true,
          registeredAt: new Date(),
          type: data.type,
          startAt: data.startAt
            ? data.startAt.setMinutes(date.getMinutes() + 5)
            : contest.startTime,
        }

        contest.participants.push(newParticipant)

        return contest.save().then((contest: any) => {
          return {
            title: contest.title,
            creator: contest.creator,
            startAt: newParticipant.startAt,
            user: newParticipant.user,
            type: newParticipant.type,
            isRegistered: newParticipant.isRegistered,
            registeredAt: newParticipant.registeredAt,
            image: contest.image,
          } as any
        })
      })
  }

  const getContestStanding = async (
    contestId: string,
    skip: number,
    limit: number,
    second: number,
  ) => {
    if (!Types.ObjectId.isValid(contestId)) {
      return Promise.reject(
        new CustomError(`${contestId} is not a valid contest id`, 400),
      )
    }

    return ContestModel.aggregate([
      {
        $match: {
          _id: new mongoose.Types.ObjectId(contestId),
        },
      },
      {
        $lookup: {
          from: 'submissions',
          localField: 'submissions',
          foreignField: '_id',
          as: 'submissionsData',
        },
      },
      {
        $unwind: '$submissionsData',
      },
      {
        $lookup: {
          from: 'users',
          localField: 'submissionsData.user',
          foreignField: '_id',
          as: 'userData',
        },
      },
      {
        $group: {
          _id: '$submissionsData.participation',
          totalPoints: { $sum: '$submissionsData.point' },
          lastSecond: { $last: '$submissionsData.second' },
          user: { $first: { $arrayElemAt: ['$userData', 0] } },
        },
      },
      {
        $sort: { lastSecond: 1 },
      },
      {
        $skip: 0,
      },
      {
        $limit: 10,
      },
      {
        $project: {
          _id: 0,
          userId: '$user._id',
          participation: '$_id',
          totalPoints: 1,
          lastSecond: 1,
          user: {
            firstName: '$user.firstName',
            lastName: '$user.lastName',
            image: '$user.image',
          },
        },
      },
    ]).then((contest: any) => {
      if (!contest) {
        return Promise.reject(
          new CustomError(`Contest with id ${contestId} not found`, 404),
        )
      }
      return contest
    })
  }

  const getContestSubmissions = async (
    contestId: string,
    participantId: string,
  ) => {
    if (!Types.ObjectId.isValid(contestId)) {
      return Promise.reject(
        new CustomError(`${contestId} is not a valid contest id`, 400),
      )
    }

    if (!Types.ObjectId.isValid(participantId)) {
      return Promise.reject(
        new CustomError(`${participantId} is not a valid participant id`, 400),
      )
    }

    return ContestModel.aggregate([
      {
        $match: {
          _id: new mongoose.Types.ObjectId(contestId),
        },
      },
      {
        $lookup: {
          from: 'submissions',
          localField: 'submissions',
          foreignField: '_id',
          as: 'submissionsData',
        },
      },
      {
        $unwind: '$submissionsData',
      },
      {
        $match: {
          'submissionsData.participation': new mongoose.Types.ObjectId(
            participantId,
          ),
        },
      },
      {
        $group: {
          _id: '$submissionsData.participation',
          totalPoints: { $sum: '$submissionsData.point' },
          submissions: { $push: '$submissionsData' },
        },
      },
    ]).then((contest: any) => {
      if (!contest || contest.length === 0) {
        return Promise.reject(
          new CustomError(`Contest with id ${contestId} not found`, 404),
        )
      }
      return contest[0]
    })
  }

  return {
    findById,
    viewAllContest,
    createContest,
    deleteContest,
    updateContest,
    addProblem,
    removeProblem,
    getProblems,
    getCreator,
    findContestInfo,
    registerParticipantForContest,
    getContestStanding,
    getContestSubmissions,
  }
}

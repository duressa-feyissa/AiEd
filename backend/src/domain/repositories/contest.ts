import contestRepositoryMongoDB from '../../infrastructure/repositories/contest'
import Contest, { IContest, IContestRegistration } from '../entities/contest'

interface ViewAllContestParams {
  skip: number
  limit: number
  search?: string
  sort?: Record<string, 1 | -1>
}

export type IContestRepository = (
  repository: ReturnType<typeof contestRepositoryMongoDB>,
) => {
  findById: (id: string) => Promise<IContest>
  viewAllContest: (params: ViewAllContestParams) => Promise<IContest[]>
  findContestInfo: (id: string) => Promise<IContest>
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

export default function contestDbRepository(
  repository: ReturnType<typeof contestRepositoryMongoDB>,
) {
  const findById = (id: string): Promise<IContest> => repository.findById(id)

  const viewAllContest = (params: ViewAllContestParams) =>
    repository.viewAllContest(params)

  const deleteContest = (id: string) => repository.deleteContest(id)

  const updateContest = (id: string, contest: ReturnType<typeof Contest>) =>
    repository.updateContest(id, contest)

  const createContest = (contest: ReturnType<typeof Contest>) =>
    repository.createContest(contest)

  const addProblem = (id: string, problemId: string) =>
    repository.addProblem(id, problemId)

  const removeProblem = (id: string, problemId: string) =>
    repository.removeProblem(id, problemId)

  const getProblems = (id: string, query: any) =>
    repository.getProblems(id, query)

  const getCreator = (id: string) => repository.getCreator(id)

  const findContestInfo = (id: string) => repository.findContestInfo(id)

  const registerParticipantForContest = (
    contestId: string,
    userId: string,
    data: IContestRegistration,
  ) => repository.registerParticipantForContest(contestId, userId, data)

  const getContestStanding = (
    contestId: string,
    skip: number,
    limit: number,
    second: number,
  ) => repository.getContestStanding(contestId, skip, limit, second)

  const getContestSubmissions = (
    contestId: string,
    participantId: string,
  ) =>
    repository.getContestSubmissions(contestId,  participantId)

  return {
    findById,
    viewAllContest,
    deleteContest,
    updateContest,
    createContest,
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

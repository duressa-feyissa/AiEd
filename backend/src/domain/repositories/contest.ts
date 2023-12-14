import contestRepositoryMongoDB from "../../infrastructure/repositories/contest"
import Contest, { IContest } from "../entities/contest"

interface ViewAllContestParams {
    skip: number
    limit: number
    search?: string
    sort?: Record<string, 1 | -1>
  }

export type IContestRepository = (
    repository: ReturnType<typeof contestRepositoryMongoDB>
) => {
    findById: (id: string) => Promise<IContest>
    viewAllContest: (params: ViewAllContestParams) => Promise<IContest[]>
    findContestInfo: (id: string) => Promise<IContest>;
    deleteContest: (id: string) => Promise<IContest>
    updateContest: (id: string, contest: ReturnType<typeof Contest>) => Promise<IContest>
    createContest: (contest: ReturnType<typeof Contest>) => Promise<IContest>
    addProblem: (id: string, problemId: string) => Promise<IContest>;
    removeProblem: (id: string, problemId: string) => Promise<IContest>;
    addParticipant: (id: string, userId: string) => Promise<IContest>;
    removeParticipant: (id: string, userId: string) => Promise<IContest>;
    getParticipants: (id: string, query: any) => Promise<IContest>;
    getProblems: (id: string, query:any) => Promise<IContest>;
    getCreator: (id: string) => Promise<IContest>;
    
}

export default function contestDbRepository(repository: ReturnType<typeof contestRepositoryMongoDB>) {

    const findById = (id: string): Promise<IContest> =>
        repository.findById(id)
    
    const viewAllContest = (params: ViewAllContestParams) =>
    repository.viewAllContest(params)

    const deleteContest = (id: string) => repository.deleteContest(id)

    const updateContest = (id: string, contest: ReturnType<typeof Contest>) => repository.updateContest(id, contest)

    const createContest = (contest: ReturnType<typeof Contest>) => repository.createContest(contest)

    const addProblem = (id: string, problemId: string) => repository.addProblem(id, problemId)

    const removeProblem = (id: string, problemId: string) => repository.removeProblem(id, problemId)

    const addParticipant = (id: string, userId: string) => repository.addParticipant(id, userId)

    const removeParticipant = (id: string, userId: string) => repository.removeParticipant(id, userId)

    const getParticipants = (id: string, query: any) => repository.getParticipants(id, query)

    const getProblems = (id: string, query: any) => repository.getProblems(id, query)

    const getCreator = (id: string) => repository.getCreator(id)

    const findContestInfo = (id: string) => repository.findContestInfo(id)

    return {
        findById,
        viewAllContest,
        deleteContest,
        updateContest,
        createContest,
        addProblem,
        removeProblem,
        addParticipant,
        removeParticipant,
        getParticipants,
        getProblems,
        getCreator,
        findContestInfo
    }
}
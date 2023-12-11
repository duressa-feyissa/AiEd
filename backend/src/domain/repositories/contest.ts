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
    deleteContest: (id: string) => Promise<IContest>
    updateContest: (id: string, contest: ReturnType<typeof Contest>) => Promise<IContest>
    createContest: (contest: ReturnType<typeof Contest>) => Promise<IContest>
}

export default function contestDbRepository(repository: ReturnType<typeof contestRepositoryMongoDB>) {

    const findById = (id: string): Promise<IContest> =>
        repository.findById(id)
    
    const viewAllContest = (params: ViewAllContestParams) =>
    repository.viewAllContest(params)

    const deleteContest = (id: string) => repository.deleteContest(id)

    const updateContest = (id: string, contest: ReturnType<typeof Contest>) => repository.updateContest(id, contest)

    const createContest = (contest: ReturnType<typeof Contest>) => repository.createContest(contest)

    return {
        findById,
        viewAllContest,
        deleteContest,
        updateContest,
        createContest,
    }
}
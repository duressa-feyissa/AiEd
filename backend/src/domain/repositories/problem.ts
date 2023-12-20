import problemRepositoryMongoDB from '../../infrastructure/repositories/problem'
import Problem, { IProblem } from '../entities/problem'

interface ViewAllProblemParams {
  skip: number
  limit: number
  search?: string
  sort?: Record<string, 1 | -1>
  difficulty?: string[]
  grade?: string[]
  courses?: string[]
  target?: string[]
  source?: string[]
  contentType?: string[]
  year?: string[]
}

export type IProblemRepository = (
  repository: ReturnType<typeof problemRepositoryMongoDB>,
) => {
  findById: (id: string) => Promise<IProblem>
  viewAllProblem: (params: ViewAllProblemParams) => Promise<IProblem[]>
  deleteProblem: (id: string) => Promise<IProblem>
  updateProblem: (
    id: string,
    problem: ReturnType<typeof Problem>,
  ) => Promise<IProblem>
  createProblem: (problem: ReturnType<typeof Problem>) => Promise<IProblem>
}

export default function problemDbRepository(
  repository: ReturnType<typeof problemRepositoryMongoDB>,
) {
  const findById = (id: string): Promise<IProblem> => repository.findById(id)

  const viewAllProblem = (params: ViewAllProblemParams) =>
    repository.viewAllProblem(params)

  const deleteProblem = (id: string) => repository.deleteProblem(id)

  const updateProblem = (id: string, problem: ReturnType<typeof Problem>) =>
    repository.updateProblem(id, problem)

  const createProblem = (problem: ReturnType<typeof Problem>) =>
    repository.createProblem(problem)

  return {
    findById,
    viewAllProblem,
    deleteProblem,
    updateProblem,
    createProblem,
  }
}

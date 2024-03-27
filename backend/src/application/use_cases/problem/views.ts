import problemDbRepository from '../../../infrastructure/repositories/problem'

interface ViewAllProblemsParams {
  skip: number
  limit: number
  search?: string
  sort?: Record<string, 1 | -1>
}

export default function viewAllProblem(
  params: ViewAllProblemsParams,
  problemRepository: ReturnType<typeof problemDbRepository>,
) {
  return problemRepository.viewAllProblem(params)
}

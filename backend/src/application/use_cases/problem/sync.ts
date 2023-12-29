import problemDbRepository from '../../../infrastructure/repositories/problem'

export default function syncProblem(
  last: Date,
  skip: number,
  limit: number,
  problemRepository: ReturnType<typeof problemDbRepository>,
) {
  return problemRepository.syncProblem(last, skip, limit)
}

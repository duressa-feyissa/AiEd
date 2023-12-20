import contestDbRepository from '../../../infrastructure/repositories/contest'

export default function removeProblemToContest(
  id: string,
  userId: string,
  contestRepository: ReturnType<typeof contestDbRepository>,
) {
  return contestRepository.removeProblem(id, userId)
}

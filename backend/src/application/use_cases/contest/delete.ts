import contestDbRepository from '../../../infrastructure/repositories/contest'

export default function removeContest(
  id: string,
  contestRepository: ReturnType<typeof contestDbRepository>,
) {
  return contestRepository.deleteContest(id)
}

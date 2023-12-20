import contestDbRepository from '../../../infrastructure/repositories/contest'

export default function getContestInfo(
  id: string,
  contestRepository: ReturnType<typeof contestDbRepository>,
) {
  return contestRepository.findContestInfo(id)
}

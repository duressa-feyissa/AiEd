import contestDbRepository from '../../../infrastructure/repositories/contest'

export default function getContestStanding(
  id: string,
  skip: number,
  limit: number,
  second: number,
  contestRepository: ReturnType<typeof contestDbRepository>,
) {
  return contestRepository.getContestStanding(id, skip, limit, second)
}

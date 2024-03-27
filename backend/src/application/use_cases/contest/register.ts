import { IContestRegistration } from '../../../domain/entities/contest'
import contestDbRepository from '../../../infrastructure/repositories/contest'

export default function registerToContest(
  id: string,
  userId: string,
  data: IContestRegistration,
  contestRepository: ReturnType<typeof contestDbRepository>,
) {
  return contestRepository.registerParticipantForContest(id, userId, data)
}

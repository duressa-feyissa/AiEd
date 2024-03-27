
import contestDbRepository from '../../../infrastructure/repositories/contest'

export default function getContestSubmissions(
    id: string,
    participantId: string,
  contestRepository: ReturnType<typeof contestDbRepository>,
) {
  return contestRepository.getContestSubmissions(id, participantId)
}

import contestDbRepository from "../../../infrastructure/repositories/contest";

export default function removeParticipantToContest(
  id: string,
  userId: string,
  contestRepository: ReturnType<typeof contestDbRepository>
) {
  return contestRepository.removeParticipant(id, userId);
}

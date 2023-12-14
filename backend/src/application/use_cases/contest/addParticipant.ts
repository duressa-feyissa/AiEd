import contestDbRepository from "../../../infrastructure/repositories/contest";

export default function addParticipantToContest(
  id: string,
  userId: string,
  contestRepository: ReturnType<typeof contestDbRepository>
) {
  return contestRepository.addParticipant(id, userId);
}

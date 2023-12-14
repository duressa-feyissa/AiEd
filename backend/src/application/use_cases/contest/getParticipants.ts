import contestDbRepository from "../../../infrastructure/repositories/contest";

export default function getContestParticipant(
  id: string,
  query: any,
  contestRepository: ReturnType<typeof contestDbRepository>
) {
  return contestRepository.getParticipants(id, query);
}

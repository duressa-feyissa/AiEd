import contestDbRepository from "../../../infrastructure/repositories/contest";

export default function getContestProblems(
  id: string,
  query: any,
  contestRepository: ReturnType<typeof contestDbRepository>
) {
  return contestRepository.getProblems(id, query);
}

import contestDbRepository from "../../../infrastructure/repositories/contest";

export default function addProblemToContest(
  id: string,
  userId: string,
  contestRepository: ReturnType<typeof contestDbRepository>
) {
  return contestRepository.addProblem(id, userId);
}

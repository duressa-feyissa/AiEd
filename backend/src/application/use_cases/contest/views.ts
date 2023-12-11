import contestDbRepository from "../../../infrastructure/repositories/contest";

interface ViewAllContestsParams {
  skip: number;
  limit: number;
  search?: string;
  sort?: Record<string, 1 | -1>;
}

export default function viewAllContest(
  params: ViewAllContestsParams,
  contestRepository: ReturnType<typeof contestDbRepository>
) {
  return contestRepository.viewAllContest(params);
}

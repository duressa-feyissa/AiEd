import CustomError from "../../../config/error";
import Contest, { IContest } from "../../../domain/entities/contest";
import contestDbRepository from "../../../infrastructure/repositories/contest";
import validateContest from "../../service/validator/contest";

export default function updateContest(
  id: string,
  contest: IContest,
  contestRepository: ReturnType<typeof contestDbRepository>
) {
  const { error } = validateContest(contest);
  if (error) throw new CustomError(error.details[0].message, 400);

  const newContest = Contest(contest);
  return contestRepository.updateContest(id, newContest);
}

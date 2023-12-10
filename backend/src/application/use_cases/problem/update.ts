import CustomError from '../../../config/error';
import Problem, { IProblem } from '../../../domain/entities/problem';
import problemDbRepository from "../../../infrastructure/repositories/problem";
import validateProblem from '../../service/validator/problem';

export default function updateProblem(
    id: string,
  problem: IProblem,
  problemRepository: ReturnType<typeof problemDbRepository>,
) {
  const { error } = validateProblem(problem);
  if (error) throw new CustomError(error.details[0].message, 400);

  const newProblem = Problem(problem);
  return problemRepository.updateProblem(id, newProblem);
}

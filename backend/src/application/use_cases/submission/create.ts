import { validateSubmission } from '../../../application/service/validator/submission'
import CustomError from '../../../config/error'
import Submission, { ISubmission } from '../../../domain/entities/submission'
import submissionDbRepository from '../../../domain/repositories/submission'

export default function createSubmission(
  submission: ISubmission,
  submissionRepository: ReturnType<typeof submissionDbRepository>,
) {
  const { error } = validateSubmission(submission)
  if (error) throw new CustomError(error.details[0].message, 400)

  const newSubmission = Submission(submission)

  return submissionRepository.submit(newSubmission)
}

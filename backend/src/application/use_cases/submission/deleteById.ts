import submissionDbRepository from '../../../domain/repositories/submission'

export default function removeSubmission(
  id: string,
  submissionRepository: ReturnType<typeof submissionDbRepository>,
) {
  return submissionRepository.deleteSubmission(id)
}

import submissionDbRepository from '../../../domain/repositories/submission'

export default function findById(
  id: string,
  submissionRepository: ReturnType<typeof submissionDbRepository>,
) {
  return submissionRepository.findById(id)
}

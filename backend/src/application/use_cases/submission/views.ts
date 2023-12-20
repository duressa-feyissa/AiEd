import submissionDbRepository from '../../../domain/repositories/submission'

export default function viewContestSubmission(
  userId: string,
  participationId: string,
  submissionRepository: ReturnType<typeof submissionDbRepository>,
) {
  return submissionRepository.findContestSubmissions(
    userId,
    participationId,
  )
}

import submissionRepositoryMongoDB from '../../infrastructure/repositories/submission'
import Submission, { ISubmission } from '../entities/submission'

export type ISubmissionRepository = (
  repository: ReturnType<typeof submissionRepositoryMongoDB>,
) => {
  findById: (id: string) => Promise<ISubmission>
  submit: (submission: ReturnType<typeof Submission>) => Promise<ISubmission>
  deleteSubmission: (id: string) => Promise<ISubmission>
  findContestSubmissions: (
    userId: string,
    participationId: string,
  ) => Promise<ISubmission[]>
}

export default function submissionDbRepository(
  repository: ReturnType<typeof submissionRepositoryMongoDB>,
) {
  const findById = (id: string): Promise<ISubmission> => repository.findById(id)

  const submit = (submission: ReturnType<typeof Submission>) =>
    repository.submit(submission)

  const deleteSubmission = (id: string) => repository.deleteSubmission(id)

  const findContestSubmissions = (
    userId: string,
    participationId: string,
  ) => repository.findContestSubmissions(userId, participationId)

  return {
    findById,
    submit,
    deleteSubmission,
    findContestSubmissions,
  }
}

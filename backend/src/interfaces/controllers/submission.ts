import { NextFunction, Request, Response } from 'express'
import createSubmission from '../../application/use_cases/submission/create'
import removeSubmission from '../../application/use_cases/submission/deleteById'
import findById from '../../application/use_cases/submission/findById'
import viewContestSubmission from '../../application/use_cases/submission/views'
import { ISubmissionRepository } from '../../domain/repositories/submission'
import { ISubmissionRepositoryImpl } from '../../infrastructure/repositories/submission'

export default function SubmissionController(
  submissionRepository: ISubmissionRepository,
  submissionDbRepository: ISubmissionRepositoryImpl,
) {
  const dbRepository = submissionRepository(submissionDbRepository())

  const fetchSubmissionById = (
    req: Request,
    res: Response,
    next: NextFunction,
  ) => {
    findById(req.params.id, dbRepository)
      .then(submission => res.json(submission))
      .catch(error => next(error))
  }

  const createNewSubmission = (
    req: Request,
    res: Response,
    next: NextFunction,
  ) => {
    createSubmission(req.body, dbRepository)
      .then(submission => res.json(submission))
      .catch(error => next(error))
  }

  const deleteSubmission = (
    req: Request,
    res: Response,
    next: NextFunction,
  ) => {
    removeSubmission(req.params.id, dbRepository)
      .then(submission => res.json(submission))
      .catch(error => next(error))
  }

  const findContestSubmissions = (
    req: Request,
    res: Response,
    next: NextFunction,
  ) => {
    viewContestSubmission(
      req.params.userId,
      req.params.participationId,
      dbRepository,
    )
      .then(submissions => res.json(submissions))
      .catch(error => next(error))
  }

  return {
    fetchSubmissionById,
    createNewSubmission,
    deleteSubmission,
    findContestSubmissions,
  }
}

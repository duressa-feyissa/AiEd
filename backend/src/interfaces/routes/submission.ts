import { Router } from 'express'
import submissionDbRepository from '../../domain/repositories/submission'
import submissionRepositoryMongoDB from '../../infrastructure/repositories/submission'
import submissionController from '../controllers/submission'
import authMiddleware from '../middlewares/authMiddleware'
import authorization from '../middlewares/authorizationMiddleware'

export default function submissionRouter(router: Router) {
  const controller = submissionController(submissionDbRepository, submissionRepositoryMongoDB);

  router.post('/', authMiddleware, authorization(['ADMIN', 'MASTER']), controller.createNewSubmission);
  router.get('/:id', authMiddleware, authorization(['ADMIN', 'MASTER', 'USER']), controller.fetchSubmissionById);
  router.delete('/:id', authMiddleware, authorization(['ADMIN', 'MASTER']), controller.deleteSubmission);

  return router;
}

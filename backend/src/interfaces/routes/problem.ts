import { Router } from 'express'
import problemDbRepository from '../../domain/repositories/problem'
import problemRepositoryMongoDB from '../../infrastructure/repositories/problem'
import ProblemController from '../controllers/problem'
import authMiddleware from '../middlewares/authMiddleware'
import authorization from '../middlewares/authorizationMiddleware'

export default function problemRouter(router: Router) {
  const controller = ProblemController(
    problemDbRepository,
    problemRepositoryMongoDB,
  )
  router.get(
    '/sync',
    authMiddleware,
    authorization(['ADMIN', 'MASTER', 'USER']),
    controller.fetchProblemSync,
  )

  router.post(
    '/',
    authMiddleware,
    authorization(['ADMIN', 'MASTER']),
    controller.createNewProblem,
  )
  router.get(
    '/',
    authMiddleware,
    authorization(['ADMIN', 'MASTER', 'USER']),
    controller.fetchAllProblems,
  )
  router.get(
    '/:id',
    authMiddleware,
    authorization(['ADMIN', 'MASTER', 'USER']),
    controller.fetchProblemById,
  )
  router.delete(
    '/:id',
    authMiddleware,
    authorization(['ADMIN', 'MASTER']),
    controller.deleteProblem,
  )
  router.put(
    '/:id',
    authMiddleware,
    authorization(['ADMIN', 'MASTER']),
    controller.updateExistingProblem,
  )

  return router
}

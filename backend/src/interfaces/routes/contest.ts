import { Router } from 'express'
import contestDbRepository from '../../domain/repositories/contest'
import contestRepositoryMongoDB from '../../infrastructure/repositories/contest'
import ContestController from '../controllers/contest'
import authMiddleware from '../middlewares/authMiddleware'
import authorization from '../middlewares/authorizationMiddleware'

export default function contestRouter(router: Router) {
  const controller = ContestController(
    contestDbRepository,
    contestRepositoryMongoDB,
  )

  router.post(
    '/',
    authMiddleware,
    authorization(['ADMIN', 'MASTER']),
    controller.createNewContest,
  )
  router.get(
    '/',
    authMiddleware,
    authorization(['ADMIN', 'MASTER', 'USER']),
    controller.fetchAllContests,
  )
  router.get(
    '/:id',
    authMiddleware,
    authorization(['ADMIN', 'MASTER', 'USER']),
    controller.fetchContestById,
  )
  router.delete(
    '/:id',
    authMiddleware,
    authorization(['ADMIN', 'MASTER']),
    controller.deleteContest,
  )
  router.put(
    '/:id',
    authMiddleware,
    authorization(['ADMIN', 'MASTER']),
    controller.updateExistingContest,
  )
  router.get(
    '/:id/standing',
    authMiddleware,
    authorization(['ADMIN', 'MASTER', 'USER']),
    controller.fetchContestStanding,
  )

  router.get(
    '/:id/problems/:problemId/add',
    authMiddleware,
    authorization(['ADMIN', 'MASTER', 'USER']),
    controller.addProblem,
  )
  router.get(
    '/:id/problems/:problemId/remove',
    authMiddleware,
    authorization(['ADMIN', 'MASTER', 'USER']),
    controller.removeProblem,
  )
  router.get(
    '/:id/problems',
    authMiddleware,
    authorization(['ADMIN', 'MASTER', 'USER']),
    controller.fetchProblems,
  )

  router.get(
    '/:id/creator',
    authMiddleware,
    authorization(['ADMIN', 'MASTER', 'USER']),
    controller.fetchCreator,
  )
  router.get(
    '/:id/info',
    authMiddleware,
    authorization(['ADMIN', 'MASTER', 'USER']),
    controller.findContestInfo,
  )
  router.post(
    '/:id/register/:userId/',
    authMiddleware,
    authorization(['ADMIN', 'MASTER', 'USER']),
    controller.registerForContest,
  )
  router.get(
    '/:id/submissions/:participantId',
    authMiddleware,
    authorization(['ADMIN', 'MASTER', 'USER']),
    controller.fetchContestSubmissions,
  )

  return router
}

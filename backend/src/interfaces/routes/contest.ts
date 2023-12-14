import { Router } from "express";
import contestDbRepository from "../../domain/repositories/contest";
import contestRepositoryMongoDB from "../../infrastructure/repositories/contest";
import ContestController from "../controllers/contest";
import authMiddleware from "../middlewares/authMiddleware";
import authorization from "../middlewares/authorizationMiddleware";

export default function contestRouter(router: Router) {
  const controller = ContestController(
    contestDbRepository,
    contestRepositoryMongoDB
  );

  router.post(
    "/",
    authMiddleware,
    authorization(["ADMIN", "MASTER"]),
    controller.createNewContest
  );
  router.get(
    "/",
    authMiddleware,
    authorization(["ADMIN", "MASTER", "USER"]),
    controller.fetchAllContests
  );
  router.get(
    "/:id",
    authMiddleware,
    authorization(["ADMIN", "MASTER", "USER"]),
    controller.fetchContestById
  );
  router.delete(
    "/:id",
    authMiddleware,
    authorization(["ADMIN", "MASTER"]),
    controller.deleteContest
  );
  router.put(
    "/:id",
    authMiddleware,
    authorization(["ADMIN", "MASTER"]),
    controller.updateExistingContest
  );
  router.get(
    "/:id/problems/:problemId/add",
    authMiddleware,
    authorization(["ADMIN", "MASTER"]),
    controller.addProblem
  );
  router.get(
    "/:id/problems/:problemId/remove",
    authMiddleware,
    authorization(["ADMIN", "MASTER"]),
    controller.removeProblem
  );
  router.get(
    "/:id/participants/:participantId/add",
    authMiddleware,
    authorization(["ADMIN", "MASTER"]),
    controller.addParticipant
  );
  router.get(
    "/:id/participants/:participantId/remove",
    authMiddleware,
    authorization(["ADMIN", "MASTER"]),
    controller.removeParticipant
  );
  router.get(
    "/:id/problems",
    authMiddleware,
    authorization(["ADMIN", "MASTER"]),
    controller.fetchProblems
  );
  router.get(
    "/:id/participants",
    authMiddleware,
    authorization(["ADMIN", "MASTER"]),
    controller.fetchParticipants
  );
  router.get(
    "/:id/creator",
    authMiddleware,
    authorization(["ADMIN", "MASTER"]),
    controller.fetchCreator
  );
  router.get(
    "/:id/info",
    authMiddleware,
    authorization(["ADMIN", "MASTER"]),
    controller.findContestInfo
  );


  return router;
}

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

  return router;
}

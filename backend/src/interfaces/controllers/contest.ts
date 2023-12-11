import { NextFunction, Request, Response } from "express";
import createContest from "../../application/use_cases/contest/create";
import removeContest from "../../application/use_cases/contest/delete";
import findById from "../../application/use_cases/contest/findById";
import updateContest from "../../application/use_cases/contest/update";
import viewAllContest from "../../application/use_cases/contest/views";
import { IContestRepository } from "../../domain/repositories/contest";
import { IContestRepositoryImpl } from "../../infrastructure/repositories/contest";

export default function ContestController(
  contestRepository: IContestRepository,
  contestDbRepository: IContestRepositoryImpl
) {
  const dbRepository = contestRepository(contestDbRepository());

  const fetchContestById = (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    findById(req.params.id, dbRepository)
      .then((contest) => res.json(contest))
      .catch((error) => next(error));
  };

  const fetchAllContests = (
    req: Request,
    res: Response,
    next: NextFunction
  ): void => {
    const { skip = "0", limit = "10", search, sort } = req.query;

    const options = {
      skip: parseInt(typeof skip === "string" ? skip : "0", 10),
      limit: parseInt(typeof limit === "string" ? limit : "10", 10),
      search: search as string,
      sort: typeof sort === "string" ? parseSortParameter(sort) : undefined,
    };

    viewAllContest(options, dbRepository)
      .then((contests) => res.json(contests))
      .catch((error) => next(error));
  };

  const parseSortParameter = (
    sort: string | undefined
  ): Record<string, 1 | -1> => {
    if (sort) {
      const [field, order] = sort.split(":");
      const sortOrder = order === "desc" ? -1 : 1;

      return { [field]: sortOrder };
    }

    return { createdAt: 1 };
  };

  const createNewContest = (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    createContest(req.body, dbRepository)
      .then((contest) => res.json(contest))
      .catch((error) => next(error));
  };

  const updateExistingContest = (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    updateContest(req.params.id, req.body, dbRepository)
      .then((contest) => res.json(contest))
      .catch((error) => next(error));
  };

  const deleteContest = (req: Request, res: Response, next: NextFunction) => {
    removeContest(req.params.id, dbRepository)
      .then((contest) => res.json(contest))
      .catch((error) => next(error));
  };

  return {
    fetchContestById,
    fetchAllContests,
    createNewContest,
    updateExistingContest,
    deleteContest,
  };
}

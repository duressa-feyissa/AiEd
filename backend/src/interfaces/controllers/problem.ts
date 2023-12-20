import { NextFunction, Request, Response } from 'express'
import createProblem from '../../application/use_cases/problem/create'
import removeProblem from '../../application/use_cases/problem/delete'
import findById from '../../application/use_cases/problem/findById'
import updateProblem from '../../application/use_cases/problem/update'
import viewAllProblem from '../../application/use_cases/problem/views'
import { IProblemRepository } from '../../domain/repositories/problem'
import { IProblemRepositoryImpl } from '../../infrastructure/repositories/problem'

export default function ProblemController(
  problemRepository: IProblemRepository,
  problemDbRepository: IProblemRepositoryImpl,
) {
  const dbRepository = problemRepository(problemDbRepository())

  const fetchProblemById = (
    req: Request,
    res: Response,
    next: NextFunction,
  ) => {
    findById(req.params.id, dbRepository)
      .then(problem => res.json(problem))
      .catch(error => next(error))
  }

  const fetchAllProblems = (
    req: Request,
    res: Response,
    next: NextFunction,
  ): void => {
    const {
      skip = '0',
      limit = '10',
      search,
      sort,
      difficulty,
      grade,
      courses,
      target,
      source,
      contentType,
      year,
    } = req.query

    const options = {
      skip: parseInt(typeof skip === 'string' ? skip : '0', 10),
      limit: parseInt(typeof limit === 'string' ? limit : '10', 10),
      search: search as string,
      sort: typeof sort === 'string' ? parseSortParameter(sort) : undefined,
      difficulty:
        typeof difficulty === 'string' ? difficulty.split(',') : undefined,
      grade: typeof grade === 'string' ? grade.split(',') : undefined,
      courses: typeof courses === 'string' ? courses.split(',') : undefined,
      target: typeof target === 'string' ? target.split(',') : undefined,
      source: typeof source === 'string' ? source.split(',') : undefined,
      contentType:
        typeof contentType === 'string' ? contentType.split(',') : undefined,
      year: typeof year === 'string' ? year.split(',') : undefined,
    }

    viewAllProblem(options, dbRepository)
      .then(problems => res.json(problems))
      .catch(error => next(error))
  }

  const parseSortParameter = (
    sort: string | undefined,
  ): Record<string, 1 | -1> => {
    if (sort) {
      const [field, order] = sort.split(':')
      const sortOrder = order === 'desc' ? -1 : 1

      return { [field]: sortOrder }
    }

    return { createdAt: 1 }
  }

  const createNewProblem = (
    req: Request,
    res: Response,
    next: NextFunction,
  ) => {
    createProblem(req.body, dbRepository)
      .then(problem => res.json(problem))
      .catch(error => next(error))
  }

  const updateExistingProblem = (
    req: Request,
    res: Response,
    next: NextFunction,
  ) => {
    updateProblem(req.params.id, req.body, dbRepository)
      .then(problem => res.json(problem))
      .catch(error => next(error))
  }

  const deleteProblem = (req: Request, res: Response, next: NextFunction) => {
    removeProblem(req.params.id, dbRepository)
      .then(problem => res.json(problem))
      .catch(error => next(error))
  }

  return {
    fetchProblemById,
    fetchAllProblems,
    createNewProblem,
    updateExistingProblem,
    deleteProblem,
  }
}

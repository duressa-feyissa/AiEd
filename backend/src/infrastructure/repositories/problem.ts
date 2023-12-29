import { Types } from 'mongoose'
import CustomError from '../../config/error'
import Problem, { IProblem } from '../../domain/entities/problem'
import ProblemModel from '../database/models/problem'

interface ViewAllProblemParams {
  skip: number
  limit: number
  search?: string
  sort?: Record<string, 1 | -1>
  difficulty?: string[]
  grade?: string[]
  courses?: string[]
  target?: string[]
  source?: string[]
  contentType?: string[]
  year?: string[]
}

export type IProblemRepositoryImpl = () => {
  findById: (id: string) => Promise<IProblem>
  viewAllProblem: (params: ViewAllProblemParams) => Promise<IProblem[]>
  deleteProblem: (id: string) => Promise<IProblem>
  updateProblem: (
    id: string,
    problem: ReturnType<typeof Problem>,
  ) => Promise<IProblem>
  createProblem: (problem: ReturnType<typeof Problem>) => Promise<IProblem>
  syncProblem: (last: Date, skip: number, limit: number) => Promise<IProblem[]>
}

export default function problemRepositoryMongoDB() {
  const findById = (id: string): Promise<IProblem> => {
    if (!Types.ObjectId.isValid(id)) {
      return Promise.reject(new CustomError(`${id} is not a valid id`, 400))
    }
    return ProblemModel.findById(id).then((problem: IProblem | null) => {
      if (!problem) {
        return Promise.reject(
          new CustomError(`Problem with id ${id} not found`, 404),
        )
      }
      return problem
    })
  }

  const syncProblem = (
    last: Date,
    skip: number,
    limit: number,
  ): Promise<IProblem[]> => {
    return ProblemModel.find({
      updatedAt: { $gte: last },
    })
      .sort({ updatedAt: 1 })
      .skip(skip)
      .limit(limit)
      .then((problems: IProblem[]) => problems)
  }

  const viewAllProblem = (params: ViewAllProblemParams) => {
    const {
      skip,
      limit,
      difficulty,
      grade,
      courses,
      target,
      source,
      contentType,
      sort,
      year,
    } = params

    const query: any = {}

    if (difficulty && Array.isArray(difficulty) && difficulty.length > 0) {
      query['details.difficulty'] = { $in: difficulty }
    }

    if (grade && Array.isArray(grade) && grade.length > 0) {
      query['details.grade'] = { $in: grade }
    }

    if (courses && Array.isArray(courses) && courses.length > 0) {
      query['details.courses'] = { $in: courses }
    }

    if (target && Array.isArray(target) && target.length > 0) {
      query['details.target'] = { $in: target }
    }

    if (source && Array.isArray(source) && source.length > 0) {
      query['source.name'] = source
    }

    if (contentType && Array.isArray(contentType) && contentType.length > 0) {
      query['answer.type'] = contentType
    }

    if (year && Array.isArray(year) && year.length > 0) {
      query['source.year'] = { $in: year }
    }

    return ProblemModel.find(query)
      .sort(sort)
      .skip(skip)
      .limit(limit)
      .then((problems: IProblem[]) => problems.map(problem => problem))
  }

  const createProblem = (problem: ReturnType<typeof Problem>) => {
    return ProblemModel.create({
      published: problem.getPublished(),
      source: problem.getSource(),
      point: problem.getPoint(),
      details: problem.getDetails(),
      content: problem.getContent(),
      answer: problem.getAnswer(),
    }).then((problem: IProblem) => problem)
  }

  const deleteProblem = (id: string) => {
    if (!Types.ObjectId.isValid(id)) {
      return Promise.reject(new CustomError(`${id} is not a valid id`, 400))
    }

    return ProblemModel.findByIdAndDelete(id).then((problem: any) => {
      if (!problem) {
        return Promise.reject(
          new CustomError(`Problem with id ${id} not found`, 404),
        )
      }
      return problem
    })
  }

  const updateProblem = (id: string, problem: ReturnType<typeof Problem>) => {
    if (!Types.ObjectId.isValid(id)) {
      return Promise.reject(new CustomError(`${id} is not a valid id`, 400))
    }

    return ProblemModel.findByIdAndUpdate(
      id,
      {
        _id: id,
        published: problem.getPublished(),
        source: problem.getSource(),
        details: problem.getDetails(),
        point: problem.getPoint(),
        content: problem.getContent(),
        answer: problem.getAnswer(),
      },
      { new: true },
    ).then((problem: any) => {
      if (!problem) {
        return Promise.reject(
          new CustomError(`Problem with id ${id} not found`, 404),
        )
      }
      return problem
    })
  }

  return {
    findById,
    viewAllProblem,
    createProblem,
    deleteProblem,
    updateProblem,
    syncProblem,
  }
}

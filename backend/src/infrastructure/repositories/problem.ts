import { Types } from 'mongoose'
import CustomError from '../../config/error'
import Problem, { IProblem } from '../../domain/entities/problem'
import ProblemModel from '../database/models/problem'

interface ViewAllProblemParams {
    skip: number
    limit: number
    search?: string
    sort?: Record<string, 1 | -1>
  }

export type IProblemRepositoryImpl = () => {
    findById: (id: string) => Promise<IProblem>
    viewAllProblem: (params: ViewAllProblemParams) => Promise<IProblem[]>
    deleteProblem: (id: string) => Promise<IProblem>
    updateProblem: (id: string, problem: ReturnType<typeof Problem>) => Promise<IProblem>
    createProblem: (problem: ReturnType<typeof Problem>) => Promise<IProblem>
}

export default function problemRepositoryMongoDB() {

  const findById = (id: string): Promise<IProblem> => {
    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid problem id`, 400)
    }
    return ProblemModel.findById(id)
      .then((problem: IProblem | null) => {
        if (!problem) {
          throw new CustomError(`Problem with id ${id} not found`, 404)
        }
        return problem
      })
  }

  const viewAllProblem = (params: ViewAllProblemParams) => {
    const { skip, limit, search, sort } = params
    
    const query: { [key: string]: unknown } = {}
    if (search) {
      query.$or = [
        { source: { $regex: search, $options: 'i' } },
        { details: { $regex: search, $options: 'i' } },
      ]
    }

    return ProblemModel.find(query)
      .sort(sort)
      .skip(skip)
      .limit(limit)
      .then((problems: IProblem[]) => problems.map((problem) => problem ))
  }

  const createProblem = (problem: ReturnType<typeof Problem>) => {
    return ProblemModel.create({
      published: problem.getPublished(),
      source: problem.getSource(),
      details: problem.getDetails(),
      content: problem.getContent(),
      answer: problem.getAnswer(),

    })
      .then((problem: IProblem) => problem )
  }

  const deleteProblem = (id: string) => {
    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid problem id`, 400)
    }

    return ProblemModel.findByIdAndDelete(id)
      .then((problem: any) => {
        if (!problem) {
          throw new CustomError(`Problem with id ${id} not found`, 404)
        }
        return problem
      })
  }

  const updateProblem = (id: string, problem: ReturnType<typeof Problem>) => {
    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid problem id`, 400)
    }


    return ProblemModel.findByIdAndUpdate(id, {
      _id: id,
      published: problem.getPublished(),
      source: problem.getSource(),
      details: problem.getDetails(),
      content: problem.getContent(),
      answer: problem.getAnswer(),
    }, { new: true })
      .then((problem: any) => {
        if (!problem) {
          throw new CustomError(`Problem with id ${id} not found`, 404)
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
  }
}
import { NextFunction, Request, Response } from 'express'
import { IAuthServiceInterface } from '../../application/service/auth'
import createUser from '../../application/use_cases/user/create'
import removeUser from '../../application/use_cases/user/delete'
import findByEmail from '../../application/use_cases/user/findByEmail'
import findById from '../../application/use_cases/user/findById'
import findByPhone from '../../application/use_cases/user/findByPhone'
import findByUsername from '../../application/use_cases/user/findByUsername'
import findByUsernameOrEmail from '../../application/use_cases/user/findByUsernameOrEmail'
import viewAllUsers from '../../application/use_cases/user/views'
import { IUserRepository } from '../../domain/repositories/user'
import { IAuthService } from '../services/auth'
import { IUserRepositoryImpl } from './../../infrastructure/repositories/user'

export default function UserController(
  userRepository: IUserRepository,
  userDbRepositoryImpl: IUserRepositoryImpl,
  authService: IAuthService,
  authServiceInterface: IAuthServiceInterface,
) {
  const dbRepository = userRepository(userDbRepositoryImpl())

  const auth = authServiceInterface(authService())
  const fetchUserById = (req: Request, res: Response, next: NextFunction) => {
    findById(req.params.id, dbRepository)
      .then(user => res.json(user))
      .catch(error => next(error))
  }

  const fetchAllUsers = (
    req: Request,
    res: Response,
    next: NextFunction,
  ): void => {
    const { skip = '0', limit = '10', search, sort } = req.query

    const options = {
      skip: parseInt(typeof skip === 'string' ? skip : '0', 10),
      limit: parseInt(typeof limit === 'string' ? limit : '10', 10),
      search: search as string,
      sort: typeof sort === 'string' ? parseSortParameter(sort) : undefined,
    }

    viewAllUsers(options, dbRepository)
      .then(users => res.json(users))
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

  const deleteUser = (req: Request, res: Response, next: NextFunction) => {
    removeUser(req.params.id, dbRepository)
      .then(user => res.json(user))
      .catch(error => next(error))
  }

  const fetchUserByUsername = (
    req: Request,
    res: Response,
    next: NextFunction,
  ) => {
    findByUsername(req.params.username, dbRepository)
      .then(user => res.json(user))
      .catch(error => next(error))
  }

  const fetchUserByEmail = (
    req: Request,
    res: Response,
    next: NextFunction,
  ) => {
    findByEmail(req.params.email, dbRepository)
      .then(user => res.json(user))
      .catch(error => next(error))
  }

  const fetchUserByPhone = (
    req: Request,
    res: Response,
    next: NextFunction,
  ) => {
    findByPhone(req.params.phone, dbRepository)
      .then(user => res.json(user))
      .catch(error => next(error))
  }

  const fetchUserByPhoneOrEmail = (
    req: Request,
    res: Response,
    next: NextFunction,
  ) => {
    findByUsernameOrEmail(req.params.userOrEmail, dbRepository)
      .then(user => res.json(user))
      .catch(error => next(error))
  }

  const createNewUser = (req: Request, res: Response, next: NextFunction) => {
    createUser(req.body, dbRepository, auth)
      .then(user => res.json(user))
      .catch(error => next(error))
  }

  return {
    fetchUserById,
    fetchAllUsers,
    deleteUser,
    fetchUserByUsername,
    fetchUserByEmail,
    fetchUserByPhone,
    fetchUserByPhoneOrEmail,
    createNewUser,
  }
}

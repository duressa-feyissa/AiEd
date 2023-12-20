import User, { IUser } from '../../domain/entities/user'
import userRepositoryMongoDB from '../../infrastructure/repositories/user'

interface ViewAllUsersParams {
  skip: number
  limit: number
  search?: string
  sort?: Record<string, 1 | -1>
}

export type IUserRepository = (
  repository: ReturnType<typeof userRepositoryMongoDB>,
) => {
  findById: (id: string) => Promise<IUser>
  viewAllUsers: (params: ViewAllUsersParams) => Promise<IUser[]>
  deleteUser: (id: string) => Promise<IUser>
  findByUsername: (username: string) => Promise<IUser>
  findByEmail: (email: string) => Promise<IUser>
  findByUsernameOrEmail: (usernameOrEmail: string) => Promise<IUser>
  findByPhone: (phone: string) => Promise<IUser>
  createUser: (user: ReturnType<typeof User>) => Promise<IUser>
}

export default function userDbRepository(
  repository: ReturnType<typeof userRepositoryMongoDB>,
) {
  const findById = (id: string) => repository.findById(id)
  const viewAllUsers = (params: ViewAllUsersParams) =>
    repository.viewAllUsers(params)
  const deleteUser = (id: string) => repository.deleteUser(id)
  const findByUsername = (username: string) =>
    repository.findByUsername(username)
  const findByEmail = (email: string) => repository.findByEmail(email)
  const findByUsernameOrEmail = (usernameOrEmail: string) =>
    repository.findByUsernameOrEmail(usernameOrEmail)
  const findByPhone = (phone: string) => repository.findByPhone(phone)
  const createUser = (user: ReturnType<typeof User>) =>
    repository.createUser(user)

  return {
    findById,
    viewAllUsers,
    deleteUser,
    findByUsername,
    findByEmail,
    findByUsernameOrEmail,
    findByPhone,
    createUser,
  }
}

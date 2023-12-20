import { Types } from 'mongoose'
import CustomError from '../../config/error'
import User, { IUser } from '../../domain/entities/user'
import UserModel from '../database/models/user'

interface ViewAllUsersParams {
  skip: number
  limit: number
  search?: string
  sort?: Record<string, 1 | -1>
}

export type IUserRepositoryImpl = () => {
  findById: (id: string) => Promise<IUser>
  viewAllUsers: (params: ViewAllUsersParams) => Promise<IUser[]>
  deleteUser: (id: string) => Promise<IUser>
  findByUsername: (username: string) => Promise<IUser>
  findByEmail: (email: string) => Promise<IUser>
  findByUsernameOrEmail: (usernameOrEmail: string) => Promise<IUser>
  findByPhone: (phone: string) => Promise<IUser>
  createUser: (user: ReturnType<typeof User>) => Promise<IUser>
}

const ROLES = ['ADMIN', 'USER']
export default function userRepositoryMongoDB() {
  const findById = (id: string): Promise<IUser> => {
    if (!Types.ObjectId.isValid(id)) {
      return Promise.reject(
        new CustomError(`${id} is not a valid user id`, 400),
      )
    }

    return UserModel.findById(id)
      .select('-password')
      .then((user: any) => {
        if (!user) {
          return Promise.reject(
            new CustomError(`User with id ${id} not found`, 404),
          )
        }
        return user as IUser
      })
  }

  const viewAllUsers = (params: ViewAllUsersParams): Promise<IUser[]> => {
    const { skip, limit, search, sort } = params

    const query: { [key: string]: unknown } = {}
    if (search) {
      query.$or = [
        { firstName: { $regex: search, $options: 'i' } },
        { lastName: { $regex: search, $options: 'i' } },
      ]
    }

    return UserModel.find(query)
      .sort(sort)
      .skip(skip)
      .limit(limit)
      .select('-password')
      .exec()
      .then((users: IUser[]) => {
        return users
      })
  }

  const findByUsername = (username: string): Promise<IUser> => {
    return UserModel.findOne({ username })
      .select('-password')
      .then((user: IUser | null) => {
        if (!user) {
          return Promise.reject(
            new CustomError(`User with username ${username} not found`, 404),
          )
        }
        return user
      })
  }

  const deleteUser = (id: string): Promise<IUser> => {
    if (!Types.ObjectId.isValid(id)) {
      return Promise.reject(
        new CustomError(`${id} is not a valid user id`, 400),
      )
    }

    return UserModel.findByIdAndDelete(id)
      .select('-password')
      .then((user: any) => {
        if (!user) {
          return Promise.reject(
            new CustomError(`User with id ${id} not found`, 404),
          )
        }
        return user as IUser
      })
  }

  const findByEmail = (email: string): Promise<IUser> => {
    return UserModel.findOne({ email }).then((user: IUser | null) => {
      if (!user) {
        return Promise.reject(
          new CustomError(`User with email ${email} not found`, 404),
        )
      }
      return user
    })
  }

  const findByUsernameOrEmail = (usernameOrEmail: string): Promise<IUser> => {
    return UserModel.findOne({
      $or: [{ username: usernameOrEmail }, { email: usernameOrEmail }],
    }).then((user: IUser | null) => {
      if (!user) {
        return Promise.reject(
          new CustomError(
            `User with username or email ${usernameOrEmail} not found`,
            404,
          ),
        )
      }
      return user
    })
  }

  const findByPhone = (phone: string): Promise<IUser> => {
    return UserModel.findOne({ phone }).then((user: IUser | null) => {
      if (!user) {
        return Promise.reject(
          new CustomError(`User with phone ${phone} not found`, 404),
        )
      }
      return user
    })
  }

  const createUser = async (user: ReturnType<typeof User>): Promise<IUser> => {
    const existingUser = await UserModel.findOne({ email: user.getEmail() })
    if (existingUser)
      return Promise.reject(
        new CustomError(`Email ${user.getEmail()} is already in use`, 400),
      )

    if (user.getPhone()) {
      const existingUserByPhone = await UserModel.findOne({
        phone: user.getPhone(),
      })
      if (existingUserByPhone)
        return Promise.reject(
          new CustomError(`Phone ${user.getPhone()} is already in use`, 400),
        )
    }

    if (user.getUsername()) {
      const existingUserByUsername = await UserModel.findOne({
        username: user.getUsername(),
      })
      if (existingUserByUsername)
        return Promise.reject(
          new CustomError(
            `Username ${user.getUsername()} is already in use`,
            400,
          ),
        )
    }

    return UserModel.create({
      firstName: user.getFirstName(),
      lastName: user.getLastName(),
      phone: user.getPhone(),
      email: user.getEmail(),
      password: user.getPassword(),
      role: user.getRole(),
      verify: user.getVerify(),
      dateOfBirth: user.getDateOfBirth(),
      school: user.getSchool(),
      grade: user.getGrade(),
      image: user.getImage(),
      cover: user.getCover(),
      createAt: user.getCreatedAt(),
      points: user.getPoints(),
    }).then((user: IUser) => user)
  }

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

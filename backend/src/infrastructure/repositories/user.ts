import { Types } from 'mongoose'
import CustomError from '../../config/error'
import { IUser } from '../../domain/entities/user'
import UserModel, {
  IUser as MIUser, validateUser
} from "../database/models/user"

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
  createUser: (user: IUser) => Promise<IUser>
}
const ROLES = ["ADMIN", "USER"] 
export default function userRepositoryMongoDB() {
  const findById = (id: string): Promise<IUser> => {
    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid user id`, 400)
    }
    return UserModel.findById(id)
      .select('-password')
      .then((user: MIUser | null) => {
        if (!user) {
          throw new CustomError(`User with id ${id} not found`, 404)
        }
        return user.toObject() as IUser
      })
  }

  const viewAllUsers = (params: ViewAllUsersParams) => {
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
      .then((users: MIUser[]) => users.map((user) => user.toObject() as IUser))
  }

  const findByUsername = (username: string): Promise<IUser> => {
    return UserModel.findOne({ username })
      .select('-password')
      .then((user: MIUser | null) => {
        if (!user) {
          throw new CustomError(`User with username ${username} not found`, 404)
        }
        return user.toObject() as IUser
      })
  }

  const deleteUser = (id: string): Promise<IUser> => {
    if (!Types.ObjectId.isValid(id)) {
      throw new CustomError(`${id} is not a valid user id`, 400);
    }

    return UserModel.findByIdAndDelete(id)
    .select('-password')
    .then((user: any) => {
      if (!user) {
        throw new CustomError(`User with id ${id} not found`, 404);
      } 
      return user.toObject() as IUser;
    });
  }

  const findByEmail = (email: string): Promise<IUser> => {
    return UserModel.findOne({ email }).then((user: MIUser | null) => {
      if (!user) {
        throw new CustomError(`User with email ${email} not found`, 404)
      }
      return user.toObject() as IUser
    })
  }

  const findByUsernameOrEmail = (usernameOrEmail: string): Promise<IUser> => {
    return UserModel.findOne({
      $or: [{ username: usernameOrEmail }, { email: usernameOrEmail }],
    }).then((user: MIUser | null) => {
      if (!user) {
        throw new CustomError(
          `User with username or email ${usernameOrEmail} not found`,
          404
        )
      }
      return user.toObject() as IUser
    })
  }

  const findByPhone = (phone: string): Promise<IUser> => {
    return UserModel.findOne({ phone }).then((user: MIUser | null) => {
      if (!user) {
        throw new CustomError(`User with phone ${phone} not found`, 404)
      }
      return user.toObject() as IUser
    })
  }

  const createUser = async (user: IUser): Promise<IUser> => {
    const { error } = validateUser(user);
    if (error) throw new CustomError(error.details[0].message, 400);

    const existingUser = await UserModel.findOne({ email: user.email })
    if (existingUser) throw new CustomError(`Email ${user.email} is already in use`, 400)

    if (user.phone) {
      const existingUserByPhone = await UserModel.findOne({ phone: user.phone })
      if (existingUserByPhone) throw new CustomError(`Phone ${user.phone} is already in use`, 400)
    }
    
    if (user.username) {
      const existingUserByUsername = await UserModel.findOne({ username: user.username })
      if (existingUserByUsername) throw new CustomError(`Username ${user.username} is already in use`, 400)
    }

    return UserModel.create(user).then(
      (user: MIUser) => user.toObject() as IUser
    )
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

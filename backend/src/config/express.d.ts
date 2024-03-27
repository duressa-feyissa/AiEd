import { IUser } from '../domain/entities/user'

declare global {
  namespace Express {
    interface Request {
      user: IUser
    }
  }
}

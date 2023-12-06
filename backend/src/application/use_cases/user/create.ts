import authService from '../../../interfaces/services/auth';
import { IUser } from '../../../domain/entities/user'
import userDbRepository from '../../../domain/repositories/user'

export default function createUser(
  user: IUser,
  userRepository: ReturnType<typeof userDbRepository>,
  auth: ReturnType<typeof authService>
) {
  const { password } = user
  if (password) {
    user.password = auth.encryptPassword(password)
  }
  return userRepository.createUser(user)
}

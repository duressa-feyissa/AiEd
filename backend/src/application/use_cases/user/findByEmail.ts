import userDbRepository from '../../../domain/repositories/user'

export default function findByEmail(
  email: string,
  userRepository: ReturnType<typeof userDbRepository>,
) {
  return userRepository.findByEmail(email)
}

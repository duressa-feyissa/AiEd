import userDbRepository from '../../../domain/repositories/user'

export default function findByUsernameOrEmail(
    usernameOrEmail: string,
  userRepository: ReturnType<typeof userDbRepository>
) {
  return userRepository.findByUsernameOrEmail(usernameOrEmail)
}

import userDbRepository from '../../../domain/repositories/user'

export default function findByUsername(
    username: string,
  userRepository: ReturnType<typeof userDbRepository>
) {
  return userRepository.findByUsername(username)
}

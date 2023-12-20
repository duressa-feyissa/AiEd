import userDbRepository from '../../../domain/repositories/user'

interface ViewAllUsersParams {
  skip: number
  limit: number
  search?: string
  sort?: Record<string, 1 | -1>
}

export default function viewAllUsers(
  params: ViewAllUsersParams,
  userRepository: ReturnType<typeof userDbRepository>,
) {
  return userRepository.viewAllUsers(params)
}

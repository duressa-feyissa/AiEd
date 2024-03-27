import problemDbRepository from '../../../infrastructure/repositories/problem'

export default function findById(
  id: string,
  problemRepository: ReturnType<typeof problemDbRepository>,
) {
  return problemRepository.findById(id)
}

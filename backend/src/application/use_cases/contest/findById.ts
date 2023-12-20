import contestDbRepository from '../../../infrastructure/repositories/contest'

export default function findById(
  id: string,
  contestRepository: ReturnType<typeof contestDbRepository>,
) {
  return contestRepository.findById(id)
}

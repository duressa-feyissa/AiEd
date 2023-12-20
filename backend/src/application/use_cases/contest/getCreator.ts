import contestDbRepository from '../../../infrastructure/repositories/contest'

export default function getContesCreator(
  id: string,
  contestRepository: ReturnType<typeof contestDbRepository>,
) {
  return contestRepository.getCreator(id)
}

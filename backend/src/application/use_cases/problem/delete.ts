import problemDbRepository from "../../../infrastructure/repositories/problem";

export default function removeProblem(
    id: string,
    problemRepository: ReturnType<typeof problemDbRepository>
) {
    return problemRepository.deleteProblem(id)
}
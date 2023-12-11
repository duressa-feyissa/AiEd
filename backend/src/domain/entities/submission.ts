export interface ISubmission {
    _id?: string
    contest?: string
    problem: string
    user: string
    userAnswer: string
    point?: number
    isCorrect: boolean
    attemptedAt?: Date
}

export default function Submission({
    _id,
    contest,
    problem,
    user,
    userAnswer,
    point,
    isCorrect,
    attemptedAt,
}: ISubmission) {
    return Object.freeze({
        getId: () => _id,
        getContest: () => contest,
        getProblem: () => problem,
        getUser: () => user,
        getUserAnswer: () => userAnswer,
        getPoint: () => point,
        getIsCorrect: () => isCorrect,
        getAttemptedAt: () => attemptedAt,
    })
}


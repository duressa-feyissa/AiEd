export interface ISubmission {
  _id?: string
  contest?: string
  participation?: string
  second?: number
  problem?: string
  user?: string
  userAnswer: string
  point?: number
  isCorrect: boolean
  attemptedAt?: Date
}

export default function Submission({
  _id,
  contest,
  participation,
  second,
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
    getParticipation: () => participation,
    getSecond: () => second,
    getUser: () => user,
    getUserAnswer: () => userAnswer,
    getPoint: () => point,
    getIsCorrect: () => isCorrect,
    getAttemptedAt: () => attemptedAt,
  })
}

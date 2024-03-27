const CONTEST_MODE_OPTIONS: string[] = ['marathon', 'killAndPass', 'custom']
const TYPE_OPTIONS: string[] = ['text', 'image', 'video']
const SUBMITTED_ON_OPTIONS: string[] = ['live', 'virtual']

export interface IContest {
  _id: string
  title: string
  image: string
  mode: (typeof CONTEST_MODE_OPTIONS)[number]
  description?: {
    type: (typeof TYPE_OPTIONS)[number]
    text?: string
    image?: string
    video?: string
  }[]
  sponsor?: {
    type: (typeof TYPE_OPTIONS)[number]
    text?: string
    image?: string
    video?: string
  }[]
  problems: [id: string]
  startTime: Date
  duration: number
  participants?: {
    user: string
    isRegistered: boolean
    registeredAt: Date
    startAt?: Date
    type: (typeof SUBMITTED_ON_OPTIONS)[number]
  }[]
  submissions?: [
    {
      _id: string
      submittedOn: (typeof SUBMITTED_ON_OPTIONS)[number]
      isCorrect: boolean
      seconds: number
    },
  ]
  creator?: {
    _id: string
  }
  createdAt: Date
  updatedAt: Date
}

export interface IContestRegistration {
  _id: string
  user: string
  isRegistered: boolean
  registeredAt: Date
  startAt?: Date
  type: (typeof SUBMITTED_ON_OPTIONS)[number]
}

export default function Contest({
  _id,
  title,
  mode,
  image,
  description,
  sponsor,
  problems,
  startTime,
  duration,
  participants,
  creator,
}: IContest) {
  return {
    getId: () => _id,
    getTitle: () => title,
    getMode: () => mode,
    getImage: () => image,
    getDescription: () => description,
    getSponsor: () => sponsor,
    getProblems: () => problems,
    getStartTime: () => startTime,
    getDuration: () => duration,
    getParticipants: () => participants,
    getCreator: () => creator,
  }
}

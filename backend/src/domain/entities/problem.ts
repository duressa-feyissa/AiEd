const source: string[] = ['gpt-4', 'gpt-3', 'model', 'uue', 'book', 'extreme']
const difficulty: string[] = ['normal', 'easy', 'medium', 'hard']
const target: string[] = ['elementary', 'university', 'highschool', 'general']
const content: string[] = ['text', 'image', 'equation', 'video']
const answerType: string[] = ['options', 'short', 'trueFalse']
const courses: string[] = [
  'mathematics',
  'biology',
  'physics',
  'chemistry',
  'history',
  'geography',
  'civics',
  'economics',
  'amharic',
  'english',
  'civics',
  'computer',
  'general',
]

export interface IProblem {
  _id?: string
  published: boolean
  source: {
    name: (typeof source)[number]
    value?: string
    year?: number
  }
  details: {
    target: (typeof target)[number]
    grade?: string
    unit?: string
    courses: (typeof courses)[number]
    topic?: string
    difficulty?: (typeof difficulty)[number]
  }
  question: {
    type: (typeof content)[number]
    value: string
  }[]
  point: {
    correct: number
    wrong: number
  }
  answer: {
    type: (typeof answerType)[number]
    options?: {
      correct: boolean
      data: {
        type: (typeof content)[number]
        value: string
      }[]
    }[]
    short?: string
    trueFalse?: boolean
    explanation?: {
      type: (typeof content)[number]
      value: string
    }[]
  }
  essay?: string
  createdAt?: Date
  updatedAt?: Date
}

export default function Problem({
  _id,
  published,
  source,
  point,
  details,
  question,
  answer,
  essay,
  createdAt,
  updatedAt,
}: IProblem) {
  return Object.freeze({
    getId: () => _id,
    getPublished: () => published,
    getPoint: () => point,
    getSource: () => source,
    getDetails: () => details,
    getQuestion: () => question,
    getAnswer: () => answer,
    getEsssay: () => essay,
    getCreatedAt: () => createdAt,
    getUpdatedAt: () => updatedAt,
  })
}

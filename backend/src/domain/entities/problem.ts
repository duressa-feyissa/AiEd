const source: string[] = ['gpt-4', 'gpt-3', 'model', 'uue', 'book', 'extreme']
const difficulty: string[] = ['normal', 'easy', 'medium', 'hard']
const target: string[] = ['elementary', 'university', 'highschool', 'general']
const type: string[] = ['text', 'image', 'equation', 'video']
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
    value: string
    year?: number
  }
  details: {
    target: (typeof target)[number]
    grade?: number
    unit?: number
    courses: (typeof courses)[number]
    topic: string
    difficulty: (typeof difficulty)[number]
  }
  content: {
    type: (typeof type)[number]
    text?: string
    image?: string
    equation?: string
    video?: string
  }
  point: {
    correct: number
    wrong: number
  }
  answer: {
    type: (typeof answerType)[number]
    options?: {
      correct: string
      choice: {
        id: string
        type: (typeof type)[number]
        text?: string
        image?: string
        equation?: string
        video?: string
      }[]
    }
    short?: {
      correct: string
    }
    trueFalse?: {
      correct: string
    }
  }
  createdAt?: Date
  updatedAt?: Date
}

export default function Problem({
  _id,
  published,
  source,
  point,
  details,
  content,
  answer,
  createdAt,
  updatedAt,
}: IProblem) {
  return Object.freeze({
    getId: () => _id,
    getPublished: () => published,
    getPoint: () => point,
    getSource: () => source,
    getDetails: () => details,
    getContent: () => content,
    getAnswer: () => answer,
    getCreatedAt: () => createdAt,
    getUpdatedAt: () => updatedAt,
  })
}

import { Schema, model } from 'mongoose'
import { IProblem } from '../../../domain/entities/problem'

const SOURCE_OPTIONS: string[] = [
  'gpt-4',
  'gpt-3',
  'model',
  'uue',
  'book',
  'extreme',
]
const DIFFICULTY_OPTIONS: string[] = ['normal', 'easy', 'medium', 'hard']
const TARGET_OPTIONS: string[] = [
  'elementary',
  'university',
  'highschool',
  'general',
]
const CONTENT_OPTIONS = ['text', 'image', 'equation', 'video']
const ANSWER_TYPE_OPTIONS: string[] = ['options', 'short', 'trueFalse']
const COURSES_OPTIONS: string[] = [
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

const problemSchema = new Schema<IProblem>({
  published: { type: Boolean, default: false },
  source: {
    name: { type: String, enum: SOURCE_OPTIONS, required: true },
    value: { type: String },
    year: { type: Number },
  },
  details: {
    target: { type: String, enum: TARGET_OPTIONS, required: true },
    grade: { type: String },
    unit: { type: String },
    courses: { type: String, enum: COURSES_OPTIONS, required: true },
    topic: { type: String },
    difficulty: { type: String, enum: DIFFICULTY_OPTIONS },
  },
  question: [
    {
      type: { type: String, enum: CONTENT_OPTIONS, required: true },
      value: { type: String, required: true },
    },
  ],
  point: {
    correct: { type: Number, default: 1, required: true },
    wrong: { type: Number, default: 0, required: true },
  },
  answer: {
    type: { type: String, enum: ANSWER_TYPE_OPTIONS, required: true },
    options: [
      {
        correct: { type: Boolean, required: true, default: false },
        data: [
          {
            type: { type: String, enum: CONTENT_OPTIONS, required: true },
            value: { type: String, required: true },
          },
        ],
      },
    ],
    short: { type: String },
    trueFalse: { type: Boolean },
    explanation: [
      {
        type: { type: String, enum: CONTENT_OPTIONS },
        value: { type: String },
      },
    ],
  },
  essay: {
    type: Schema.Types.ObjectId,
    ref: 'Essay',
  },
  createdAt: { type: Date, default: Date.now },
  updatedAt: { type: Date, default: Date.now },
})

const ProblemModel = model<IProblem>('Problem', problemSchema)

export default ProblemModel

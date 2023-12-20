import { Schema, model } from 'mongoose'
import { ISubmission } from '../../../domain/entities/submission'

const submissionSchema = new Schema<ISubmission>({
  contest: {
    type: Schema.Types.ObjectId,
    ref: 'Contest',
    index: true,
  },
  participation: {
    type: Schema.Types.ObjectId,
    ref: 'Contest.participants',
    index: true,
  },
  second: {
    type: Number,
  },
  problem: {
    type: Schema.Types.ObjectId,
    ref: 'Problem',
    required: true,
    index: true,
  },
  user: {
    type: Schema.Types.ObjectId,
    ref: 'User',
    required: true,
    index: true,
  },
  userAnswer: {
    type: String,
    required: true,
  },
  point: {
    type: Number,
    default: 0,
  },
  isCorrect: {
    type: Boolean,
    required: true,
    index: true,
  },
  attemptedAt: {
    type: Date,
    default: Date.now,
    index: true,
  },
})

submissionSchema.index({ contest: 1, user: 1, problem: 1 }, { unique: true })

const SubmissionModel = model<ISubmission>('Submission', submissionSchema)

export default SubmissionModel

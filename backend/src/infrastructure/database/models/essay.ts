import { Schema, model } from 'mongoose'
import { IEssay } from '../../../domain/entities/essay'

const CONTENT_OPTIONS: string[] = ['text', 'image', 'equation', 'video']

const essaySchema = new Schema<IEssay>({
  essay: [
    {
      type: {
        type: String,
        enum: CONTENT_OPTIONS,
        required: true,
      },
      value: {
        type: String,
        required: true,
      },
    },
  ],
  createdAt: {
    type: Date,
    default: Date.now,
  },
  updatedAt: {
    type: Date,
    default: Date.now,
  },
})

const EssayModel = model<IEssay>('Essay', essaySchema)

export default EssayModel

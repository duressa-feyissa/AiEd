import { Schema, model } from "mongoose";
import { IContest } from "../../../domain/entities/contest";

const CONTEST_MODE_OPTIONS: string[] = ["marathon", "killAndPass", "custom"];
const TYPE_OPTIONS: string[] = ['text', 'image', 'video'];

const contestSchema = new Schema<IContest>({
  title: { type: String, required: true },
  mode: { type: String, enum: CONTEST_MODE_OPTIONS, required: true },
  image: { type: String },
  description: [
    {
      type: { type: String, enum: TYPE_OPTIONS, required: true },
      text: { type: String },
      image: { type: String },
      video: { type: String },
    },
  ],
  sponsor: [
    {
      type: { type: String, enum: TYPE_OPTIONS, required: true },
      text: { type: String },
      image: { type: String },
      video: { type: String },
    },
  ],
  problems: [
    {
      type: Schema.Types.ObjectId,
      ref: 'Problem',
    },
  ],
  startTime: { type: Date, required: true },
  duration: { type: Number, required: true },
  participants: [
    {
      user: {
        type: Schema.Types.ObjectId,
        ref: 'User',
      },
      registeredAt: { type: Date, default: Date.now, required: true },
      points: { type: Number, default: 0 },
      submissions: [
        {
          type: Schema.Types.ObjectId,
          ref: 'Submission',
          unique: true,
        },
      ],
    },
  ],
  creator: {
    type: Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
});

contestSchema.index({ 'participants.user': 1, 'problems': 1, 'participants.submissions': 1 }, { unique: true });

const ContestModel = model<IContest>("Contest", contestSchema);

export default ContestModel;

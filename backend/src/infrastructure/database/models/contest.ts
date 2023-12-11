import { IContest } from "../../../domain/entities/contest";
import { Schema, model } from "mongoose";

const CONTEST_MODE_OPTIONS: string[] = ["marathon", "killAndPass", "custom"];
const TYPE_OPTIONS: string[] = ['text', 'image', 'video'];

const contestSchema = new Schema<IContest>({
  title: { type: String, required: true },
  mode: { type: String, enum: CONTEST_MODE_OPTIONS, required: true },
  description: [
    {
      type: { type: String, enum: TYPE_OPTIONS, required: true },
      text: { type: String },
      image: { type: String },
      video: { type: String },
    }
  ],
  sponsor: [
    {
      type: { type: String, enum: TYPE_OPTIONS, required: true },
      text: { type: String },
      image: { type: String },
      video: { type: String },
    }
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
      type: Schema.Types.ObjectId,
      ref: 'User',
      registeredAt: { type: Date, required: true, default: Date.now },
      submissions: [
        {
          type: Schema.Types.ObjectId,
          ref: 'Submission',
        }
      ],
    },
  ],
  creator: {
    type: Schema.Types.ObjectId,
    ref: 'User',
  },
});

contestSchema.index({ title: 1, mode: 1 });
contestSchema.index({ 'participants.registeredAt': 1 });

const ContestModel = model<IContest>("Contest", contestSchema);

export default ContestModel;

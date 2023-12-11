import { Schema, model } from "mongoose";
import { IContest } from "@/domain/entities/contest";

const CONTEST_MODE_OPTIONS: string[] = ["marathon", "killAndPass", "custom"];

const contestSchema = new Schema<IContest>({
  title: { type: String, required: true },
  mode: { type: String, enum: CONTEST_MODE_OPTIONS, required: true },
  description: { type: String, required: true },
  sponsor: { type: String, required: true },
  problems: [
    {
      id: { type: String, required: true },
    },
  ],
  startTime: { type: Date, required: true },
  duration: { type: Number, required: true },
  participants: [
    {
      id: { type: String, required: true },
      registeredAt: { type: Date, required: true },
    },
  ],
  creator: {
    id: { type: String, required: true },
  },
});

contestSchema.index({ title: 1, mode: 1 });

const ContestModel = model<IContest>("Contest", contestSchema);

export default ContestModel;

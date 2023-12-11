import { IProblem } from "./problem";
import { IUser } from "./user";
const modeType: string[] = ["marathon", "killAndPass", "custom"];

export interface IContest {
  _id?: string;
  title?: string;
  mode?: (typeof modeType)[number];
  description?: string;
  sponsor?: string;
  problems: string[];
  startTime?: Date;
  duration: Number;
  participants?: string[];
  creator?: { _id: string };
  createdAt: Date;
  updatedAt: Date;
}

export default function Contest({
  _id,
  title,
  mode,
  description,
  sponsor,
  problems,
  startTime,
  duration,
  participants,
  creator,
  createdAt,
  updatedAt,
}: IContest) {
  return Object.freeze({
    getId: () => _id,
    getTitle: () => title,
    getMode: () => mode,
    getDescription: () => description,
    getSponsor: () => sponsor,
    getProblems: () => problems,
    getStartTime: () => startTime,
    getDuration: () => duration,
    getParticipants: () => participants,
    getCreator: () => creator,
  });
}

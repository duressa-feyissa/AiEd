import { Schema, model } from 'mongoose';
import { IProblem } from '../../../domain/entities/problem';

const source: string[] = ['gpt-4', 'gpt-3', 'model', 'uue', 'book', 'extreme'];
const difficulty: string[] = ['normal', 'easy', 'medium', 'hard'];
const target: string[] = ['elementary', 'university', 'highschool', 'general'];
const type: string[] = ['text', 'image', 'equation', 'video'];

const problemSchema = new Schema<IProblem>({
  published: { type: Boolean, required: true },
  source: {
    name: { type: String, enum: source, required: true },
    value: { type: String, required: true },
  },
  details: {
    target: { type: String, enum: target, required: true },
    grade: { type: Number },
    unit: { type: Number },
    courses: { type: String, required: true },
    topic: { type: String, required: true },
    difficulty: { type: String, enum: difficulty, required: true },
  },
  content: {
    type: { type: String, enum: type, required: true },
    text: { type: String },
    image: { type: String },
    equation: { type: String },
    video: { type: String },
  },
  answer: {
    type: { type: String, required: true },
    options: {
      correct: { type: String },
      choice: [{
        id: { type: String },
        text: { type: String },
        image: { type: String },
        equation: { type: String },
        video: { type: String },
      }],
    },
    short: {
      correct: { type: String },
    },
    trueFalse: {
      correct: { type: String },
    },
  },
});

const ProblemModel = model<IProblem>('Problem', problemSchema);

export default ProblemModel;

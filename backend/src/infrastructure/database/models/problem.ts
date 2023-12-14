import { Schema, model } from 'mongoose';
import { IProblem } from '../../../domain/entities/problem';

const SOURCE_OPTIONS: string[] = ['gpt-4', 'gpt-3', 'model', 'uue', 'book', 'extreme'];
const DIFFICULTY_OPTIONS: string[] = ['normal', 'easy', 'medium', 'hard'];
const TARGET_OPTIONS: string[] = ['elementary', 'university', 'highschool', 'general'];
const TYPE_OPTIONS: string[] = ['text', 'image', 'equation', 'video'];
const ANSWER_TYPE_OPTIONS: string[] = ['options', 'short', 'trueFalse'];
const COURSES_OPTIONS: string[] = ['mathematics', 'biology', 'physics', 'chemistry', 'history', 'geography', 'civics', 'economics', 'amharic', 'english', 'civics', 'computer', 'general'];

const problemSchema = new Schema<IProblem>({
  published: { type: Boolean, default: false },
  source: {
    name: { type: String, enum: SOURCE_OPTIONS, required: true },
    value: { type: String, required: true },
    year: { type: Number },
  },
  details: {
    target: { type: String, enum: TARGET_OPTIONS, required: true },
    grade: { type: Number },
    unit: { type: Number },
    courses: { type: String, enum: COURSES_OPTIONS, required: true },
    topic: { type: String, required: true },
    difficulty: { type: String, enum: DIFFICULTY_OPTIONS, required: true },
  },
  content: {
    type: { type: String, enum: TYPE_OPTIONS, required: true },
    text: { type: String },
    image: { type: String },
    equation: { type: String },
    video: { type: String },
  },
  answer: {
    type: { type: String, enum: ANSWER_TYPE_OPTIONS, required: true },
    options: {
      correct: { type: String },
      choice: [{
        id: { type: String },
        type: { type: String, enum: TYPE_OPTIONS },
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
  createdAt: { type: Date, default: Date.now },
  updatedAt: { type: Date, default: Date.now },
});

problemSchema.index({ 'details.target': 1 });
problemSchema.index({ 'details.difficulty': 1 });

const ProblemModel = model<IProblem>('Problem', problemSchema);

export default ProblemModel;

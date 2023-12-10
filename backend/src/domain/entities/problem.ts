const source: string[] = ['gpt-4', 'gpt-3', 'model', 'uue', 'book', 'extreme'];
const difficulty: string[] = ['normal', 'easy', 'medium', 'hard'];
const target: string[] = ['elementary', 'university', 'highschool', 'general'];
const type: string[] = ['text', 'image', 'equation', 'video'];

export interface IProblem {
  _id?: string;
  published: boolean;
  source: {
    name: typeof source[number];
    value: string;
  };
  details: {
    target: typeof target[number];
    grade?: number;
    unit?: number;
    courses: string;
    topic: string;
    difficulty: typeof difficulty[number];
  };
  content: {
    type: typeof type[number];
    text?: string;
    image?: string;
    equation?: string;
    video?: string;
  };
  answer: {
    type: string;
    options?: {
      correct: string;
      choice: {
        id: string;
        text?: string;
        image?: string;
        equation?: string;
        video?: string;
      }[];
    };
    short?: {
      correct: string;
    };
    trueFalse?: {
      correct: string;
    };
  };
}

export default function Problem({
  _id,
  published,
  source,
  details,
  content,
  answer,
}: IProblem) {
  return Object.freeze({
    getId: () => _id,
    getPublished: () => published,
    getSource: () => source,
    getDetails: () => details,
    getContent: () => content,
    getAnswer: () => answer,
  });
}

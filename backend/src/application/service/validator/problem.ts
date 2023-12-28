import * as Joi from 'joi'

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

export function validateProblem(problem: any) {
  const schema = Joi.object({
    published: Joi.boolean().required(),
    source: Joi.object({
      name: Joi.string()
        .valid(...SOURCE_OPTIONS)
        .required(),
      value: Joi.string(),
      year: Joi.number(),
    }).required(),
    details: Joi.object({
      target: Joi.string()
        .valid(...TARGET_OPTIONS)
        .required(),
      grade: Joi.string(),
      unit: Joi.string(),
      courses: Joi.string()
        .valid(...COURSES_OPTIONS)
        .required(),
      topic: Joi.string(),
      difficulty: Joi.string().valid(...DIFFICULTY_OPTIONS),
    }).required(),
    question: Joi.array().items(
      Joi.object({
        type: Joi.string()
          .valid(...CONTENT_OPTIONS)
          .required(),
        value: Joi.string().required(),
      }),
    ),
    point: Joi.object({
      correct: Joi.number().required(),
      wrong: Joi.number().required(),
    }).required(),
    answer: Joi.object({
      type: Joi.string()
        .valid(...ANSWER_TYPE_OPTIONS)
        .required(),
      options: Joi.object({
        choice: Joi.array().items(
          Joi.object({
            correct: Joi.boolean().required(),
            data: Joi.array()
              .items(
                Joi.object({
                  type: Joi.string()
                    .valid(...CONTENT_OPTIONS)
                    .required(),
                  value: Joi.string().required(),
                }),
              )
              .required(),
          }),
        ),
      }),
      short: Joi.object({
        correct: Joi.string(),
      }),
      trueFalse: Joi.object({
        correct: Joi.string(),
      }),
      explanation: Joi.array().items(
        Joi.object({
          type: Joi.string().valid(...CONTENT_OPTIONS),
          value: Joi.string(),
        }),
      ),
    }).required(),
    essay: Joi.string().regex(/^[0-9a-fA-F]{24}$/),
    createdAt: Joi.date(),
    updatedAt: Joi.date(),
  })

  return schema.validate(problem)
}

export default validateProblem

import * as Joi from 'joi'

export function validateSubmission(submission: any) {
  const schema = Joi.object({
    contest: Joi.string(),
    participation: Joi.string(),
    second: Joi.number(),
    problem: Joi.string().required(),
    user: Joi.string().required(),
    userAnswer: Joi.string().required(),
    point: Joi.number(),
    isCorrect: Joi.boolean(),
    attemptedAt: Joi.date(),
  })

  return schema.validate(submission)
}

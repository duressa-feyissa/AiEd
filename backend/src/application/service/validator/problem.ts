import * as Joi from 'joi';

export default function validateProblem(problem: any) {
  const schema = Joi.object({
    published: Joi.boolean().required(),
    source: Joi.object({
      name: Joi.string().valid('gpt-4', 'gpt-3', 'model', 'uue', 'book', 'extreme').required(),
      value: Joi.string().required(),
      year: Joi.number(),
    }).required(),
    details: Joi.object({
      target: Joi.string().valid('elementary', 'university', 'highschool', 'general').required(),
      grade: Joi.number(),
      unit: Joi.number(),
      courses: Joi.string().valid('mathematics', 'biology', 'physics', 'chemistry', 'history', 'geography', 'civics', 'economics', 'amharic', 'english', 'civics', 'computer', 'general').required(),
      topic: Joi.string().required(),
      difficulty: Joi.string().valid('normal', 'easy', 'medium', 'hard').required(),
    }).required(),
    content: Joi.object({
      type: Joi.string().valid('text', 'image', 'equation', 'video').required(),
      text: Joi.string(),
      image: Joi.string(),
      equation: Joi.string(),
      video: Joi.string(),
    }).required(),
    answer: Joi.object({
      type: Joi.string().valid('options', 'short', 'trueFalse').required(),
      options: Joi.object({
        correct: Joi.string(),
        choice: Joi.array().items(
          Joi.object({
            id: Joi.string(),
            type: Joi.string().valid('text', 'image', 'equation', 'video'),
            text: Joi.string(),
            image: Joi.string(),
            equation: Joi.string(),
            video: Joi.string(),
          })
        ),
      }),
      short: Joi.object({
        correct: Joi.string(),
      }),
      trueFalse: Joi.object({
        correct: Joi.string(),
      }),
    }).required(),
  });

  return schema.validate(problem);
}

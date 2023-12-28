import * as Joi from 'joi';

const CONTENT_OPTIONS: string[] = ['text', 'image', 'equation', 'video'];

const essayValidationSchema = Joi.object({
  _id: Joi.string(),
  essay: Joi.array().items(
    Joi.object({
      type: Joi.string().valid(...CONTENT_OPTIONS).required(),
      value: Joi.string().required(),
    })
  ).required(),
  createdAt: Joi.date(),
  updatedAt: Joi.date(),
});

export default essayValidationSchema;

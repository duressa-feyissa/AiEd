import * as Joi from 'joi';

export default function validateContest(contest: any) {
  const schema = Joi.object({
    title: Joi.string().required(),
    image: Joi.string(),
    mode: Joi.string().valid('marathon', 'killAndPass', 'custom').required(),
    description: Joi.array().items(
      Joi.object({
        type: Joi.string().valid('text', 'image', 'video').required(),
        text: Joi.string(),
        image: Joi.string(),
        video: Joi.string(),
      })
    ),
    sponsor: Joi.array().items(
      Joi.object({
        type: Joi.string().valid('text', 'image', 'video').required(),
        text: Joi.string(),
        image: Joi.string(),
        video: Joi.string(),
      })
    ),
    problems: Joi.array().items(
      Joi.object({
        id: Joi.string().required(),
      })
    ),
    startTime: Joi.date().required(),
    duration: Joi.number().required(),
    participants: Joi.array().items(
      Joi.object({
        user: Joi.string().required(),
        registeredAt: Joi.date().required(),
        submissions: Joi.array().items(Joi.string().required()),
      })
    ),
    creator: Joi.object({
      _id: Joi.string().required(),
    }),
  });

  return schema.validate(contest);
}

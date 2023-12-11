import * as Joi from "joi";

export default function validateContest(contest: any) {
  const schema = Joi.object({
    title: Joi.string().required(),
    mode: Joi.string().valid("marathon", "killAndPass", "custom").required(),
    description: Joi.string().required(),
    sponsor: Joi.string().required(),
    problems: Joi.array().items(
      Joi.object({
        id: Joi.string().required(),
      })
    ),
    startTime: Joi.date().required(),
    duration: Joi.number().required(),
    participants: Joi.array().items(
      Joi.object({
        id: Joi.string().required(),
        registeredAt: Joi.date().required(),
      })
    ),
    creator: Joi.object({
      id: Joi.string().required(),
    }),
  });

  return schema.validate(contest);
}

import * as Joi from 'joi'

export default function validateProblem(problem: any)  {
    const schema = Joi.object({
      
    })
    return schema.validate(problem)
  }
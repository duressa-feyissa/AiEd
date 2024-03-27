import * as Joi from 'joi'

const userRoles: string[] = ['ADMIN', 'MASTER', 'USER']

export default function validateUser(user: any) {
  const schema = Joi.object({
    username: Joi.string().trim().min(3).max(30),
    firstName: Joi.string().trim().min(3).max(30),
    lastName: Joi.string().trim().min(3).max(30),
    phone: Joi.string().trim().min(3).max(30),
    email: Joi.string().trim().email().required(),
    password: Joi.string().trim().min(6).max(30),
    role: Joi.string()
      .trim()
      .valid(...userRoles),
    dateOfBirth: Joi.date(),
    school: Joi.string().trim().min(3).max(30),
    grade: Joi.string().trim().min(1).max(30),
    image: Joi.string().trim(),
    cover: Joi.string().trim(),
  })
  return schema.validate(user)
}

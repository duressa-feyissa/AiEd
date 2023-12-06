import * as Joi from 'joi'
import mongoose, { Document, Schema } from 'mongoose'
const { String } = mongoose.Schema.Types

const userRoles: string[] = ['ADMIN', 'USER']

export interface IUser extends Document {
  username?: string
  firstName?: string
  lastName?: string
  phone?: string
  email: string
  password?: string
  role: string
  verify?: boolean
  dateOfBirth?: Date
  school?: string
  grade?: string
  image?: string
  cover?: string
  createAt: Date
  points?: number
}

const UserSchema: Schema<IUser> = new Schema({
  username: {
    type: String,
    trim: true,
    unique: true,
  },
  firstName: {
    type: String,
    trim: true,
    lowercase: true,
  },
  lastName: {
    type: String,
    trim: true,
    lowercase: true,
  },
  phone: {
    type: String,
    trim: true,
  },
  email: {
    type: String,
    required: [true, 'Email is required'],
    trim: true,
    unique: true,
  },
  password: {
    type: String,
    trim: true,
  },
  role: {
    type: String,
    enum: userRoles,
    default: 'USER',
  },
  verify: {
    type: Boolean,
    default: false,
  },
  dateOfBirth: {
    type: Date,
  },
  school: {
    type: String,
    trim: true,
  },
  grade: {
    type: String,
    trim: true,
  },
  image: {
    type: String,
  },
  cover: {
    type: String,
  },
  createAt: {
    type: Date,
    default: Date.now,
  },
  points: {
    type: Number,
    default: 0,
  },
})

UserSchema.index({ role: 1 })

const UserModel = mongoose.model<IUser>('User', UserSchema)

export const validateUser = (user: any) => {
  const schema = Joi.object({
    username: Joi.string().trim().min(3).max(30),
    firstName: Joi.string().trim().min(3).max(30),
    lastName: Joi.string().trim().min(3).max(30),
    phone: Joi.string().trim().min(3).max(30),
    email: Joi.string().trim().email().required(),
    password: Joi.string().trim().min(6).max(30),
    role: Joi.string().trim().valid(...userRoles),
    dateOfBirth: Joi.date(),
    school: Joi.string().trim().min(3).max(30),
    grade: Joi.string().trim().min(3).max(30),
    image: Joi.string().trim(),
    cover: Joi.string().trim(),
  })
  return schema.validate(user)
}

export default UserModel



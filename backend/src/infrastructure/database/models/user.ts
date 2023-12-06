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

export default UserModel

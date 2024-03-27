import { Express, Router } from 'express'
import authRouter from './auth'
import contestRouter from './contest'
import problemRouter from './problem'
import submissionRouter from './submission'
import userRouter from './user'

export default function routes(app: Express) {
  app.use('/api/v1/auth/', authRouter(Router()))
  app.use('/api/v1/users/', userRouter(Router()))
  app.use('/api/v1/problems/', problemRouter(Router()))
  app.use('/api/v1/contests/', contestRouter(Router()))
  app.use('/api/v1/submissions/', submissionRouter(Router()))
}

import { Express, Router } from 'express'
import authRouter from './auth'
import problemRouter from './problem'
import userRouter from './user'

export default function routes(app: Express) {
  app.use('/api/v1/auth/', authRouter(Router()))
  app.use('/api/v1/users/', userRouter(Router()))
  app.use('/api/v1/problems/', problemRouter(Router()))
}

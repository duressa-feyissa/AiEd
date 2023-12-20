export interface IUser {
  _id?: string
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
  createdAt: Date
  points?: number
}

export default function User({
  _id,
  password,
  username,
  firstName,
  lastName,
  phone,
  role,
  email,
  verify,
  dateOfBirth,
  school,
  grade,
  image,
  cover,
  createdAt,
  points,
}: IUser) {
  return Object.freeze({
    getId: () => _id,
    getPassword: () => password,
    getUsername: () => username,
    getFirstName: () => firstName,
    getLastName: () => lastName,
    getPhone: () => phone,
    getEmail: () => email,
    getRole: () => role,
    getVerify: () => verify,
    getDateOfBirth: () => dateOfBirth,
    getSchool: () => school,
    getGrade: () => grade,
    getImage: () => image,
    getCover: () => cover,
    getCreatedAt: () => createdAt,
    getPoints: () => points,
  })
}

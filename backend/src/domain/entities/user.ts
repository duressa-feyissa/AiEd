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
    createAt: Date
    points?: number
  }
  
  export default function user({
    _id,
    password,
    username,
    firstName,
    lastName,
    phone,
    role,
    verify,
    dateOfBirth,
    school,
    grade,
    image,
    cover,
    createAt,
    points,
  }: IUser) {
    return Object.freeze({
      getId: () => _id,
      getPassword: () => password,
      getUsername: () => username,
      getFirstName: () => firstName,
      getLastName: () => lastName,
      getPhone: () => phone,
      getRole: () => role,
      getVerify: () => verify,
      getDateOfBirth: () => dateOfBirth,
      getSchool: () => school,
      getGrade: () => grade,
      getImage: () => image,
      getCover: () => cover,
      getCreateAt: () => createAt,
      getPoints: () => points,
    })
  }
  
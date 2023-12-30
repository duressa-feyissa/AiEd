import removeUser from '../../../application/use_cases/user/delete'
import findById from '../../../application/use_cases/user/findById'
import viewAllUsers from '../../../application/use_cases/user/views'
import CustomError from '../../../config/error'
import { IUser } from '../../../domain/entities/user'
import userDbRepository from '../../../domain/repositories/user'

jest.mock('../../../domain/repositories/user')

interface ViewAllUsersParams {
  skip: number
  limit: number
  search?: string
  sort?: Record<string, 1 | -1>
}

describe('User Use Cases', () => {
  const mockedRepository: ReturnType<typeof userDbRepository> = {
    viewAllUsers: jest.fn(),
    deleteUser: jest.fn(),
    findById: jest.fn(),
    findByUsername: jest.fn(),
    findByEmail: jest.fn(),
    findByUsernameOrEmail: jest.fn(),
    findByPhone: jest.fn(),
    createUser: jest.fn(),
  }

  const mockUser: IUser = {
    firstName: 'John',
    lastName: 'Doe',
    email: 'duresafeyisa2025@gmail.com',
    phone: '0912345678',
    image: 'https://res.cloudinary.com/123.jpg',
    cover: 'https://res.cloudinary.com/123.jpg',
    role: 'USER',
    verify: false,
    points: 0,
    _id: '6570903a497e5790f47d13c9',
    createdAt: new Date(),
  }

  const mockUsers: IUser[] = [
    {
      firstName: 'John',
      lastName: 'Doe',
      email: 'duresafeyisa2025@gmail.com',
      phone: '0912345678',
      image: 'https://res.cloudinary.com/123.jpg',
      cover: 'https://res.cloudinary.com/123.jpg',
      role: 'USER',
      verify: false,
      points: 0,
      _id: '6570903a497e5790f47d13c9',
      createdAt: new Date(),
    },
    {
      email: 'aser@gmail.com',
      role: 'USER',
      verify: false,
      points: 0,
      _id: '6570903a497e5790f47d13c1',
      createdAt: new Date(),
    },
  ]

  describe('viewAllUsers', () => {
    const params: ViewAllUsersParams = {
      skip: 0,
      limit: 10,
    }

    it('should call viewAllUsers method from userRepository with the provided params', async () => {
      // Act
      await viewAllUsers(params, mockedRepository)

      // Assert
      expect(mockedRepository.viewAllUsers).toHaveBeenCalledWith(params)
    })

    it('should return the users', async () => {
      // Arrange
      const mockViewAllUsers = jest.fn()
      mockedRepository.viewAllUsers = mockViewAllUsers
      mockViewAllUsers.mockResolvedValue(mockUsers)

      // Act
      const result = await viewAllUsers(params, mockedRepository)

      // Assert
      expect(mockViewAllUsers).toHaveBeenCalledWith(params)
      expect(result).toEqual(mockUsers)
      expect(result).toHaveLength(2)
      expect(result[0]).toHaveProperty('firstName', 'John')
      expect(result[0]).toHaveProperty('lastName', 'Doe')
      expect(result[0]).toHaveProperty('email', 'duresafeyisa2025@gmail.com')
      expect(result[0]).toHaveProperty('phone', '0912345678')
      expect(result[0]).toHaveProperty(
        'image',
        'https://res.cloudinary.com/123.jpg',
      )
      expect(result[0]).toHaveProperty(
        'cover',
        'https://res.cloudinary.com/123.jpg',
      )
      expect(result[0]).toHaveProperty('role', 'USER')
      expect(result[0]).toHaveProperty('verify', false)
      expect(result[0]).toHaveProperty('points', 0)
      expect(result[0]).toHaveProperty('_id', '6570903a497e5790f47d13c9')
      expect(result[0]).toHaveProperty('createdAt')
      expect(result[1]).toHaveProperty('email', 'aser@gmail.com')
      expect(result[1]).toHaveProperty('role', 'USER')
      expect(result[1]).toHaveProperty('verify', false)
      expect(result[1]).toHaveProperty('points', 0)
      expect(result[1]).toHaveProperty('_id', '6570903a497e5790f47d13c1')
      expect(result[1]).toHaveProperty('createdAt')
      expect(result[1]).not.toHaveProperty('firstName')
      expect(result[1]).not.toHaveProperty('lastName')
      expect(result[1]).not.toHaveProperty('phone')
      expect(result[1]).not.toHaveProperty('image')
      expect(result[1]).not.toHaveProperty('cover')
    })

    it('should return the users with search', async () => {
      // Arrange
      const mockViewAllUsers = jest.fn()
      mockedRepository.viewAllUsers = mockViewAllUsers
      mockViewAllUsers.mockResolvedValue(mockUsers)
      params.search = 'John'

      // Act
      const result = await viewAllUsers(params, mockedRepository)

      // Assert
      expect(mockViewAllUsers).toHaveBeenCalledWith(params)
      expect(result).toEqual(mockUsers)
      expect(result).toHaveLength(2)
      expect(result[0]).toHaveProperty('firstName', 'John')
      expect(result[0]).toHaveProperty('lastName', 'Doe')
      expect(result[0]).toHaveProperty('email', 'duresafeyisa2025@gmail.com')
      expect(result[0]).toHaveProperty('phone', '0912345678')
      expect(result[0]).toHaveProperty(
        'image',
        'https://res.cloudinary.com/123.jpg',
      )
      expect(result[0]).toHaveProperty(
        'cover',
        'https://res.cloudinary.com/123.jpg',
      )
      expect(result[0]).toHaveProperty('role', 'USER')
      expect(result[0]).toHaveProperty('verify', false)
      expect(result[0]).toHaveProperty('points', 0)
      expect(result[0]).toHaveProperty('_id', '6570903a497e5790f47d13c9')
      expect(result[0]).toHaveProperty('createdAt')
    })

    it('should return empty array if no user found', async () => {
      // Arrange
      const mockViewAllUsers = jest.fn()
      mockedRepository.viewAllUsers = mockViewAllUsers
      mockViewAllUsers.mockResolvedValue([])

      // Act
      const result = await viewAllUsers(params, mockedRepository)

      // Assert
      expect(mockViewAllUsers).toHaveBeenCalledWith(params)
      expect(result).toEqual([])
      expect(result).toHaveLength(0)
    })
  })

  describe('removeUser', () => {
    const userId = '6570903a497e5790f47d13c9'

    it('should return the deleted user', async () => {
      // Arrange
      const mockDeleteUser = jest.fn()
      mockedRepository.deleteUser = mockDeleteUser
      mockDeleteUser.mockResolvedValue(mockUser)

      // Act
      const result = await removeUser(userId, mockedRepository)

      // Assert
      expect(mockDeleteUser).toHaveBeenCalledWith(userId)
      expect(result).toEqual(mockUser)
      expect(result).toHaveProperty('firstName', 'John')
      expect(result).toHaveProperty('lastName', 'Doe')
      expect(result).toHaveProperty('email', 'duresafeyisa2025@gmail.com')
      expect(result).toHaveProperty('phone', '0912345678')
      expect(result).toHaveProperty(
        'image',
        'https://res.cloudinary.com/123.jpg',
      )
      expect(result).toHaveProperty(
        'cover',
        'https://res.cloudinary.com/123.jpg',
      )
      expect(result).toHaveProperty('role', 'USER')
      expect(result).toHaveProperty('verify', false)
      expect(result).toHaveProperty('points', 0)
      expect(result).toHaveProperty('_id', '6570903a497e5790f47d13c9')
      expect(result).toHaveProperty('createdAt')
    })

    it('should throw an error if the provided id is not valid', async () => {
      // Arrange
      const error = new CustomError(`${userId} is not a valid user id`, 400)

      const mockDeleteUser = jest.fn()
      mockedRepository.deleteUser = mockDeleteUser
      mockDeleteUser.mockRejectedValue(error)

      // Act and Assert
      await expect(removeUser(userId, mockedRepository)).rejects.toEqual(error)
      expect(mockDeleteUser).toHaveBeenCalledWith(userId)
    })

    it('should throw an error if the provided id is not found', async () => {
      // Arrange
      const userId = '6570903a497e5790f47d13c9'
      const error = new CustomError(`User with id ${userId} not found`, 404)

      const mockDeleteUser = jest.fn()
      mockedRepository.deleteUser = mockDeleteUser
      mockDeleteUser.mockRejectedValue(error)

      // Act and Assert
      await expect(removeUser(userId, mockedRepository)).rejects.toEqual(error)
      expect(mockDeleteUser).toHaveBeenCalledWith(userId)
    })
  })

  describe('findUserById', () => {
    const userId = '6570903a497e5790f47d13c9'

    it('should return the deleted user', async () => {
      // Arrange
      const mockfindUserById = jest.fn()
      mockedRepository.findById = mockfindUserById
      mockfindUserById.mockResolvedValue(mockUser)

      // Act
      const result = await findById(userId, mockedRepository)

      // Assert
      expect(mockfindUserById).toHaveBeenCalledWith(userId)
      expect(result).toEqual(mockUser)
      expect(result).toHaveProperty('firstName', 'John')
      expect(result).toHaveProperty('lastName', 'Doe')
      expect(result).toHaveProperty('email', 'duresafeyisa2025@gmail.com')
      expect(result).toHaveProperty('phone', '0912345678')
      expect(result).toHaveProperty(
        'image',
        'https://res.cloudinary.com/123.jpg',
      )
      expect(result).toHaveProperty(
        'cover',
        'https://res.cloudinary.com/123.jpg',
      )
      expect(result).toHaveProperty('role', 'USER')
      expect(result).toHaveProperty('verify', false)
      expect(result).toHaveProperty('points', 0)
      expect(result).toHaveProperty('_id', '6570903a497e5790f47d13c9')
      expect(result).toHaveProperty('createdAt')
    })

    it('should throw an error if the provided id is not valid', async () => {
      // Arrange
      const error = new CustomError(`${userId} is not a valid user id`, 400)

      const mockfindUserById = jest.fn()
      mockedRepository.findById = mockfindUserById
      mockfindUserById.mockRejectedValue(error)

      // Act and Assert
      await expect(findById(userId, mockedRepository)).rejects.toEqual(error)
      expect(mockfindUserById).toHaveBeenCalledWith(userId)
    })

    it('should throw an error if the provided id is not found', async () => {
      // Arrange
      const userId = '6570903a497e5790f47d13c9'
      const error = new CustomError(`User with id ${userId} not found`, 404)

      const mockfindUserById = jest.fn()
      mockedRepository.findById = mockfindUserById
      mockfindUserById.mockRejectedValue(error)

      // Act and Assert
      await expect(findById(userId, mockedRepository)).rejects.toEqual(error)
      expect(mockfindUserById).toHaveBeenCalledWith(userId)
    })
  })
})

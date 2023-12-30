import UserModel from '../../../infrastructure/database/models/user'
import userRepositoryMongoDB, {
  IUserRepositoryImpl,
} from '../../../infrastructure/repositories/user'

jest.mock('../../../infrastructure/database/models/user', () => ({
  __esModule: true,
  default: {
    findById: jest.fn(),
  },
}))

const mockedUserModel = UserModel as jest.Mocked<typeof UserModel>

describe('User Repository MongoDB Tests', () => {
  let userRepository: ReturnType<IUserRepositoryImpl>

  beforeEach(() => {
    userRepository = userRepositoryMongoDB()
    mockedUserModel.findById.mockClear()
  })

  describe('findById', () => {
    it('should find user by id', async () => {
      const mockUser = {
        _id: '6570a0ae7416e1bcf1ec3dd6',
        firstName: 'John',
        lastName: 'Doe',
        username: 'johndoe',
      }

      mockedUserModel.findById.mockReturnValueOnce({
        select: jest.fn().mockReturnThis(),
        then: jest.fn().mockResolvedValueOnce(mockUser),
      } as any)

      const result = await userRepository.findById('6570a0ae7416e1bcf1ec3dd6')
      expect(result).toEqual(mockUser)
      expect(mockedUserModel.findById).toHaveBeenCalledWith(
        '6570a0ae7416e1bcf1ec3dd6',
      )
    })
  })
})

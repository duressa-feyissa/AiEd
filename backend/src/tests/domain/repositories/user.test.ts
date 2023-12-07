import CustomError from '../../../config/error';
import { IUser } from '../../../domain/entities/user';
import userDbRepository from '../../../domain/repositories/user';
import userRepositoryMongoDB from '../../../infrastructure/repositories/user';

jest.mock('../../../infrastructure/repositories/user');

const mockUser: IUser = {
  _id: 'mockUserId',
  username: 'mockUsername',
  firstName: 'John',
  lastName: 'Doe',
  phone: '123456789',
  email: 'john.doe@example.com',
  password: 'mockPassword',
  role: 'USER',
  verify: true,
  dateOfBirth: new Date('1990-01-01'),
  school: 'Mock School',
  grade: '12',
  image: 'mock-image-url',
  cover: 'mock-cover-url',
  createdAt: new Date(),
  points: 100,
};

describe('userDbRepository', () => {
  let repository: ReturnType<typeof userRepositoryMongoDB>;
  let userRepository: ReturnType<typeof userDbRepository>;

  beforeEach(() => {
    repository = userRepositoryMongoDB();
    userRepository = userDbRepository(repository);
  });

  describe('findById', () => {

    const userId = '6570903a497e5790f47d13c9';

    it('should call findById method with the provided id', async () => {
      // Arrange
      const expectedUser = mockUser;
      userRepository.findById = jest.fn().mockResolvedValue(expectedUser);
  
      // Act
      const result = await userRepository.findById(userId);
  
      // Assert
      expect(userRepository.findById).toHaveBeenCalledWith(userId);
      expect(result).toEqual(expectedUser);
      expect(result).toBeInstanceOf(Object);
      expect(result).toHaveProperty('firstName', 'John');
      expect(result).toHaveProperty('lastName', 'Doe');
      expect(result).toHaveProperty('email', 'john.doe@example.com');
      expect(result).toHaveProperty('role', 'USER');
      expect(result).toHaveProperty('createdAt');
      expect(result).toHaveProperty('verify', true);
      expect(result).toHaveProperty('dateOfBirth');
      expect(result).toHaveProperty('school', 'Mock School');
      expect(result).toHaveProperty('grade', '12');
      expect(result).toHaveProperty('image', 'mock-image-url');
      expect(result).toHaveProperty('cover', 'mock-cover-url');
      expect(result).toHaveProperty('points', 100);
    }); 

    it('should throw an error if the provided id is not valid', async () => {
      // Arrange
      const error = new CustomError(`${userId} is not a valid user id`, 400);

      userRepository.findById = jest.fn().mockRejectedValue(error);

      const result = userRepository.findById(userId);

      // Assert
      expect(userRepository.findById).toHaveBeenCalledWith(userId);
      await expect(result).rejects.toThrow(error);

    });

    it('should throw an error if the provided id is not found', async () => {

      const error = new CustomError(`User with id ${userId} not found`, 404);

      userRepository.findById = jest.fn().mockRejectedValue(error);

      const result = userRepository.findById(userId);

      // Assert
      expect(userRepository.findById).toHaveBeenCalledWith(userId);
      await expect(result).rejects.toThrow(error);

    });
  });

 
});




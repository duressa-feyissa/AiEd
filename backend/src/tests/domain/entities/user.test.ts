import User, { IUser } from '../../../domain/entities/user';

describe('User Factory Tests', () => {

      it('should create a user with the minimal required properties', () => {
        const mockUserData: IUser = {
            email: 'john.doe@example.com',
            role: 'USER',
            createdAt: new Date(),
          };
        const createdUser = User(mockUserData);
        expect(createdUser.getId()).toBeUndefined();
        expect(createdUser.getPassword()).toBeUndefined();
        expect(createdUser.getUsername()).toBeUndefined();
        expect(createdUser.getEmail()).toEqual(mockUserData.email);
        expect(createdUser.getRole()).toEqual(mockUserData.role);
        expect(createdUser.getCreatedAt()).toEqual(mockUserData.createdAt);
      });

  it('should create a user with the expected properties', () => {
    const mockUserData: IUser = {
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

    const createdUser = User(mockUserData);
    expect(createdUser.getId()).toEqual(mockUserData._id);
    expect(createdUser.getPassword()).toEqual(mockUserData.password);
    expect(createdUser.getUsername()).toEqual(mockUserData.username);
    expect(createdUser.getFirstName()).toEqual(mockUserData.firstName);
    expect(createdUser.getLastName()).toEqual(mockUserData.lastName);
    expect(createdUser.getPhone()).toEqual(mockUserData.phone);
    expect(createdUser.getRole()).toEqual(mockUserData.role);
    expect(createdUser.getVerify()).toEqual(mockUserData.verify);
    expect(createdUser.getDateOfBirth()).toEqual(mockUserData.dateOfBirth);
    expect(createdUser.getSchool()).toEqual(mockUserData.school);
    expect(createdUser.getGrade()).toEqual(mockUserData.grade);
    expect(createdUser.getImage()).toEqual(mockUserData.image);
    expect(createdUser.getCover()).toEqual(mockUserData.cover);
    expect(createdUser.getCreatedAt()).toEqual(mockUserData.createdAt);
    expect(createdUser.getPoints()).toEqual(mockUserData.points);
  });
});

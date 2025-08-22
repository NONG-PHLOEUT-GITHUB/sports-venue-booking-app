import '../entities/user.dart';

abstract class UserRepository {
  Future<User?> getUser(String id);
  Future<void> createUser(User user);
}

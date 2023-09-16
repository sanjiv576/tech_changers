import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

final authUseCaseProvider = Provider<AuthUseCase>((ref) {
  return AuthUseCase(ref.read(authRepositoryProvider));
});

class AuthUseCase {
  final IAuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  // for register

  Future<Either<Failure, bool>> registerUser(UserEntity user) {
    return _authRepository.registerUser(user);
  }

// for user login
  Future<Either<Failure, UserEntity>> loginUser(String contact, String password) {
    return _authRepository.loginUser(contact, password);
  }
}

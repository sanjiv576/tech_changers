import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/auth_remote_repository.dart';
import '../entity/user_entity.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return ref.read(authRemoteRepositoryProvider);
});

abstract class IAuthRepository {

  // abstract method for users
  Future<Either<Failure, bool>> registerUser(UserEntity user);
  Future<Either<Failure, UserEntity>> loginUser(String contact, String password);
}

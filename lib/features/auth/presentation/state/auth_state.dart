import 'package:my_project/features/auth/domain/entity/user_entity.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final String? imageName;
  final UserEntity? singleUser;

  AuthState(
      {required this.isLoading, this.error, this.imageName, this.singleUser});

  // initial values
  factory AuthState.initial() {
    return AuthState(
      isLoading: false,
      error: null,
      imageName: null,
      singleUser: null,
    );
  }

  AuthState copyWith(
      {bool? isLoading,
      String? error,
      String? imageName,
      UserEntity? singleUser}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
      singleUser: singleUser ?? singleUser,
    );
  }
}

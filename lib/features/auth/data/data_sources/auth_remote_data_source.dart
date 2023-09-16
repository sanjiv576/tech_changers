import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_services.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/user_entity.dart';

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
    ref.read(httpServicesProvider),
    ref.read(userSharedPrefsProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio _dio;
  final UserSharedPrefs _userSharedPrefs;

  AuthRemoteDataSource(this._dio, this._userSharedPrefs);

  // user register

  Future<Either<Failure, bool>> registerUser(UserEntity userEntity) async {
    try {
      Response res = await _dio.post(ApiEndpoints.register, data: {
        "fullName": userEntity.fullName,
        "contactNumber": userEntity.contactNumber,
        "address": userEntity.address,
        "password": userEntity.password,
      });
      if (res.statusCode == 201) {
        return const Right(true);
      }

      // throw error if failed in register

      return Left(
        Failure(
          error: res.data['error'],
          statusCode: res.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0'));
    }
  }

  // user login

  Future<Either<Failure, UserEntity>> loginUser(
      String contactNumber, String password) async {
    try {
      Response res = await _dio.post(ApiEndpoints.login, data: {
        "contactNumber": contactNumber,
        "password": password,
      });
      if (res.statusCode == 200) {
        String token = res.data['token'];

        // set the user token in shared prefs
        await _userSharedPrefs.setUserToken(token);

        print('User token : $token');

        // get the user data
        UserEntity userEntity = UserEntity(
          fullName: res.data['user']['fullName'],
          contactNumber: res.data['user']['contactNumber'],
          address: res.data['user']['address'],
          role: res.data['user']['role'],
          userPhoto: res.data['user']['userPhoto'],
        );

        // also store the user data in shared prefs
        _userSharedPrefs.setUser(userEntity);

        print(userEntity);
        return Right(userEntity);
      }
      // throw error if failed in login
      return Left(
        Failure(
          error: res.data['error'],
          statusCode: res.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0'));
    }
  }

  // shared pres
}

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/domain/entity/user_entity.dart';
import '../failure/failure.dart';

final userSharedPrefsProvider =
    Provider<UserSharedPrefs>((ref) => UserSharedPrefs());

class UserSharedPrefs {
  late SharedPreferences _sharedPreferences;

  // set user token

  Future<Either<Failure, bool>> setUserToken(String token) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      await _sharedPreferences.setString('token', token);
      return const Right(true);
    } catch (err) {
      return Left(Failure(error: err.toString()));
    }
  }

  void clearSharedPrefs() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      await _sharedPreferences.clear();
    } catch (err) {
      print('Error during loging out from shared prefs: $err');
    }
  }

  // get user token

  Future<Either<Failure, String?>> getUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      final userToken = _sharedPreferences.getString('token');

      return Right(userToken);
    } catch (err) {
      return Left(Failure(error: err.toString()));
    }
  }

  // set user data
  Future<Either<Failure, bool>> setUser(UserEntity user) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      // convert the user entity to json string
      final userJson = user.toJson();
      // store the JSON string in shared prefs
      await _sharedPreferences.setString('user', jsonEncode(userJson));

      return const Right(true);
    } catch (err) {
      print('Failed to store user entity');
      return Left(Failure(error: err.toString()));
    }
  }

  // get the user data
  Future<Either<Failure, UserEntity?>> getUser() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      // Get the JSON string from SharedPreferences
      final userJson = _sharedPreferences.getString('user');
      if (userJson != null) {
        // Convert the JSON string to a Map
        final userData = jsonDecode(userJson);
        // Create a UserEntity object from the Map
        final user = UserEntity.fromJson(userData);
        return Right(user);
      } else {
        return Left(Failure(error: 'User not found'));
      }
    } catch (err) {
      return Left(Failure(error: err.toString()));
    }
  }
}

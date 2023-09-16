import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_services.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/routine_entity.dart';
import '../dto/get_all_routine_dto.dart';
import '../model/routine_api_model.dart';

final routineRemoteDataSourceProvider =
    Provider<RoutineRemoteDataSource>((ref) {
  final dio = ref.watch(httpServicesProvider);
  final userSharedPrefs = ref.watch(userSharedPrefsProvider);
  final routineApiModel = ref.watch(routineApiModelProvider);

  return RoutineRemoteDataSource(dio, userSharedPrefs, routineApiModel);
});

class RoutineRemoteDataSource {
  final Dio _dio;
  final UserSharedPrefs _userSharedPrefs;
  final RoutineApiModel _routineApiModel;

  RoutineRemoteDataSource(
      this._dio, this._userSharedPrefs, this._routineApiModel);

  // get all routines
  Future<Either<Failure, List<RoutineEntity>>> getAllRoutine() async {
    try {
      Response res = await _dio.get(ApiEndpoints.routine);

      if (res.statusCode == 200) {
        // converting the json object from Api into Model
        GetAllRoutineDTO getAllRoutineDTO = GetAllRoutineDTO.fromJson(res.data);

        return Right(_routineApiModel.toEntityList(getAllRoutineDTO.data));
      } else {
        return Left(Failure(
            error: res.statusMessage ?? 'Something went wrong',
            statusCode: res.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}

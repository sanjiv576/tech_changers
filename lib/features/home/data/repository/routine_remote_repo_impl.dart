import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/routine_entity.dart';
import '../../domain/repository/routine_repository.dart';
import '../data_sources/routine_remote_data_source.dart';

final routineRemoteRepoProvider = Provider(
    (ref) => RoutineRemoteRepoImpl(ref.watch(routineRemoteDataSourceProvider)));

class RoutineRemoteRepoImpl implements IRoutineRepository {
  final RoutineRemoteDataSource _routineRemoteDataSource;

  RoutineRemoteRepoImpl(this._routineRemoteDataSource);
  @override
  Future<Either<Failure, List<RoutineEntity>>> getAllRoutine() {
    return _routineRemoteDataSource.getAllRoutine();
  }
}

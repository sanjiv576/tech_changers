import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/data_sources/routine_remote_data_source.dart';
import '../../data/repository/routine_remote_repo_impl.dart';
import '../entity/routine_entity.dart';

final routineRepositoryProvider = Provider<IRoutineRepository>((ref) {
  return RoutineRemoteRepoImpl(ref.watch(routineRemoteDataSourceProvider));
});

abstract class IRoutineRepository {
  Future<Either<Failure, List<RoutineEntity>>> getAllRoutine();
}

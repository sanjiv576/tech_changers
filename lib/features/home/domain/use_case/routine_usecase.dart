import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/routine_entity.dart';
import '../repository/routine_repository.dart';

final routineUseCaseProvider = Provider<RoutineUseCase>(
    (ref) => RoutineUseCase(ref.watch(routineRepositoryProvider)));

class RoutineUseCase {
  final IRoutineRepository _routineRepository;
  RoutineUseCase(this._routineRepository);

  Future<Either<Failure, List<RoutineEntity>>> getAllRoutine() {
    return _routineRepository.getAllRoutine();
  }
}

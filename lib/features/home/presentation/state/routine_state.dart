
import '../../domain/entity/routine_entity.dart';

class RoutineState {
  final bool isLoading;
  final List<RoutineEntity> routine;
  final String? error;

  RoutineState({
    required this.isLoading,
    required this.routine,
    this.error,
  });

  factory RoutineState.initial() {
    return RoutineState(
      isLoading: false,
      routine: [],
    );
  }

  RoutineState copyWith({
    bool? isLoading,
    List<RoutineEntity>? routine,
    String? error,
  }) {
    return RoutineState(
      isLoading: isLoading ?? this.isLoading,
      routine: routine ?? this.routine,
      error: error ?? this.error,
    );
  }
}

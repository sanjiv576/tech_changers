import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_case/routine_usecase.dart';
import '../state/routine_state.dart';

final routineViewModelProvider =
    StateNotifierProvider<RoutineViewModel, RoutineState>(
  (ref) => RoutineViewModel(ref.read(routineUseCaseProvider)),
);

class RoutineViewModel extends StateNotifier<RoutineState> {
  final RoutineUseCase _routineUseCase;

  RoutineViewModel(this._routineUseCase) : super(RoutineState.initial()) {
    getAllRoutine();
  }

  Future<void> getAllRoutine() async {
    state = state.copyWith(isLoading: true);
    var data = await _routineUseCase.getAllRoutine();
    data.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
    }, (routineList) {
      state =
          state.copyWith(isLoading: false, routine: routineList, error: null);
    });
  }
}

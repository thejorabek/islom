import 'package:bloc/bloc.dart';
import 'package:islom/bloc/counter_bloc/counter_state.dart';
import 'package:islom/utils/colors/colors.dart';
import 'counter_event.dart';

class CountdownBloc extends Bloc<CountdownEvent, CountdownState> {
  CountdownBloc() : super(CountdownState.initial()) {
    on<DecrementCountdown>((event, emit) {
      if (state.remaining > 0) {
        emit(state.copyWith(
          remaining: state.remaining - 1,
          currentColor: CustomColors.tile,
        ));
      }
    });

    on<ResetCountdown>((event, emit) {
      emit(state.copyWith(
        remaining: 30,
        currentColor: CustomColors.tile,
      ));
    });
  }
}

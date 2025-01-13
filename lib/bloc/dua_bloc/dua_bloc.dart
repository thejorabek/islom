import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islom/bloc/dua_bloc/dua_event.dart';
import 'package:islom/bloc/dua_bloc/dua_state.dart';

class DuaBloc extends Bloc<DuaEvent, DuaState> {
  DuaBloc() : super(DuaInitial()) {
    on<SelectDuaEvent>((event, emit) {
      emit(DuaSelected(
        dua: event.dua,
        translation: event.translation,
        index: event.index,
      ));
    });
  }
}
abstract class DuaState {}

class DuaInitial extends DuaState {}

class DuaSelected extends DuaState {
  final String dua;
  final String translation;
  final int index;

  DuaSelected({
    required this.dua,
    required this.translation,
    required this.index,
  });
}
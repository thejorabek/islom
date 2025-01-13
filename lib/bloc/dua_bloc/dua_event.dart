abstract class DuaEvent {}

class SelectDuaEvent extends DuaEvent {
  final String dua;
  final String translation;
  final int index;

  SelectDuaEvent({
    required this.dua,
    required this.translation,
    required this.index,
  });
}

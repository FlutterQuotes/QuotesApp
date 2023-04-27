part of 'settings_bloc.dart';


class SettingsState extends Equatable {
  final bool darkMode;
  final String authorName;

  const SettingsState({
    required this.darkMode,
    required this.authorName,
  });

  @override
  List<Object?> get props => [darkMode, authorName];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial() : super(darkMode: false, authorName: "Max");
}

class SettingsChanged extends SettingsState {
  const SettingsChanged({required super.darkMode, required super.authorName});
}

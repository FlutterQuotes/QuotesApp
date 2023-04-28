part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final ThemeMode theme;
  final String authorName;

  const SettingsState({
    required this.theme,
    required this.authorName,
  });

  @override
  List<Object?> get props => [theme, authorName];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial() : super(theme: ThemeMode.light, authorName: "Max");
}

class SettingsChanged extends SettingsState {
  const SettingsChanged({required super.theme, required super.authorName});
}

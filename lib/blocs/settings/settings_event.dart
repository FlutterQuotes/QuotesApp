part of 'settings_bloc.dart';

class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DarkModeToggled extends SettingsEvent {
  final ThemeMode mode;

  DarkModeToggled({
    required this.mode,
  });

  @override
  List<Object?> get props => [mode];
}

class AuthorNameChanged extends SettingsEvent {
  final String authorName;

  AuthorNameChanged({
    required this.authorName,
  });

  @override
  List<Object?> get props => [authorName];
}

class ColorChanged extends SettingsEvent{
  final Map<String, dynamic> colors;

  ColorChanged({
    required this.colors,
  });

  @override
  List<Object?> get props => [colors];
}
part of 'settings_bloc.dart';


class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DarkModeToggled extends SettingsEvent {}

class AuthorNameChanged extends SettingsEvent {
  final String authorName;

  AuthorNameChanged({
    required this.authorName,
  });

  @override
  List<Object?> get props => [authorName];
}
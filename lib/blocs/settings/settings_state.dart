part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final ThemeMode theme;
  final String authorName;
  final Map<String, dynamic> colors;

  const SettingsState({
    required this.theme,
    required this.authorName,
    required this.colors,
  });

  @override
  List<Object?> get props => [theme, authorName, colors];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial() : super(
      theme: ThemeMode.light,
      authorName: "Max",
      colors: const {
        'primaryColor' : Colors.teal,
      },
  );
}

class SettingsChanged extends SettingsState {
  const SettingsChanged({required super.theme, required super.authorName, required super.colors});
}

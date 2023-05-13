import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsInitial()) {
    on<DarkModeToggled>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('mode', EnumToString.convertToString(event.mode));

      emit(SettingsChanged(
        theme: event.mode,
        authorName: state.authorName,
        colors: state.colors,
      ));
    });

    on<AuthorNameChanged>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('name', event.authorName);

      emit(SettingsChanged(
        theme: state.theme,
        authorName: event.authorName,
        colors: state.colors,
      ));
    });

    on<ColorChanged>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setInt('primaryColor', event.colors['primaryColor'].value);

      emit(SettingsChanged(
        colors: {...event.colors},
        theme: state.theme,
        authorName: state.authorName,
      ));
    });

    _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    add(DarkModeToggled(
        mode: EnumToString.fromString(
                ThemeMode.values, prefs.getString('mode') ?? 'light') ?? ThemeMode.light
    ));

    add(ColorChanged(colors: {
      ...state.colors,
      'primaryColor': Color(prefs.getInt('primaryColor') ?? Colors.teal.value),
    }));

    add(AuthorNameChanged(authorName: prefs.getString('name') ?? 'User'));
  }
}

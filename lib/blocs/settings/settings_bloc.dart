import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsInitial()) {

    on<DarkModeToggled>((event, emit) => emit(SettingsChanged(
        theme: state.theme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
        authorName: state.authorName)));

    on<AuthorNameChanged>((event, emit) => emit(SettingsChanged(
        theme: state.theme,
        authorName: event.authorName)));
  }
}
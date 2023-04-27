import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsInitial()) {
    on<DarkModeToggled>((event, emit) => emit(SettingsChanged(darkMode: !state.darkMode, authorName: state.authorName)));
    on<AuthorNameChanged>((event, emit) => emit(SettingsChanged(darkMode: state.darkMode, authorName: event.authorName)));
  }
}
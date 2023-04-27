import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/settings/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);

    return TextFormField(
        onChanged: (String value) => settingsBloc.add(AuthorNameChanged(authorName: value)),
        initialValue: settingsBloc.state.authorName,
    );
  }
}
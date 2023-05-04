import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../blocs/settings/settings_bloc.dart';

const List<Widget> modes = <Widget>[
  Text('Light'),
  Text('Dark'),
  Text('Auto'),
];

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<bool> _selectedMode = <bool>[true, false, false];

  Color pickerColor = Colors.teal;
  Color currentColor = Colors.teal;


  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void setSelectedMode(int index) {
    setState(() {
      for (int i = 0; i < _selectedMode.length; i++) {
        _selectedMode[i] = i == index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              child: TextFormField(
                onChanged: (String value) =>
                    settingsBloc.add(AuthorNameChanged(authorName: value)),
                initialValue: settingsBloc.state.authorName,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.people),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(16)),
            Row(
              children: [
                const Text('Mode'),
                const Spacer(),
                ToggleButtons(
                  isSelected: _selectedMode,
                  constraints: const BoxConstraints(
                    minHeight: 40,
                    minWidth: 50,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  onPressed: (int index) {
                    setSelectedMode(index);
                    switch (index) {
                      case 0:
                        settingsBloc
                            .add(DarkModeToggled(mode: ThemeMode.light));
                        break;
                      case 1:
                        settingsBloc
                            .add(DarkModeToggled(mode: ThemeMode.dark));
                        break;
                      case 2:
                        settingsBloc
                            .add(DarkModeToggled(mode: ThemeMode.system));
                        break;
                    }
                  },
                  children: modes,
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(16)),
            OutlinedButton(
                onPressed: () => _dialogBuilder(context),
                child: const Text('Change color'))
          ],
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Pick a color!'),
              content: SingleChildScrollView(
                child: MaterialPicker(
                  pickerColor: pickerColor,
                  onColorChanged: (Color color) {
                    changeColor(color);
                    settingsBloc.add(ColorChanged(colors: {
                      ...settingsBloc.state.colors,
                      'primaryColor': color,
                    }));
                  },
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Finish'),
                  onPressed: () {
                    setState(() => currentColor = pickerColor);
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        });
  }
}

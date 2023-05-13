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
  final TextEditingController _controller = TextEditingController();

  final List<bool> _selectedMode = <bool>[true, false, false];

  Color pickerColor = Colors.teal;

  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              child: _userNameInputBuilder(context),
            ),
            const Padding(padding: EdgeInsets.all(16)),
            _themeModeToggleBuilder(context),
            const Padding(padding: EdgeInsets.all(16)),
            OutlinedButton(
                onPressed: () => _dialogBuilder(context),
                child: const Text('Change color'),
            )],
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    changeColor(settingsBloc.state.colors['primaryColor']);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Pick a color!'),
              content: SingleChildScrollView(
                child: BlockPicker(
                  pickerColor: pickerColor,
                  onColorChanged: (Color color) {
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
                    //setState(() => currentColor = pickerColor);
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        });
  }

  BlocListener<SettingsBloc, SettingsState> _userNameInputBuilder(
      BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);

    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (_controller.text != state.authorName) {
          _controller.text = state.authorName;
          _controller.selection =
              TextSelection.collapsed(offset: state.authorName.length);
        }
      },
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Username',
          prefixIcon: Icon(Icons.people),
        ),
        controller: _controller,
        onChanged: (text) => {
          settingsBloc.add(AuthorNameChanged(authorName: text))
        },
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }

  BlocListener<SettingsBloc, SettingsState> _themeModeToggleBuilder(
      BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);

    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        switch (state.theme) {
          case ThemeMode.system:
            setSelectedMode(2);
            break;
          case ThemeMode.light:
            setSelectedMode(0);
            break;
          case ThemeMode.dark:
            setSelectedMode(1);
            break;
        }
      },
      child: Row(
        children: [
          Text('Mode',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          const Spacer(),
          ToggleButtons(
            isSelected: _selectedMode,
            constraints: const BoxConstraints(
              minHeight: 40,
              minWidth: 50,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            onPressed: (int index) {
              ThemeMode mode = ThemeMode.light;
              switch (index) {
                case 0:
                  mode = ThemeMode.light;
                  break;
                case 1:
                  mode = ThemeMode.dark;
                  break;
                case 2:
                  mode = ThemeMode.system;
                  break;
              }
              settingsBloc.add(DarkModeToggled(mode: mode));
            },
            children: modes,
          ),
        ],
      ),
    );
  }
}

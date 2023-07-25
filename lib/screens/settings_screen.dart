import 'package:flutter/material.dart';
import 'package:meals/models/settings.dart';
import '../components/drawer.dart';

class SettingsScreen extends StatefulWidget {
  final Function(Settings) onSettingsChanged;
  Settings settings;
  SettingsScreen(
      {super.key, required this.onSettingsChanged, required this.settings});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Settings settings;

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  Widget _createSwitch(
    String title,
    String subTitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile.adaptive(
      value: value,
      onChanged: (value) {
        onChanged(value);
        widget.onSettingsChanged(settings);
      },
      title: Text(title),
      subtitle: Text(subTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Configurações",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black,
                  ),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _createSwitch("Sem Glutén", "Só exibe refeições sem glutén",
                    settings.isGlutenFree, (value) {
                  setState(() {
                    settings.isGlutenFree = value;
                  });
                }),
                _createSwitch("Sem Lactose", "Só exibe refeições sem Lactose",
                    settings.isLactoseFree, (value) {
                  setState(() {
                    settings.isLactoseFree = value;
                  });
                }),
                _createSwitch(
                    "Vegana", "Só exibe refeições Vegana", settings.isVegan,
                    (value) {
                  setState(() {
                    settings.isVegan = value;
                  });
                }),
                _createSwitch("Vegetariana", "Só exibe refeições Vegetariana",
                    settings.isVegetarian, (value) {
                  setState(() {
                    settings.isVegetarian = value;
                  });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

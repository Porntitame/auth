import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool ssid_1 = false;
  bool ssid_2 = false;
  bool ssid_3 = false;
  bool ssid_4 = false;

  @override
  initState() {
    ssid_1 = widget.currentFilters['ssid_1'];
    ssid_2 = widget.currentFilters['ssid_2'];
    ssid_3 = widget.currentFilters['ssid_3'];
    ssid_4 = widget.currentFilters['ssid_4'];
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'ssid_1': ssid_1,
                'ssid_2': ssid_2,
                'ssid_3': ssid_3,
                'ssid_4': ssid_4,
              };
              widget.saveFilters(selectedFilters);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              _buildSwitchListTile(
                'Gluten-free',
                'Only include gluten-free meals.',
                ssid_1,
                (newValue) {
                  setState(
                    () {
                      ssid_1 = newValue;
                    },
                  );
                },
              ),
              _buildSwitchListTile(
                'Lactose-free',
                'Only include lactose-free meals.',
                ssid_2,
                (newValue) {
                  setState(
                    () {
                      ssid_2 = newValue;
                    },
                  );
                },
              ),
              _buildSwitchListTile(
                'Vegetarian',
                'Only include vegetarian meals.',
                ssid_3,
                (newValue) {
                  setState(
                    () {
                      ssid_3 = newValue;
                    },
                  );
                },
              ),
              _buildSwitchListTile(
                'Vegan',
                'Only include vegan meals.',
                ssid_4,
                (newValue) {
                  setState(
                    () {
                      ssid_4 = newValue;
                    },
                  );
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}

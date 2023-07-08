import 'package:flutter/material.dart';

import './Utilities/constants.dart';

class ColorsListPage extends StatelessWidget {
  ColorsListPage(
      {super.key, required this.color, required this.title, this.onPush});
  final MaterialColor color;
  final String title;
  final ValueChanged<int>? onPush;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
          ),
          backgroundColor: Constants.lightThemePrimaryColor,
        ),
        body: Container(
          color: Colors.white,
         // child: _buildList(),
        ));
  }

  final List<int> materialIndices = [
    900,
    800,
    700,
    600,
    500,
    400,
    300,
    200,
    100,
    50
  ];

  Widget _buildList() {
    return ListView.builder(
        itemCount: materialIndices.length,
        itemBuilder: (BuildContext content, int index) {
          int materialIndex = materialIndices[index];
          return Container(
            color: color[materialIndex],
            child: ListTile(
              title: Text('$materialIndex',
                  style: const TextStyle(fontSize: 24.0)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => onPush?.call(materialIndex),
            ),
          );
        });
  }
}

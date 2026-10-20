import 'package:exercici_2/src/providers/menu_provider.dart';
import 'package:exercici_2/src/utils/icona_string_util.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Components")),
      body: _llista(),
    );
  }

  Widget _llista() {
    return FutureBuilder<List<dynamic>>(
      future: menuProvider.carregarDades(),
      initialData: const [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _llistaElements(context, snapshot.data ?? []),
        );
      },
    );
  }
}

List<Widget> _llistaElements(BuildContext context, List<dynamic> data) {
  final List<Widget> elements = [];
  for (var element in data){
    final widgetTemp = ListTile(
      title: Text(element['texte']),
      leading: getIcon(element['icona']),
      trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.blue),
      onTap: () {
        Navigator.pushNamed(context, element['ruta']);
      },
    );
    elements..add(widgetTemp)..add(const Divider());
  }
  return elements;
}
import 'dart:async';
import 'package:flutter/material.dart';

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({super.key});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  final List<int> _llistaNombres = [];
  int _darrerItem = 0;
  bool _estaCarregant = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _carregaNou();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _carregaNou() {
    for (int i = 0; i < 5; i++) {
      _llistaNombres.add(_darrerItem);
      _darrerItem++;
    }
    setState(() {});
  }

  Future<Timer> fetchData() async {
    _estaCarregant = true;
    setState(() {});
    const duration = Duration(seconds: 2);
    return Timer(duration, peticioHTTP);
  }

  void peticioHTTP() {
    _estaCarregant = false;
    _carregaNou();
    _scrollController.animateTo(
      _scrollController.position.pixels + 100,
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> obtenirPagina() async {
    const duration = Duration(seconds: 2);
    Timer(duration, () {
      _llistaNombres.clear();
      _darrerItem++;
      _carregaNou();
    });
    return Future.delayed(duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Llistes y Scroll')),
      body: Stack(
        children: [
          _crearLlista(),
          _crearLoading(),
        ],
      ),
    );
  }

  Widget _crearLlista() {
    return RefreshIndicator(
      onRefresh: obtenirPagina,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _llistaNombres.length,
        itemBuilder: (context, index) {
          final imatge = _llistaNombres[index];
          return FadeInImage(
            placeholder: const AssetImage('assets/jar-loading.gif'),
            image: NetworkImage('https://picsum.photos/id/$imatge/500/400'),
            height: 250,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  Widget _crearLoading() {
    if (_estaCarregant) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
            ],
          ),
          const SizedBox(height: 15.0)
        ],
      );
    } else {
      return Container();
    }
  }
}
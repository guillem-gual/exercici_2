import 'package:flutter/material.dart';

class AvatarScreen extends StatelessWidget {
  const AvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pàgina Avatar'),
        actions: [
          Container(
            padding: const EdgeInsets.all(5.0),
            child: const CircleAvatar(
              backgroundImage: NetworkImage('https://static.wikia.nocookie.net/minion/images/c/ca/Bob-from-the-minions-movie.jpg/revision/latest/scale-to-width-down/600?cb=20160316002021&path-prefix=es'),
              radius: 25.0,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: const CircleAvatar(
              backgroundColor: Colors.brown,
              child: Text('JC'),
            ),
          )
        ],
      ),
      body: const Center(
        child: FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage('https://static.wikia.nocookie.net/minion/images/c/ca/Bob-from-the-minions-movie.jpg/revision/latest/scale-to-width-down/600?cb=20160316002021&path-prefix=es'),
          fadeInDuration: Duration(milliseconds: 100),
        ),
      ),
    );
  }
}
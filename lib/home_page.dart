import 'package:appfirebase/jogo_page.dart';
import 'package:appfirebase/services/firestore_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: StreamBuilder(
          stream: FirestoreService().listar().snapshots(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return CircularProgressIndicator();
            }
            final dados = snap.data!.docs;
            return ListView.builder(
                itemCount: dados.length,
                itemBuilder: (context, indice) {
                  return ListTile(
                    title: Text(dados[indice]['nome']),
                    subtitle: Text(dados[indice]['console']),
                    trailing: ElevatedButton(
                        onPressed: () {
                          //FirestoreService().excluir(dados[indice]['id'] );
                          print('${dados[indice].id}');
                        },
                        child: Icon(Icons.clear)),
                  );
                });
          },
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => JogoPage()));
          },
          child: Text('+')),
    );
  }
}

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
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      IconButton(
                        onPressed: () {
                          String idCorrente = dados[indice].id;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => JogoPage(id: idCorrente)));
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text('Excluir item'),
                                    content: Text(
                                        'Tem certeza que deseja excluir o item ${dados[indice]['nome']}?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          FirestoreService()
                                              .excluir(dados[indice].id)
                                              .then((_) =>
                                                  {Navigator.pop(context)});
                                        },
                                        child: Text('Simk'),
                                      )
                                    ],
                                  );
                                });
                          },
                          icon: Icon(Icons.clear)),
                    ]),
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

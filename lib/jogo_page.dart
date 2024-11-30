import 'package:appfirebase/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'services/firestore_service.dart';

class JogoPage extends StatelessWidget {
  JogoPage({super.key});

  TextEditingController _txtNome = TextEditingController();
  TextEditingController _txtConsole = TextEditingController();
  TextEditingController _txtAno = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('jogo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _txtNome,
              decoration: InputDecoration(
                labelText: 'Nome do jogo:',
              ),
            ),
            TextFormField(
              controller: _txtConsole,
              decoration: InputDecoration(
                labelText: 'Console:',
              ),
            ),
            TextFormField(
              controller: _txtAno,
              decoration: InputDecoration(
                labelText: 'Ano lançamento:',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                DocumentReference resposta = await FirestoreService().gravar(
                    _txtNome.text, _txtConsole.text, int.parse(_txtAno.text));

                if (resposta != null) {
                  SnackBar snackBar = SnackBar(
                    content: Text('Salvo'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => HomePage()));
                }
              },
              child: Text('Salvar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => HomePage()));
              },
              child: Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:appfirebase/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'services/firestore_service.dart';

class JogoPage extends StatefulWidget {
  String? id;
  JogoPage({this.id, super.key});

  @override
  State<JogoPage> createState() => _JogoPageState();
}

class _JogoPageState extends State<JogoPage> {
  TextEditingController _txtNome = TextEditingController();

  TextEditingController _txtConsole = TextEditingController();

  TextEditingController _txtAno = TextEditingController();

  FirestoreService servico = FirestoreService();

  @override
  void initState() {
    if (widget.id != null) {
      //carregar os dados a partir do id

      servico.buscarPorID(widget.id!)!.then((dados) {
        _txtNome.text = dados['nome'];
        _txtConsole.text = dados['console'];
        _txtAno.text = dados['ano_lancamento'].toString();
      });

      // dados.get().then((dados) {

      // });
    }

    super.initState();
  }

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
                DocumentReference resposta = await servico.gravar(
                    _txtNome.text,
                    _txtConsole.text,
                    int.parse(_txtAno.text),
                    widget.id.toString());

                if (resposta != null) {
                  SnackBar snackBar = SnackBar(
                    content: Text('Salvo'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  resposta.get().then((dados) {
                    widget.id = dados.id;
                  });
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

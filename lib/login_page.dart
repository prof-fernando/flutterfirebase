import 'dart:io';

import 'package:appfirebase/nova_conta_page.dart';
import 'package:appfirebase/services/usuario_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController _txtEmail =
      new TextEditingController(text: 'professor@iffar.edu.br');
  TextEditingController _txtSenha = new TextEditingController(text: '12345');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: _txtEmail,
            decoration: InputDecoration(
              labelText: 'Email:',
            ),
          ),
          TextFormField(
            controller: _txtSenha,
            decoration: InputDecoration(
              labelText: 'Senha:',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              UsuarioService service = UsuarioService();
              String resposta =
                  await service.login(_txtEmail.text, _txtSenha.text);
              if (resposta != "") {
                SnackBar snackBar = SnackBar(
                  content: Text(resposta),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {}
            },
            child: Text('Login'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => NovaContaPage()));
            },
            child: Text('Criar nova Conta'),
          ),
        ],
      ),
    );
  }
}

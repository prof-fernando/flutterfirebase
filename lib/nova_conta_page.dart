import 'package:appfirebase/services/usuario_service.dart';
import 'package:flutter/material.dart';

class NovaContaPage extends StatelessWidget {
  NovaContaPage({super.key});

  TextEditingController _txtNome = new TextEditingController();
  TextEditingController _txtEmail = new TextEditingController();
  TextEditingController _txtSenha = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: _txtNome,
            decoration: InputDecoration(
              labelText: 'Nome:',
            ),
          ),
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
            onPressed: () {
              UsuarioService service = UsuarioService();
              service.criarNovaConta(
                  _txtNome.text, _txtEmail.text, _txtSenha.text);
            },
            child: Text('Cadastrar'),
          ),
        ],
      ),
    );
  }
}

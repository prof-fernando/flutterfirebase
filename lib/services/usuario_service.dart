import 'package:firebase_auth/firebase_auth.dart';

class UsuarioService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  criarNovaConta(String nome, String email, String senha) async {
    UserCredential c = await _auth.createUserWithEmailAndPassword(
        email: email, password: senha);
    c.user!.updateDisplayName(nome);
  }
}

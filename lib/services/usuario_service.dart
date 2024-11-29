import 'package:firebase_auth/firebase_auth.dart';

class UsuarioService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  criarNovaConta(String nome, String email, String senha) async {
    UserCredential c = await _auth.createUserWithEmailAndPassword(
        email: email, password: senha);
    c.user!.updateDisplayName(nome);
  }

  Future<String> login(String email, String senha) async {
    try {
      UserCredential user =
          await _auth.signInWithEmailAndPassword(email: email, password: senha);
      return "";
    } catch (erro) {
      return "Usuário/senha inválidos ";
    }
  }
}

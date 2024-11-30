import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  Future<DocumentReference> gravar(String nome, String console, int ano) {
    return _firestore
        .collection('jogos')
        .add({'nome': nome, 'console': console, 'ano_lancamento': ano});
  }

  CollectionReference listar() {
    return _firestore.collection('jogos');
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  Future<DocumentReference> gravar(String nome, String console, int ano,
      [String id = '']) {
    return _firestore
        .collection('jogos')
        .add({'nome': nome, 'console': console, 'ano_lancamento': ano});
  }

  CollectionReference listar() {
    return _firestore.collection('jogos');
  }

  excluir(String id) {
    final documentRef = _firestore.collection('jogos').doc(id);
    documentRef.delete();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  gravar(String nome, String console, int ano, String id) {
    if (id != 'null') {
      // update
      final documentRef = _firestore.collection('jogos').doc(id);
      documentRef
          .update({'nome': nome, 'console': console, 'ano_lancamento': ano});
      return documentRef;
    } else {
      return _firestore
          .collection('jogos')
          .add({'nome': nome, 'console': console, 'ano_lancamento': ano});
    }
  }

  CollectionReference listar() {
    return _firestore.collection('jogos');
  }

  Future<void> excluir(String id) {
    final documentRef = _firestore.collection('jogos').doc(id);
    return documentRef.delete();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>>? buscarPorID(String id) {
    return _firestore.collection('jogos').doc(id).get();
  }
}

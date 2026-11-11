import 'package:cloud_firestore/cloud_firestore.dart';

final _destinos = FirebaseFirestore.instance.collection('destinos');

// READ: consultar um destino pelo ID do documento.
Future<Map<String, dynamic>> buscarDestino(String id) async {
  final documento = await _destinos.doc(id).get();
  return documento.data() ?? {};
}

// READ: listar todos os destinos.
Future<List<Map<String, dynamic>>> listarDestinos() async {
  final consulta = await _destinos.get();

  return consulta.docs.map((documento) {
    return <String, dynamic>{
      'id': documento.id,
      ...documento.data(),
    };
  }).toList();
}

// CREATE: cadastrar um destino com ID gerado pelo Firestore.
Future<void> cadastrarDestino(Map<String, dynamic> dados) async {
  await _destinos.add(dados);
}

// UPDATE: alterar os campos de um destino existente.
Future<void> alterarDestino(String id, Map<String, dynamic> dados) async {
  await _destinos.doc(id).update(dados);
}

// DELETE: excluir um destino pelo ID.
Future<void> excluirDestino(String id) async {
  await _destinos.doc(id).delete();
}

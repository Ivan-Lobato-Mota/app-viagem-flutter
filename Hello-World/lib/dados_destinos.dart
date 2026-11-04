import 'package:cloud_firestore/cloud_firestore.dart';

final _destinos = FirebaseFirestore.instance.collection('destinos');

Future<Map<String, dynamic>> buscarDestino(String id) async {

  final documento = await _destinos.doc(id).get();

  if (documento.exists) {
    return documento.data()!;
  }

  return {};
}

Future<List<Map<String, dynamic>>> listarDestinos() async {
  final consulta = await _destinos.get();

  return consulta.docs.map((documento) {
    return {
      'id': documento.id,
      ...documento.data(),
    };
  }).toList();
}

Future<void> cadastrarDestino(Map<String, dynamic> destino) async {

  await _destinos.add(dados);
}
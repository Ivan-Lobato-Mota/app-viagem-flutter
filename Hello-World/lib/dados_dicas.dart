import 'package:cloud_firestore/cloud_firestore.dart';

final _dicas = FirebaseFirestore.instance.collection('dicas');

// READ: listar todas as dicas.
Future<List<Map<String, dynamic>>> listarDicas() async {
  final consulta = await _dicas.get();

  return consulta.docs.map((documento) {
    return <String, dynamic>{
      'id': documento.id,
      ...documento.data(),
    };
  }).toList();
}

// Lê um campo da dica como texto, devolvendo '' quando não existir.
String textoDica(Map<String, dynamic> dica, String campo) {
  return dica[campo]?.toString().trim() ?? '';
}

// Deixa o texto minúsculo e sem acentos, para comparar
// "Média" com "media" ou "Segurança" com "seguranca".
String normalizar(String texto) {
  const comAcento = 'áàâãäéèêëíìîïóòôõöúùûüç';
  const semAcento = 'aaaaaeeeeiiiiooooouuuuc';

  var resultado = texto.trim().toLowerCase();
  for (var i = 0; i < comAcento.length; i++) {
    resultado = resultado.replaceAll(comAcento[i], semAcento[i]);
  }
  return resultado;
}

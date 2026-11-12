import 'package:flutter/material.dart';
import 'dados_dicas.dart';

// Ícone e cor usados para representar uma categoria de dica.
class EstiloCategoria {
  final IconData icone;
  final MaterialColor cor;

  const EstiloCategoria(this.icone, this.cor);
}

// Texto, cor e ordem de exibição de uma prioridade.
class EstiloPrioridade {
  final String rotulo;
  final MaterialColor cor;
  final int ordem;

  const EstiloPrioridade(this.rotulo, this.cor, this.ordem);
}

// Chaves sem acento e em minúsculo (ver normalizar()).
const _categorias = {
  'documentos': EstiloCategoria(Icons.badge, Colors.red),
  'documentacao': EstiloCategoria(Icons.badge, Colors.red),
  'planejamento': EstiloCategoria(Icons.luggage, Colors.green),
  'transporte': EstiloCategoria(Icons.flight, Colors.blue),
  'hospedagem': EstiloCategoria(Icons.hotel, Colors.deepPurple),
  'seguranca': EstiloCategoria(Icons.shield, Colors.orange),
  'financas': EstiloCategoria(Icons.savings, Colors.pink),
};

const _categoriaPadrao = EstiloCategoria(Icons.lightbulb, Colors.blueGrey);

const _prioridades = {
  'importante': EstiloPrioridade('Importante', Colors.red, 0),
  'media': EstiloPrioridade('Média', Colors.amber, 1),
  'dica': EstiloPrioridade('Dica', Colors.green, 2),
};

EstiloCategoria estiloCategoria(String categoria) {
  return _categorias[normalizar(categoria)] ?? _categoriaPadrao;
}

// Prioridades desconhecidas aparecem com o texto original, em cinza e no fim da lista.
EstiloPrioridade estiloPrioridade(String prioridade) {
  return _prioridades[normalizar(prioridade)] ??
      EstiloPrioridade(prioridade, Colors.grey, _prioridades.length);
}

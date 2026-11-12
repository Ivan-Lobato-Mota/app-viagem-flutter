import 'package:flutter/material.dart';
import 'dados_dicas.dart';
import 'estilo_dicas.dart';

class DetalhesDicaPage extends StatelessWidget {
  // A dica já vem carregada da listagem, sem nova consulta ao Firebase.
  final Map<String, dynamic> dica;

  const DetalhesDicaPage({
    super.key,
    required this.dica,
  });

  // 'imagem' pode ser uma URL (http/https) ou um caminho de asset.
  Widget _imagem(String caminho) {
    if (caminho.startsWith('http')) {
      return Image.network(
        caminho,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progresso) => progresso == null
            ? child
            : const Center(child: CircularProgressIndicator()),
        errorBuilder: _imagemIndisponivel,
      );
    }

    return Image.asset(
      caminho,
      fit: BoxFit.cover,
      errorBuilder: _imagemIndisponivel,
    );
  }

  Widget _imagemIndisponivel(
    BuildContext context,
    Object erro,
    StackTrace? stackTrace,
  ) {
    return Container(
      color: Colors.grey.shade200,
      child: Icon(Icons.broken_image, size: 48, color: Colors.grey.shade500),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titulo = textoDica(dica, 'titulo');
    final categoria = textoDica(dica, 'categoria');
    final desc = textoDica(dica, 'desc');
    final imagem = textoDica(dica, 'imagem');
    final estilo = estiloCategoria(categoria);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Dica'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          if (imagem.isNotEmpty)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: _imagem(imagem),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                if (categoria.isNotEmpty)
                  Chip(
                    avatar: Icon(
                      estilo.icone,
                      size: 18,
                      color: estilo.cor.shade700,
                    ),
                    label: Text(categoria),
                    backgroundColor: estilo.cor.shade50,
                    side: BorderSide.none,
                  ),
                const SizedBox(height: 16),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'dados_destinos.dart';

class DetalhesPage extends StatelessWidget {
  final String cidade;

  const DetalhesPage({
    super.key,
    required this.cidade,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: buscarDestino(cidade),
      builder: (context, snapshot) {

        // Aguardando a consulta
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Dados não encontrados
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text('Destino não encontrado'),
            ),
          );
        }

        // Dados recebidos do Firebase
        final dados = snapshot.data!;

        // Destinos cadastrados pelo formulário não possuem atrações.
        final atracoes = (dados['atracoes'] as List?) ?? [];
        final imagem = dados['imagem']?.toString() ?? '';

        return Scaffold(
          appBar: AppBar(
            title: Text(dados['nome'] ?? ''),
            centerTitle: true,
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),

          body: SingleChildScrollView(
            child: Column(
              children: [

                if (imagem.isNotEmpty)
                  Image.asset(
                    imagem,
                    errorBuilder: (context, erro, stackTrace) =>
                        const SizedBox.shrink(),
                  ),

                Text(dados['estado']?.toString() ?? ''),

                const Text(
                  'Sobre o destino',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(dados['desc'] ?? ''),

                const Text(
                  'Informações rápidas',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Icon(
                  Icons.sunny_snowing,
                  size: 60,
                ),

                Text(dados['clima'] ?? ''),

                const Icon(
                  Icons.calendar_month,
                  size: 60,
                ),

                Text(dados['epoca'] ?? ''),

                const Icon(
                  Icons.access_time,
                  size: 60,
                ),

                Text(dados['permanencia'] ?? ''),

                const Text(
                  'Principais atrações',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                for (var atracao in atracoes)
                  ExpansionTile(
                    title: Text(atracao['nome'] ?? ''),
                    children: [
                      Text(atracao['desc'] ?? ''),
                      const SizedBox(height: 15),
                      Text(atracao['horario'] ?? ''),
                      const SizedBox(height: 15),
                      Text(atracao['entrada'] ?? ''),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
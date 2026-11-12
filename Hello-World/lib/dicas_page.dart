import 'package:flutter/material.dart';
import 'dados_dicas.dart';
import 'detalhes_dica_page.dart';
import 'estilo_dicas.dart';

class DicasPage extends StatefulWidget {
  const DicasPage({super.key});

  @override
  State<DicasPage> createState() => _DicasPageState();
}

class _DicasPageState extends State<DicasPage> {
  late final Future<List<Map<String, dynamic>>> futureDicas = listarDicas();

  String filtro = '';

  // Categoria normalizada selecionada no filtro; null significa "Todas".
  String? categoriaSelecionada;

  Widget _chipCategoria(String rotulo, String? chave) {
    final selecionado = categoriaSelecionada == chave;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(rotulo),
        selected: selecionado,
        showCheckmark: false,
        selectedColor: Colors.blue,
        labelStyle: TextStyle(color: selecionado ? Colors.white : null),
        onSelected: (_) => setState(() => categoriaSelecionada = chave),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dicas de Viagem'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureDicas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao buscar dicas: ${snapshot.error}'),
            );
          }

          final dicas = snapshot.data ?? [];

          // Categorias existentes nas dicas: chave normalizada -> nome exibido.
          final categorias = <String, String>{};
          for (final dica in dicas) {
            final categoria = textoDica(dica, 'categoria');
            if (categoria.isNotEmpty) {
              categorias.putIfAbsent(normalizar(categoria), () => categoria);
            }
          }
          final chavesCategorias = categorias.keys.toList()..sort();

          final busca = normalizar(filtro);

          final filtradas = dicas.where((dica) {
            final categoriaOk = categoriaSelecionada == null ||
                normalizar(textoDica(dica, 'categoria')) ==
                    categoriaSelecionada;

            final buscaOk =
                normalizar(textoDica(dica, 'titulo')).contains(busca) ||
                    normalizar(textoDica(dica, 'desc')).contains(busca);

            return categoriaOk && buscaOk;
          }).toList();

          // Mais importantes primeiro; em seguida, ordem alfabética.
          filtradas.sort((a, b) {
            final porPrioridade = estiloPrioridade(textoDica(a, 'prioridade'))
                .ordem
                .compareTo(estiloPrioridade(textoDica(b, 'prioridade')).ordem);
            if (porPrioridade != 0) return porPrioridade;

            return normalizar(textoDica(a, 'titulo'))
                .compareTo(normalizar(textoDica(b, 'titulo')));
          });

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Pesquisar dica...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (valor) => setState(() => filtro = valor),
                ),
              ),
              SizedBox(
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _chipCategoria('Todas', null),
                    for (final chave in chavesCategorias)
                      _chipCategoria(categorias[chave]!, chave),
                  ],
                ),
              ),
              Expanded(
                child: filtradas.isEmpty
                    ? const Center(child: Text('Nenhuma dica encontrada'))
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        itemCount: filtradas.length,
                        itemBuilder: (context, index) =>
                            _CardDica(dica: filtradas[index]),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CardDica extends StatelessWidget {
  final Map<String, dynamic> dica;

  const _CardDica({required this.dica});

  @override
  Widget build(BuildContext context) {
    final titulo = textoDica(dica, 'titulo');
    final categoria = textoDica(dica, 'categoria');
    final desc = textoDica(dica, 'desc');
    final estilo = estiloCategoria(categoria);
    final prioridade = estiloPrioridade(textoDica(dica, 'prioridade'));

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetalhesDicaPage(dica: dica),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: estilo.cor.shade100,
                child: Icon(estilo.icone, color: estilo.cor.shade700, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            titulo,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (prioridade.rotulo.isNotEmpty)
                          _SeloPrioridade(prioridade: prioridade),
                      ],
                    ),
                    Text(
                      categoria,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SeloPrioridade extends StatelessWidget {
  final EstiloPrioridade prioridade;

  const _SeloPrioridade({required this.prioridade});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: prioridade.cor.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        prioridade.rotulo,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: prioridade.cor.shade800,
        ),
      ),
    );
  }
}

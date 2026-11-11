import 'package:flutter/material.dart';
import 'dados_destinos.dart';
import 'detalhes_page.dart';
import 'form_destino_page.dart';

class DestinosPage extends StatefulWidget {
  const DestinosPage({super.key});

  @override
  State<DestinosPage> createState() => _DestinosPageState();
}

class _DestinosPageState extends State<DestinosPage> {
  String filtro = '';
  late Future<List<Map<String, dynamic>>> futureDestinos;

  @override
  void initState() {
    super.initState();
    futureDestinos = listarDestinos();
  }

  void _recarregar() {
    setState(() {
      futureDestinos = listarDestinos();
    });
  }

  Future<void> _abrirFormulario({
    String? id,
    Map<String, dynamic>? destino,
  }) async {
    final salvou = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => FormDestinoPage(id: id, destino: destino),
      ),
    );

    if (!mounted) return;
    if (salvou == true) {
      _recarregar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Destino salvo com sucesso!')),
      );
    }
  }

  Future<void> _confirmarExclusao(String id, String nome) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir destino?'),
        content: Text('Deseja realmente excluir $nome?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (!mounted || confirmado != true) return;

    try {
      await excluirDestino(id);
      if (!mounted) return;
      _recarregar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Destino excluído com sucesso!')),
      );
    } catch (erro) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir: $erro')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Destinos'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirFormulario(),
        icon: const Icon(Icons.add),
        label: const Text('Novo destino'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureDestinos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao buscar destinos: ${snapshot.error}'));
          }

          final destinos = List<Map<String, dynamic>>.from(snapshot.data ?? []);
          destinos.sort((a, b) => (a['nome'] ?? '')
              .toString()
              .toLowerCase()
              .compareTo((b['nome'] ?? '').toString().toLowerCase()));

          final filtrados = destinos.where((destino) =>
              (destino['nome'] ?? '')
                  .toString()
                  .toLowerCase()
                  .contains(filtro.toLowerCase())).toList();

          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Pesquisar cidade...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (valor) => setState(() => filtro = valor),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: filtrados.isEmpty
                      ? const Center(child: Text('Nenhum destino encontrado'))
                      : ListView.builder(
                    itemCount: filtrados.length,
                    itemBuilder: (context, index) {
                      final destino = filtrados[index];
                      final id = destino['id'].toString();
                      final nome = destino['nome']?.toString() ?? '';
                      return Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.location_city,
                            color: Colors.blue,
                            size: 36,
                          ),
                          title: Text(nome),
                          subtitle: Text(destino['estado']?.toString() ?? ''),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetalhesPage(cidade: id),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                tooltip: 'Editar',
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _abrirFormulario(
                                  id: id,
                                  destino: destino,
                                ),
                              ),
                              IconButton(
                                tooltip: 'Excluir',
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _confirmarExclusao(id, nome),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

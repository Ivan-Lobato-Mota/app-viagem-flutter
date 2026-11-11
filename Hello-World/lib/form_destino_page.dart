import 'package:flutter/material.dart';
import 'dados_destinos.dart';

class FormDestinoPage extends StatefulWidget {
  // Quando id e destino são informados, o formulário edita um destino existente.
  final String? id;
  final Map<String, dynamic>? destino;

  const FormDestinoPage({super.key, this.id, this.destino});

  @override
  State<FormDestinoPage> createState() => _FormDestinoPageState();
}

class _FormDestinoPageState extends State<FormDestinoPage> {
  final _formKey = GlobalKey<FormState>();
  bool _salvando = false;

  bool get _editando => widget.id != null;

  // Um controller por campo do documento no Firebase,
  // já preenchido com os dados atuais quando estiver editando.
  late final Map<String, TextEditingController> _campos = {
    for (final campo in [
      'nome',
      'estado',
      'desc',
      'clima',
      'epoca',
      'permanencia',
      'imagem',
    ])
      campo: TextEditingController(
        text: widget.destino?[campo]?.toString() ?? '',
      ),
  };

  @override
  void dispose() {
    for (final controller in _campos.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _salvando = true);

    final dados = {
      for (final campo in _campos.entries) campo.key: campo.value.text.trim(),
    };

    try {
      if (_editando) {
        await alterarDestino(widget.id!, dados);
      } else {
        await cadastrarDestino(dados);
      }

      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      setState(() => _salvando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar: $e')),
      );
    }
  }

  Widget _campo(
    String rotulo,
    String campo, {
    bool obrigatorio = true,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: _campos[campo],
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: rotulo,
          border: const OutlineInputBorder(),
        ),
        validator: (valor) {
          if (obrigatorio && (valor == null || valor.trim().isEmpty)) {
            return 'Preencha este campo';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editando ? 'Editar destino' : 'Novo destino'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _campo('Nome da cidade', 'nome'),
            _campo('Estado e país', 'estado'),
            _campo('Descrição', 'desc', maxLines: 3),
            _campo('Clima', 'clima'),
            _campo('Melhor época', 'epoca'),
            _campo('Permanência', 'permanencia'),
            _campo(
              'Caminho da imagem (opcional)',
              'imagem',
              obrigatorio: false,
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _salvando ? null : _salvar,
              icon: const Icon(Icons.save),
              label: Text(_salvando ? 'Salvando...' : 'Salvar destino'),
            ),
          ],
        ),
      ),
    );
  }
}

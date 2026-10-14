import 'package:flutter/material.dart';

class Destino {
  final String nome;
  final IconData icone;
  final String regiao;
  final String imagem;
  final String sobre;
  final String clima;
  final String melhorEpoca;
  final String tempoMedio;
  final List<String> atracoes;

  const Destino({
    required this.nome,
    required this.icone,
    required this.regiao,
    required this.imagem,
    required this.sobre,
    required this.clima,
    required this.melhorEpoca,
    required this.tempoMedio,
    required this.atracoes,
  });
}

class DetalhesPage extends StatelessWidget {
  final Destino destino;

  const DetalhesPage({super.key, required this.destino});

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F7),
      appBar: AppBar(
        title: Text(destino.nome),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              destino.imagem,
              height: 230,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 12),
            _cartao(
              child: Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    size: 40,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          destino.nome,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          destino.regiao,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _cartao(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _titulo('Sobre o destino'),
                  SizedBox(height: 10),
                  Text(
                    destino.sobre,
                    style: TextStyle(fontSize: 15, height: 1.4),
                  ),
                ],
              ),
            ),
            _cartao(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _titulo('Informações rápidas'),
                  SizedBox(height: 12),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _informacao(
                            icone: Icons.wb_sunny,
                            titulo: 'Clima',
                            valor: destino.clima,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: _informacao(
                            icone: Icons.calendar_month,
                            titulo: 'Melhor época',
                            valor: destino.melhorEpoca,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: _informacao(
                            icone: Icons.access_alarm,
                            titulo: 'Tempo médio',
                            valor: destino.tempoMedio,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _cartao(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _titulo('Principais atrações'),
                  SizedBox(height: 10),
                  for (final atracao in destino.atracoes)
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFF7F7FA),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xFFE3E3E8)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              atracao,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 220,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                  label: Text('Voltar'),
                ),
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _cartao({required Widget child}) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: child,
      ),
    );
  }

  Widget _titulo(String texto) {
    return Text(
      texto,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _informacao({
    required IconData icone,
    required String titulo,
    required String valor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 6),
      decoration: BoxDecoration(
        color: Color(0xFFF7F7FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFE3E3E8)),
      ),
      child: Column(
        children: [
          Icon(icone, size: 32, color: Colors.blue),
          SizedBox(height: 10),
          Text(
            titulo,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
          SizedBox(height: 2),
          Text(
            valor,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

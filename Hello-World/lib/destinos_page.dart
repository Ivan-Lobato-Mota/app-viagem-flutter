import 'package:flutter/material.dart';
import 'detalhes_page.dart';

const List<Destino> destinos = [
  Destino(
    nome: 'Curitiba',
    icone: Icons.location_city,
    regiao: 'Paraná - Brasil',
    imagem: 'assets/images/curitiba.jpg',
    sobre:
        'Curitiba é conhecida por sua organização urbana, áreas verdes e cultura diversificada. A cidade combina modernidade com qualidade de vida.',
    clima: 'Ameno',
    melhorEpoca: 'Mar a Mai',
    tempoMedio: '2 a 3 dias',
    atracoes: [
      'Jardim Botânico',
      'Ópera de Arame',
      'Parque Tanguá',
      'Museu Oscar Niemeyer',
    ],
  ),
  Destino(
    nome: 'Florianópolis',
    icone: Icons.beach_access,
    regiao: 'Santa Catarina - Brasil',
    imagem: 'assets/images/florianopolis.jpg',
    sobre:
        'Florianópolis reúne mais de quarenta praias, lagoas e trilhas em uma só ilha. A cidade mistura vida litorânea, gastronomia e cultura açoriana.',
    clima: 'Litorâneo',
    melhorEpoca: 'Dez a Mar',
    tempoMedio: '4 a 5 dias',
    atracoes: [
      'Praia da Joaquina',
      'Lagoa da Conceição',
      'Praia dos Ingleses',
      'Fortaleza de São José',
    ],
  ),
  Destino(
    nome: 'Campos do Jordão',
    icone: Icons.hiking,
    regiao: 'São Paulo - Brasil',
    imagem: 'assets/images/camposdejordao.png',
    sobre:
        'Campos do Jordão fica na Serra da Mantiqueira e é famosa pelo clima frio, pela arquitetura europeia e pelas trilhas entre montanhas.',
    clima: 'Frio',
    melhorEpoca: 'Jun a Ago',
    tempoMedio: '2 a 4 dias',
    atracoes: [
      'Parque Amantikir',
      'Morro do Elefante',
      'Vila Capivari',
      'Palácio Boa Vista',
    ],
  ),
];

class DestinosPage extends StatelessWidget {
  DestinosPage({super.key});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Destinos'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            for (final destino in destinos)
              Card(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Icon(
                        destino.icone,
                        size: 60,
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
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(destino.regiao),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetalhesPage(destino: destino),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 15),
            SizedBox(
                width: 220,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                  label: Text('Voltar'),
                )),
          ],
        ),
      ),
    );
  }
}

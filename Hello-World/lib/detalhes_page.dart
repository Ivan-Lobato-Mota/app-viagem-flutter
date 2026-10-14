import 'package:flutter/material.dart';
import 'dados_destinos.dart';

class DetalhesPage extends StatelessWidget{
  final String cidade;
  DetalhesPage({super.key,
    required this.cidade,
  });
  Widget build(BuildContext context){
    final dados=buscarDestino(cidade);
    return Scaffold(
      appBar: AppBar(
        title: Text(dados['nome']),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body:
      SingleChildScrollView(
        child:
      Column(
        children: [
          Image.asset(dados['img']),
          Text(dados['estado']),
          Text('Sobre o destino',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(dados['desc']),
          Text('Informações rápidas',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.sunny_snowing,
            size: 60
          ),
          Text(dados['clima']),
          Icon(
              Icons.calendar_month,
              size: 60
          ),
          Text(dados['epoca']),
          Icon(
              Icons.access_time,
              size: 60
          ),
          Text(dados['permanencia']),
          Text('Principais atrações',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          for (var atracao in dados['atracoes'])
            ExpansionTile(
              title: Text(atracao['nome']),
              children: [
                Text(atracao['desc']),
                SizedBox(height: 15),
                Text(atracao['horario']),
                SizedBox(height: 15),
                Text(atracao['entrada']),
              ],
            ),
        ],
      ),
      ),
    );
  }
}

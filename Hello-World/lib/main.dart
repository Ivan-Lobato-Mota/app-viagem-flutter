import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'home_page.dart';
import 'dados_destino.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    print('Iniciando consulta ao Firebase...');

    final dados = await buscarDestino('Curitiba');

    if (dados.isNotEmpty) {
      print('SUCESSO! Dados encontrados:');
      print(dados);
    } else {
      print('Documento não encontrado no Firebase.');
    }
  } catch (erro) {
    print('ERRO AO CONSULTAR FIREBASE: $erro');
  }

  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guia de Viagens',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),

      home: const HomePage(),
    );
  }
}
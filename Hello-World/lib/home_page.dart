import 'package:flutter/material.dart';
import 'destinos_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guia de viagem'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 250,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Explore novos destinos',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Conheça alguns lugares interessantes para sua próxima viagem ser melhor.',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 220,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DestinosPage(),
                      ),
                    );
                  },
                  child: Text('Ver destinos'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

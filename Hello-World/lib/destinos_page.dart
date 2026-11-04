import 'package:flutter/material.dart';
import 'dados_destinos.dart';
import 'detalhes_page.dart';

class DestinosPage extends StatefulWidget {
  const DestinosPage({super.key});

  State<DestinosPage> createState()=>_DestinosPageState();
}

class _DestinosPageState extends State<DestinosPage>{
  String filtro='';

  late Future<List<Map<String, dynamic>>> futureDestinos;
  void initState(){
    super.initState();
    futureDestinos=listarDestinos();
  }

  Widget build(BuildContext context) {
          return Scaffold(

            appBar: AppBar(
              title: Text('Destinos'),
              centerTitle: true,
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),

            body:
            FutureBuilder<List<Map<String, dynamic>>>(
                future: listarDestinos(),
                builder: (context, snapshot) {

                  // Dados não encontrados
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Scaffold(
                      body: Center(
                        child: Text('Não há destinos'),
                      ),
                    );
                  }

                  final destinos = List<Map<String, dynamic>>.from(
                    snapshot.data!,
                  );

                  destinos.sort((a, b) {
                    String nomeA = (a['nome']).toString();
                    String nomeB = (b['nome']).toString();
                    return nomeA.toLowerCase().compareTo(
                      nomeB.toLowerCase(),
                    );
                  });

                  final destinosFiltrados = destinos.where((destino) {
                    String nome = (destino['nome'])
                        .toString()
                        .toLowerCase();
                    return nome.contains(filtro.toLowerCase());
                  }).toList();

                  return Padding(
                    padding: const EdgeInsets.all(15),

                    child: Column(
                      children: [

                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Pesquisar cidade...',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (valor) {
                            setState(() {
                              filtro = valor;
                            });
                          },
                        ),
                        SizedBox(height: 15),

                        Expanded(
                          child: destinosFiltrados.isEmpty ?
                          Center(
                            child: Text('Nenhuma cidade encontrada'),
                          ) : ListView.builder(
                            itemCount: destinosFiltrados.length,
                            itemBuilder: (context, index) {
                              final destino = destinosFiltrados[index];

                              return Card(
                                child: Padding(
                                  padding: EdgeInsets.all(15),

                                  child: Row(
                                    children: [

                                      Icon(
                                        Icons.location_city,
                                        size: 60,
                                        color: Colors.blue,
                                      ),

                                      SizedBox(width: 15),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [

                                            Text(
                                              destino['nome'],
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            Text(
                                              destino['estado'],
                                            ),

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
                                                    DetalhesPage(
                                                      cidade: destino['id'],
                                                    )
                                            ),
                                          );
                                        },
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
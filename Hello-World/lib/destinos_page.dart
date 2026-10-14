import 'package:flutter/material.dart';
import 'detalhes_page.dart';

class DestinosPage extends StatelessWidget{
  DestinosPage({super.key});
  Widget build(BuildContext context){
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
          Card(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                       Text('Curitiba',
                       style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.bold,
                        ),
                       ),
                        Text('Paraná - Brasil'),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>DetalhesPage(
                            cidade: 'Curitiba',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              ),
            ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Icon(
                    Icons.beach_access,
                    size: 60,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text('Florianópolis',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Santa Catarina - Brasil'),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>DetalhesPage(
                            cidade: 'Florianópolis',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Icon(
                    Icons.hiking,
                    size: 60,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text('Campos do Jordão',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('São Paulo - Brasil'),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>DetalhesPage(
                            cidade: 'Campos do Jordão',
                          ),
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
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
                label: Text('Voltar'),
              )
            ),
          ],
        ),
      ),
    );
  }
}
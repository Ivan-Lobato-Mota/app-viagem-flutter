Map<String, dynamic> buscarDestino(String cidade){
  if(cidade=='Curitiba'){
    return{
      'nome': 'Curitiba',
      'estado': 'Paraná - Brasil',
      'desc': 'Curitiba é a capital do Parná e é conhecida por seus parques, áreas verdes, planejamento urbano e diversos pontos turísticos.',
      'img': 'assets/images/curitiba.jpg',
      'clima': 'Temperado',
      'epoca': 'Março a maio',
      'permanencia': '3 a 4 dias',
      'atracoes': [
        {
          'nome': 'Jardim Botânico',
          'desc': 'Principal cartão postal da cidade',
          'horario': 'Todos os dias das 6h às 19h30',
          'entrada': 'Entrada gratuita',
        },
        {
          'nome': 'Ópera de Arame',
          'desc': 'Teatro construído com estrutura metálica em meio a natureza',
          'horario': 'Todos os dias das 10h às 18h',
          'entrada': 'Consultar valores',
        },
        {
          'nome': 'Museu Oscar Niemeyer',
          'desc': 'Dedicado à arte, arquitetura e design.',
          'horario': 'Terça a domingo, das 10h às 18h',
          'entrada': 'Consultar valores',
        },
      ],
    };
  }
  if(cidade=='Florianópolis'){
    return{
      'nome': 'Florianópolis',
      'estado': 'Santa Catarina - Brasil',
      'desc': 'Florianópolis é a capital de Santa Catarian e é conhecida por suas praias, natureza e gastronomia.',
      'img': 'assets/images/florianopolis.jpg',
      'clima': 'Subtropical',
      'epoca': 'Dezembro a Março',
      'permanencia': '4 a 5 dias',
      'atracoes': [
        {
          'nome': 'Lagoa da Conceição',
          'desc': 'Região turistica por natureza, restaurantes e bares',
          'horario': 'Acesso livre todos os dias',
          'entrada': 'Acesso gratuito',
        },
      ],
    };
  }
  if(cidade=='Campos do Jordão'){
    return{
      'nome': 'Campos do Jordão',
      'estado': 'São Paulo - Brasil',
      'desc': 'Campos do jordão é conhecida por ser a cidade na mais alta altitude do estado de São Paulo.',
      'img': 'assets/images/camposdejordao.png',
      'clima': 'Frio pra chapéu',
      'epoca': 'Junho a Agosto',
      'permanencia': '2 a 3 dias',
      'atracoes':[],
    };
  }
  return{
    'nome': 'Destino não encontrado',
    'estado': '',
    'desc': '',
    'img': '',
    'clima': '',
    'epoca': '',
    'permanencia': '',
    'atracoes':[],
  };
}

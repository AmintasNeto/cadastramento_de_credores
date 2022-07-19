class Data {
  late final String nome;
  late final String emissao;
  late final String prazo;
  late final double valor;
  Data({required this.nome,required this.valor,required this.emissao,required this.prazo});

  Map<String,dynamic> toMap(){
    return {
      'nome' : nome,
      'emissao': emissao,
      'prazo' : prazo,
      'valor' : valor
    };
  }
}
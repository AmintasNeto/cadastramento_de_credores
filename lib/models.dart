class LoginData {
  late final int id;
  late final String nome;
  late final String senha;
  late final List<String> email;
  late final int cpf;
  late final String nome_completo;

  LoginData(
      {required this.id,
      required this.nome,
      required this.senha,
      required this.email,
      required this.nome_completo,
      required this.cpf});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'senha': senha,
      'email': email,
      'nome_completo': nome_completo,
      'cpf': cpf
    };
  }
}

class AdressData {
  late final int cep, numero;
  int ?id_endereco;
  late final String rua, bairro, cidade, estado, pais, complemento;

  AdressData(
      {required this.cep,
      required this.rua,
      required this.numero,
      required this.bairro,
      required this.cidade,
      required this.estado,
      required this.pais,
      required this.complemento,
      this.id_endereco});

  Map<String, dynamic> toMap() {
    return {
      'cep' : cep,
      'rua' : rua,
      'numero' : numero,
      'bairro' : bairro,
      'cidade' : cidade,
      'estado' : estado,
      'pais' : pais,
      'complemento' : complemento,
      'id_endereco' : id_endereco
    };
  }
}

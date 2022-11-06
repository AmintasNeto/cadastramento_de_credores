import 'package:cadastramento_de_credores/models.dart';
import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';

class DB_helper {
  var UserRegisterResult;

  Future<LoginData> RequestUsers(String username) async {
    try {
      PostgreSQLConnection connection = PostgreSQLConnection(
          "db-projeto.cfqnxbl5thuy.us-east-1.rds.amazonaws.com",
          5432,
          "Projeto",
          username: "Usuario",
          password: "Usuario01");
      await connection.open();
      await connection.transaction((connection) async {
        UserRegisterResult = await connection.query(
          "SELECT * FROM credores.usuario u "
          "JOIN credores.pessoa_fisica pf ON(u.id_usuario = pf.id_usuario) "
          "WHERE u.nome = '$username';",
          allowReuse: true,
          timeoutInSeconds: 30,
        );
      });
      await connection.close();
      return LoginData(
          id: UserRegisterResult![0][0],
          nome: UserRegisterResult![0][1],
          senha: UserRegisterResult![0][2],
          email: UserRegisterResult![0][3],
          cpf: UserRegisterResult![0][4],
          nome_completo: UserRegisterResult![0][5]);
    } catch (exc) {
      if (kDebugMode) {
        print(exc);
      }
    }
    return LoginData(
        id: 0,
        nome: "",
        senha: "",
        email: <String>[],
        nome_completo: "",
        cpf: 0);
  }

  Future<void> RegisterUser(String username, String senha, List<String> email,
      String nome_completo, int cpf) async {
    try {
      PostgreSQLConnection connection = PostgreSQLConnection(
          "db-projeto.cfqnxbl5thuy.us-east-1.rds.amazonaws.com",
          5432,
          "Projeto",
          username: "Usuario",
          password: "Usuario01");
      await connection.open();
      await connection.query(
          "INSERT INTO credores.usuario VALUES(DEFAULT, '$username', '$senha', '{${email.join(",")}}');");
      var id = (await connection.query(
          "SELECT id_usuario FROM credores.usuario WHERE nome = '$username';"));
      await connection.query(
          "INSERT INTO credores.pessoa_fisica VALUES($cpf, '$nome_completo', ${id[0][0]});");
      await connection.close();
      if (kDebugMode) {
        print("Cadastro inserido!");
      }
    } catch (exc) {
      if (kDebugMode) {
        print(exc);
      }
    }
  }

  Future<void> RegisterAdress(AdressData data, int id_usuario) async {
    try {
      PostgreSQLConnection connection = PostgreSQLConnection(
          "db-projeto.cfqnxbl5thuy.us-east-1.rds.amazonaws.com",
          5432,
          "Projeto",
          username: "Usuario",
          password: "Usuario01");
      await connection.open();
      try {
        await connection.query("INSERT INTO credores.endereco "
            "VALUES(DEFAULT, ${data.cep}, '${data.rua}', '${data.bairro}', "
            "'${data.cidade}', '${data.estado}', '${data.pais}');");
      } catch (exc) {
        if (kDebugMode) {}
      }
      var id =
          await connection.query("SELECT id_endereco FROM credores.endereco "
              "WHERE cep = ${data.cep} "
              "AND rua = '${data.rua}' "
              "AND bairro = '${data.bairro}' "
              "AND cidade = '${data.cidade}'"
              "AND estado = '${data.estado}'"
              "AND pais = '${data.pais}';");
      try {
        await connection.query("INSERT INTO credores.localiza_se "
            "VALUES(${id[0][0]}, $id_usuario, ${data.numero}, '${data.complemento}');");
        if (kDebugMode) {
          print("Endereço inserido!");
        }
      } catch (exc) {}
      await connection.close();
    } catch (exc) {
      if (kDebugMode) {
        print(exc);
      }
    }
  }

  Future<List<AdressData>> getAdresses(int id_usuario) async {
    PostgreSQLConnection connection = PostgreSQLConnection(
        "db-projeto.cfqnxbl5thuy.us-east-1.rds.amazonaws.com", 5432, "Projeto",
        username: "Usuario", password: "Usuario01");
    await connection.open();
    var result = await connection.query("SELECT * FROM credores.endereco "
        "JOIN credores.localiza_se cl USING(id_endereco) WHERE cl.id_usuario = $id_usuario;");
    await connection.close();
    return List.generate(result.length, (index) {
      return AdressData(
          cep: result[index][1],
          rua: result[index][2],
          numero: result[index][8],
          bairro: result[index][3],
          cidade: result[index][4],
          estado: result[index][5],
          pais: result[index][6],
          complemento: result[index][9],
          id_endereco: result[index][0]);
    });
  }

  Future<void> DeleteAdress(
      int? id_endereco, int id_usuario, int numero) async {
    PostgreSQLConnection connection = PostgreSQLConnection(
        "db-projeto.cfqnxbl5thuy.us-east-1.rds.amazonaws.com", 5432, "Projeto",
        username: "Usuario", password: "Usuario01");
    await connection.open();
    await connection.transaction((connection) async {
      await connection.query("DELETE FROM credores.localiza_se "
          "WHERE id_endereco = $id_endereco AND id_usuario = $id_usuario AND numero = $numero");
      await connection.query(
          "DELETE FROM credores.endereco WHERE id_endereco = $id_endereco AND (SELECT COUNT(*) FROM credores.endereco JOIN credores.localiza_se USING(id_endereco) WHERE id_endereco = $id_endereco) = 1;");
    });
    await connection.close();
  }

  Future<void> DeleteUser(int id_usuario) async {
    PostgreSQLConnection connection = PostgreSQLConnection(
        "db-projeto.cfqnxbl5thuy.us-east-1.rds.amazonaws.com", 5432, "Projeto",
        username: "Usuario", password: "Usuario01");
    await connection.open();
    await connection.transaction((connection) async {
      await connection.query(
          "DELETE FROM credores.pessoa_fisica WHERE id_usuario = $id_usuario");
      await connection
          .query("DELETE FROM credores.usuario WHERE id_usuario = $id_usuario");
    });
    await connection.close();
  }

  Future<void> UpdateAdress(
      AdressData adress, int id_usuario, int old_number) async {
    PostgreSQLConnection connection = PostgreSQLConnection(
        "db-projeto.cfqnxbl5thuy.us-east-1.rds.amazonaws.com", 5432, "Projeto",
        username: "Usuario", password: "Usuario01");
    await connection.open();
    try {
      RegisterAdress(adress, id_usuario);
    } catch (exc) {}
    await connection.query("UPDATE credores.localiza_se "
        "SET numero = ${adress.numero},"
        "complemento = '${adress.complemento}'"
        " WHERE id_endereco = ${adress.id_endereco} "
        "AND id_usuario = $id_usuario "
        "AND numero = $old_number;");
    await connection.close();
  }

  Future<void> UpdateUserRegister(LoginData data) async {
    PostgreSQLConnection connection = PostgreSQLConnection(
        "db-projeto.cfqnxbl5thuy.us-east-1.rds.amazonaws.com", 5432, "Projeto",
        username: "Usuario", password: "Usuario01");
    await connection.open();
    await connection.transaction((connection) async {
      await connection.query(
          "UPDATE credores.usuario SET nome = '${data.nome}',"
          "senha = '${data.senha}',"
          "email = '{${data.email.join(",")}}' WHERE id_usuario = ${data.id}");
      await connection.query(
          "UPDATE credores.pessoa_fisica SET cpf = ${data.cpf},"
          "nome_completo = '${data.nome_completo}' WHERE id_usuario = ${data.id}");
    });
    await connection.close();
  }
}

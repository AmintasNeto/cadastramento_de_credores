import 'dart:ffi';

import 'package:cadastramento_de_credores/BD_helper.dart';
import 'package:cadastramento_de_credores/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final LoginData ?data;
  final bool isEditing;

  const SignUpPage({this.data, required this.isEditing});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String username = "";
  String nome_completo = "";
  int cpf = 0;
  String senha = "";
  late List<String> email = [""];
  DB_helper database = DB_helper();
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  late bool isEditing;

  @override
  void initState() {
    isEditing = widget.isEditing;
    if (isEditing) {
      username = widget.data!.nome;
      senha = widget.data!.senha;
      email = widget.data!.email;
      nome_completo = widget.data!.nome_completo;
      cpf = widget.data!.cpf;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela de cadastramento"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 5),
              child: Text("Nome do usuario:"),
            ),
          ),
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: TextField(
                controller: TextEditingController()
                  ..text = username,
                onChanged: (value) {
                  username = value;
                },
                decoration: const InputDecoration(
                  hintText: "exemplo123",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 5.0,
                  ),
                ),
              ),
            ),
          ),
          const Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 5),
              child: Text("Senha:"),
            ),
          ),
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.grey
              ),
              child: TextField(
                controller: TextEditingController()
                  ..text = senha,
                onChanged: (value) {
                  senha = value;
                },
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "exemplo123",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 5.0,
                  ),
                ),
              ),
            ),
          ),
          const Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 5),
              child: Text("E-mail:"),
            ),
          ),
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.grey
              ),
              child: TextField(
                controller: TextEditingController()
                  ..text = email[0],
                onChanged: (value) {
                  email = value.split(",");
                },
                decoration: const InputDecoration(
                  hintText: "exemplo123@dominio.com,exemplo123@dominio.com",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 5.0,
                  ),
                ),
              ),
            ),
          ),
          const Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 5),
              child: Text("Nome completo:"),
            ),
          ),
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.grey
              ),
              child: TextField(
                controller: TextEditingController()
                  ..text = nome_completo,
                onChanged: (value) {
                  nome_completo = value;
                },
                decoration: const InputDecoration(
                  hintText: "João da silva",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 5.0,
                  ),
                ),
              ),
            ),
          ),
          const Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 5),
              child: Text("CPF:"),
            ),
          ),
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.grey
              ),
              child: TextField(
                controller: TextEditingController()
                  ..text = cpf == 0 ? "" : cpf.toString(),
                onChanged: (value) {
                  cpf = int.parse(value);
                },
                decoration: const InputDecoration(
                  hintText: "12345678910",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 5.0,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: !isEditing,
            child: Flexible(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: ElevatedButton(
                    onPressed: () {
                      DB_helper bd = DB_helper();
                      bd.RegisterUser(
                          username, senha, email, nome_completo, cpf);
                      Navigator.pop(context);
                    },
                    child: const Text("Cadastrar"),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: isEditing,
            child: Flexible(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: ElevatedButton(
                    onPressed: () {
                      DB_helper bd = DB_helper();
                      LoginData data = LoginData(id: widget.data!.id,
                          nome: username,
                          senha: senha,
                          email: email,
                          nome_completo: nome_completo,
                          cpf: cpf);
                      bd.UpdateUserRegister(data);
                      Navigator.pop(context);
                    },
                    child: const Text("Editar"),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

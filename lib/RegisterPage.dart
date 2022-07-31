import 'dart:ffi';

import 'package:flutter/material.dart';

import 'ListPage.dart';
import 'models.dart';

class RegisterPage extends StatefulWidget {
  final Data cadastro;
  final List<Data> cadastros;

  const RegisterPage(
      {Key? key, required this.cadastro, required this.cadastros})
      : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String nome;
  bool nomeError = false;
  late String emissao;
  bool emissaoError = false;
  late String prazo;
  bool prazoError = false;
  late double valor;
  bool valorError = false;
  bool sucessSaveMessage = false;

  @override
  initState() {
    nome = widget.cadastro.nome;
    emissao = widget.cadastro.emissao;
    prazo = widget.cadastro.prazo;
    valor = widget.cadastro.valor;
  }

  void validacoes() {
    if (nome == "") {
      nomeError = true;
      sucessSaveMessage = false;
    } else {
      nomeError = false;
    }

    if (valor == 0.0) {
      valorError = true;
      sucessSaveMessage = false;
    } else {
      valorError = false;
    }

    if (emissao == "") {
      emissaoError = true;
      sucessSaveMessage = false;
    } else {
      emissaoError = false;
    }

    if (prazo == "") {
      prazoError = true;
      sucessSaveMessage = false;
    } else {
      prazoError = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastramento de credores'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15.0, left: 5.0),
              child: Text(
                "Nome:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCirc,
              height: 50,
              margin: const EdgeInsets.only(
                top: 5.0,
              ),
              decoration: BoxDecoration(
                color: nomeError ? Colors.red : Colors.grey,
              ),
              child: TextField(
                controller: TextEditingController()..text = nome,
                onChanged: (value) {
                  nome = value;
                },
                decoration: const InputDecoration(
                  hintText: "Digite o nome do credor",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 5.0,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 25.0,
              ),
              child: Text(
                "Valor da divida:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCirc,
              height: 50,
              margin: const EdgeInsets.only(
                top: 5.0,
              ),
              decoration: BoxDecoration(
                color: valorError ? Colors.red : Colors.grey,
              ),
              child: TextField(
                controller: TextEditingController()
                  ..text = valor != 0.0 ? valor.toString() : "",
                onChanged: (value) {
                  value.replaceAll(",", ".");
                  valor = double.parse(value);
                },
                decoration: const InputDecoration(
                  hintText: "Digite o valor da divida",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 5.0,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 25.0, left: 5.0),
              child: Text(
                "Data de Emissão:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCirc,
              height: 50,
              margin: const EdgeInsets.only(
                top: 5.0,
              ),
              decoration: BoxDecoration(
                color: emissaoError ? Colors.red : Colors.grey,
              ),
              child: TextField(
                controller: TextEditingController()..text = emissao,
                onChanged: (value) {
                  emissao = value;
                },
                decoration: const InputDecoration(
                  hintText: "DD/MM/AAAA",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 5.0,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 25.0, left: 5.0),
              child: Text(
                "Prazo:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCirc,
              height: 50,
              margin: const EdgeInsets.only(
                top: 5.0,
              ),
              decoration: BoxDecoration(
                color: prazoError ? Colors.red : Colors.grey,
              ),
              child: TextField(
                controller: TextEditingController()..text = prazo,
                onChanged: (value) {
                  prazo = value;
                },
                decoration: const InputDecoration(
                  hintText: "DD/MM/AAAA",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 5.0,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Visibility(
                visible: sucessSaveMessage,
                child: const Padding(
                  padding: EdgeInsets.only(
                    top: 35.0,
                    bottom: 25.0,
                    left: 100
                  ),
                  child: Text(
                    "Credor cadastrado com sucesso",
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, left: 150.0),
                  child: ElevatedButton(
                    onPressed: () {
                      validacoes();
                      setState(() {});
                      if (nome != "" &&
                          valor != 0.0 &&
                          emissao != "" &&
                          prazo != "") {
                        Data cadastro = Data(
                          nome: nome,
                          valor: valor,
                          emissao: emissao,
                          prazo: prazo,
                        );
                        widget.cadastros.add(cadastro);
                        setState(() {
                          nome = "";
                          valor = 0.0;
                          emissao = "";
                          prazo = "";
                          sucessSaveMessage = true;
                        });
                      }
                    },
                    child: const Text(
                      "Cadastrar",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, PageRouteBuilder(pageBuilder:
              (BuildContext context, Animation<double> animation,
                  Animation<double> secAnimation) {
            return ListPage(cadastros: widget.cadastros);
          }));
        },
        tooltip: 'List',
        child: const Icon(Icons.ad_units),
      ),
    );
  }
}

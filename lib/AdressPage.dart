import 'package:cadastramento_de_credores/ListPage.dart';
import 'package:cadastramento_de_credores/SignUpPage.dart';
import 'package:cadastramento_de_credores/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cadastramento_de_credores/BD_helper.dart';

class AdressPage extends StatefulWidget {
  final LoginData login_data;
  final bool isEditing;
  AdressData? data;

  AdressPage({required this.login_data, required this.isEditing, this.data});

  @override
  State<AdressPage> createState() => _AdressPageState();
}

class _AdressPageState extends State<AdressPage> {
  late LoginData loginData;
  DB_helper bd_hepler = DB_helper();
  int cep = 0, numero = 0;
  String rua = "",
      bairro = "",
      cidade = "",
      estado = "",
      pais = "",
      complemento = "";
  int old_number = 0;
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  late bool isVisible;

  @override
  void initState() {
    loginData = widget.login_data;
    isVisible = widget.isEditing;
    if (isVisible) {
      cep = widget.data!.cep;
      rua = widget.data!.rua;
      bairro = widget.data!.bairro;
      cidade = widget.data!.cidade;
      estado = widget.data!.estado;
      pais = widget.data!.pais;
      numero = widget.data!.numero;
      complemento = widget.data!.complemento;
      old_number = widget.data!.numero;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text("Endereços"),
            Padding(
              padding: const EdgeInsets.only(left: 160),
              child: FloatingActionButton(
                onPressed: () {
                  bd_hepler.DeleteUser(loginData.id);
                  Navigator.pop(context);
                },
                backgroundColor: Colors.red,
                child: Icon(Icons.delete_forever),
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Card(
                    child: Row(
                      children: [
                        Text(
                          "Nome: ${loginData.nome_completo}\n"
                          "Email: ${loginData.email.join(",\n")}\n"
                          "CPF: ${loginData.cpf}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  FloatingActionButton(
                      onPressed: () {
                        Navigator.push(context, PageRouteBuilder(pageBuilder:
                            (BuildContext context, Animation<double> animation,
                                Animation<double> secAnimation) {
                          return SignUpPage(
                            isEditing: true,
                            data: loginData,
                          );
                        }));
                      },
                      child: const Icon(Icons.edit)),
                  FloatingActionButton(
                      onPressed: () {
                        Navigator.push(context, PageRouteBuilder(pageBuilder:
                            (BuildContext context, Animation<double> animation,
                                Animation<double> secAnimation) {
                          return ListPage(login_data: loginData);
                        }));
                      },
                      child: const Icon(Icons.list)),
                ],
              ),
              Flexible(
                child: TextField(
                  onChanged: (value) {
                    cep = int.parse(value);
                  },
                  controller: TextEditingController()
                    ..text = cep != 0 ? cep.toString() : "",
                  decoration: InputDecoration(hintText: "CEP"),
                ),
              ),
              Flexible(
                child: TextField(
                  onChanged: (value) {
                    rua = value;
                  },
                  controller: TextEditingController()..text = rua,
                  decoration: InputDecoration(hintText: "Rua"),
                ),
              ),
              Flexible(
                child: TextField(
                  onChanged: (value) {
                    bairro = value;
                  },
                  controller: TextEditingController()..text = bairro,
                  decoration: InputDecoration(hintText: "Bairro"),
                ),
              ),
              Flexible(
                child: TextField(
                  onChanged: (value) {
                    cidade = value;
                  },
                  controller: TextEditingController()..text = cidade,
                  decoration: InputDecoration(hintText: "Cidade"),
                ),
              ),
              Flexible(
                child: TextField(
                  onChanged: (value) {
                    estado = value;
                  },
                  controller: TextEditingController()..text = estado,
                  decoration: InputDecoration(hintText: "Estado"),
                ),
              ),
              Flexible(
                child: TextField(
                  onChanged: (value) {
                    pais = value;
                  },
                  controller: TextEditingController()..text = pais,
                  decoration: InputDecoration(hintText: "País"),
                ),
              ),
              Flexible(
                child: TextField(
                  onChanged: (value) {
                    numero = int.parse(value);
                  },
                  controller: TextEditingController()
                    ..text = numero != 0 ? numero.toString() : "",
                  decoration: InputDecoration(hintText: "Número"),
                ),
              ),
              Flexible(
                child: TextField(
                  onChanged: (value) {
                    complemento = value;
                  },
                  controller: TextEditingController()..text = complemento,
                  decoration: InputDecoration(hintText: "Complemento"),
                ),
              ),
              Visibility(
                visible: !isVisible,
                child: Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        AdressData data = AdressData(
                            cep: cep,
                            rua: rua,
                            numero: numero,
                            bairro: bairro,
                            cidade: cidade,
                            estado: estado,
                            pais: pais,
                            complemento: complemento);
                        bd_hepler.RegisterAdress(data, loginData.id);
                      },
                      child: const Text("Registrar endereço"),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isVisible,
                child: Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        AdressData data = AdressData(
                            cep: cep,
                            rua: rua,
                            id_endereco: widget.data!.id_endereco,
                            numero: numero,
                            bairro: bairro,
                            cidade: cidade,
                            estado: estado,
                            pais: pais,
                            complemento: complemento);
                        await bd_hepler.UpdateAdress(
                            data, loginData.id, old_number);
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: const Text("Editar endereço"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

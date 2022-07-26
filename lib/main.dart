import 'dart:ffi';
import 'package:cadastramento_de_credores/ListPage.dart';
import 'package:cadastramento_de_credores/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String username = "";
  String password = "";
  bool showErrorUsername = false;
  bool showErrorPassword = false;
  Map<String,String> logins = {"picanhaassada02@aleatorio.com" : "Churrasquinho09"};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Página de Login")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "\tConta do Usuário:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCirc,
              height: 50,
              margin: const EdgeInsets.only(
                top: 5.0,
                bottom: 25.0,
              ),
              decoration: BoxDecoration(
                color: showErrorUsername ? Colors.red : Colors.grey,
              ),
              child: TextField(
                controller: TextEditingController()..text = username,
                onChanged: (value) {
                  username = value;
                },
                decoration: const InputDecoration(
                  hintText: "exemplo@dominio.com",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 5.0,
                  ),
                ),
              ),
            ),
            const Text(
              "\tSenha do Usuário:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCirc,
              height: 50,
              margin: const EdgeInsets.only(
                top: 5.0,
                bottom: 45.0,
              ),
              decoration: BoxDecoration(
                color: showErrorPassword ? Colors.red : Colors.grey,
              ),
              child: TextField(
                controller: TextEditingController()..text = password,
                onChanged: (value) {
                  password = value;
                },
                decoration: const InputDecoration(
                  hintText: "@abc123",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 5.0,
                  ),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showErrorUsername = username == "" ? true : false;
                  showErrorPassword = password == "" ? true : false;
                  if (username != "" && password != "") {
                    if(logins.containsKey(username)){
                      if(logins[username] == password){
                        Data cadastro = Data(nome: "", emissao: "", prazo: "", valor: 0.0);
                        List<Data> cadastros = [];
                        Navigator.push(context, PageRouteBuilder(pageBuilder:
                            (BuildContext context, Animation<double> animation,
                            Animation<double> secAnimation) {
                          return RegisterPage(cadastro: cadastro, cadastros: cadastros,);
                        }));
                      } else {
                        showErrorPassword = true;
                      }
                    } else {
                      showErrorUsername = true;
                    }
                  }
                  setState(() {});
                },
                child: const Text(
                  "Fazer Login",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

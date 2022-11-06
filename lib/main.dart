import 'package:cadastramento_de_credores/AdressPage.dart';
import 'package:cadastramento_de_credores/BD_helper.dart';
import 'package:cadastramento_de_credores/SignUpPage.dart';
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
  bool showError = false;
  DB_helper db_helper = DB_helper();

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
              " Conta do Usuário:",
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
                color: showError ? Colors.red : Colors.grey,
              ),
              child: TextField(
                controller: TextEditingController()..text = username,
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
            const Text(
              " Senha do Usuário:",
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
                color: showError ? Colors.red : Colors.grey,
              ),
              child: TextField(
                obscureText: true,
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
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      showError =
                          username == "" || password == "" ? true : false;
                      LoginData login = await db_helper.RequestUsers(username);
                      if (username != "" && password != "") {
                        if (login.nome == username) {
                          if (login.senha == password) {
                            showError = false;
                            Navigator.push(context, PageRouteBuilder(
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secAnimation) {
                              return AdressPage(login_data: login, isEditing: false,
                              );
                            }));
                          } else {
                            showError = true;
                          }
                        } else {
                          showError = true;
                        }
                      }
                      setState(() {
                        showError = false;
                      });
                    },
                    child: const Text(
                      "Fazer Login",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, PageRouteBuilder(pageBuilder:
                              (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secAnimation) {
                            return SignUpPage(isEditing: false,);
                          }));
                        },
                        child: const Text(
                          "Cadastrar usuario",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

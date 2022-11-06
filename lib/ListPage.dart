import 'package:flutter/material.dart';
import 'AdressPage.dart';
import 'BD_helper.dart';
import 'models.dart';

class ListPage extends StatefulWidget {
  final LoginData login_data;

  ListPage({required this.login_data});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late LoginData loginData;
  DB_helper bd_hepler = DB_helper();
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    loginData = widget.login_data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Endereços"),
      ),
      body: Container(
        height: 802,
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.grey),
        child: FutureBuilder(
          initialData: <AdressData>[],
            future: bd_hepler.getAdresses(loginData.id),
            builder: (context, AsyncSnapshot<List<AdressData>> snapshot) {
              return ListView.builder(
                key: listKey,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(context, PageRouteBuilder(pageBuilder:
                          (BuildContext context, Animation<double> animation,
                              Animation<double> secAnimation) {
                        return AdressPage(
                          login_data: loginData,
                          isEditing: true,
                          data: snapshot.data![index],
                        );
                      })).then((value) {
                        setState((){});
                      });
                    },
                    leading: Text("${snapshot.data![index].cep}\n"
                        "${snapshot.data![index].cidade}\n"
                        "${snapshot.data![index].estado}/"
                        "${snapshot.data![index].pais}"),
                    title: Text("${snapshot.data![index].rua}, "
                        "${snapshot.data![index].numero}"),
                    subtitle: Text(snapshot.data![index].complemento),
                    trailing: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          bd_hepler.DeleteAdress(
                              snapshot.data![index].id_endereco,
                              loginData.id,
                              snapshot.data![index].numero);
                        });
                      },
                      child: Text("Excluir"),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}

import 'package:cadastramento_de_credores/RegisterPage.dart';
import 'package:cadastramento_de_credores/UpdatePage.dart';
import 'package:flutter/material.dart';
import 'models.dart';

class ListPage extends StatefulWidget {
  final List<Data> cadastros;
  const ListPage({Key? key, required this.cadastros}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de cadastros"),
      ),
      body: ListView.builder(
        itemCount: widget.cadastros.length,
        itemBuilder: (context, index) => ListTile(
          onLongPress: () {
            widget.cadastros.removeAt(index);
            setState(() {});
          },
          onTap: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secAnimation) {
                      return UpdatePage(index: index ,cadastros: widget.cadastros,);
                    })).then((value) => setState(() {}));
          },
          leading: const Icon(Icons.account_circle),
          title: Text(
              widget.cadastros[index].nome
          ),
          subtitle: Text(
              '${widget.cadastros[index].emissao} - ${widget.cadastros[index].prazo}'
          ),
          trailing: Text(
              'RS ${widget.cadastros[index].valor}'
          ),
        ),
      ),
    );
  }
}


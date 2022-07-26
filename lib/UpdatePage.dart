import 'package:flutter/material.dart';

import 'models.dart';

class UpdatePage extends StatefulWidget {
  final int index;
  final List<Data> cadastros;
  const UpdatePage({Key? key, required this.index, required this.cadastros,}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Row(
                children: [
                  const Icon(Icons.account_circle, size: 62,),
                  Text(
                    widget.cadastros[widget.index].nome,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Card(
                margin: const EdgeInsets.only(
                  top: 25,
                ),
                child: Text(
                  "  Data de emissao: ${widget.cadastros[widget.index].emissao}\n"
                      "Prazo: ${widget.cadastros[widget.index].prazo}",
                  style: const TextStyle(
                    fontSize: 19,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            Center(
              child: Card(
                margin: const EdgeInsets.only(
                  top: 25,
                ),
                child: Text(
                  "  Dívida: RS ${widget.cadastros[widget.index].valor}  ",
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

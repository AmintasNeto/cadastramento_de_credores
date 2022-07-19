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
        title: const Text("Atualizar cadastro"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "\tAlterar nome:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 2),
            ),
            TextField(
              controller: TextEditingController()..text = widget.cadastros[widget.index].nome,
              onChanged: (value) {
                if(value != ""){
                  widget.cadastros[widget.index].nome = value;
                }
              },
            ),
            const Text(
              "\tAlterar dara de emissao:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 2),
            ),
            TextField(
              controller: TextEditingController()..text = widget.cadastros[widget.index].emissao,
              onChanged: (value) {
                if(value.length == 8){
                  widget.cadastros[widget.index].emissao = value;
                }
              },
            ),
            const Text(
              "\tAlterar prazo:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 2),
            ),
            TextField(
              controller: TextEditingController()..text = widget.cadastros[widget.index].prazo,
              onChanged: (value) {
                if(value.length == 8){
                  widget.cadastros[widget.index].prazo = value;
                }
              },
            ),
            const Text(
              "\tValor da divida:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 2),
            ),
            TextField(
              controller: TextEditingController()..text = widget.cadastros[widget.index].valor.toString(),
              onChanged: (value) {
                value.replaceAll(",", ".");
                double valor = double.parse(value);
                if(valor > 0.0){
                  widget.cadastros[widget.index].valor = valor;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

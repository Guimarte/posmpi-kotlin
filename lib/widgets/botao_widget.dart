import 'package:flutter/material.dart';

class BotaoPrincipal extends StatelessWidget {
  BotaoPrincipal({required this.nome, required this.function});
  String nome = '';
  Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF6600)),
              onPressed: () {
                function();
              },
              child: Text(
                nome,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ))),
    );
  }
}

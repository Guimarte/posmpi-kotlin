import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardPagamentoWidget extends StatelessWidget {
  CardPagamentoWidget(
      {required this.tipoPagamento,
      required this.valor,
      required this.function,
      required this.image});

  String tipoPagamento;
  String valor;
  SvgPicture image;
  Function() function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Card(
        color: Colors.grey.shade800,
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 60,height:60,child: image),
                Text(tipoPagamento,
                    style: TextStyle(color: Colors.white, fontSize: 22)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "R\$ $valor",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

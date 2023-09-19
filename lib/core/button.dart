import 'package:flutter/material.dart';

// Objetivo: Componentização de um botão.
class Button extends StatelessWidget {
  // Atributos:
  final String text;
  final double fontSize;
  final Color colorText;
  final Color colorBG;
  final double height;
  final Function() onPressed;

  /*
    Construtor:
    argum. obrigatório: na chamada, não preciso informar nome do argumento
    argum. opcional:
           * ficam entre chaves { ... }
           * na chamada, preciso informar o nome do argumento
  */
  const Button(this.text, this.onPressed,
      {super.key,
      this.fontSize = 14,
      this.colorText = Colors.white,
      this.colorBG = Colors.black,
      this.height = 30});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorBG,
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: colorText,
              fontSize: fontSize,
            ),
          )),
    );
  }
}

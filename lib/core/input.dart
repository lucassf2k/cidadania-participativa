import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  // Atributos:
  final TextInputType inputType;
  final Color inputColor;
  final double inputSize;
  final bool inputObscure;
  final int inputMaxLength;
  final TextEditingController inputController;
  final FormFieldValidator<String>? inputValidator;
  final TextInputAction inputAction;
  final FocusNode? inputActionNext;
  final FocusNode? inputFocusNode;
  final Function()? inputActionSubmit;
  final List<TextInputFormatter>? inputListFormatter;
  final String labelText;
  final Color labelColor;
  final double labelSize;
  final String hintText;
  final Color hintColor;
  final double hintSize;

  /*
    Construtor:
    argum. obrigatório: na chamada, não preciso informar nome do argumento
    argum. opcional:
           * ficam entre chaves { ... }
           * na chamada, preciso informar o nome do argumento
  */
  const Input(this.labelText, this.hintText, this.inputController,
      {super.key,
      this.labelColor = Colors.grey,
      this.labelSize = 14,
      this.inputType = TextInputType.text,
      this.inputColor = Colors.black87,
      this.inputSize = 14,
      this.inputMaxLength = 50,
      this.inputObscure = false,
      this.inputValidator,
      this.inputAction = TextInputAction.next,
      this.inputActionNext,
      this.inputActionSubmit,
      this.inputFocusNode,
      this.inputListFormatter,
      this.hintColor = Colors.black54,
      this.hintSize = 12});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: inputMaxLength,
      controller: inputController,
      validator: inputValidator,
      obscureText: inputObscure,
      keyboardType: inputType,
      textInputAction: inputAction,
      focusNode: inputFocusNode,

      inputFormatters: inputListFormatter,

      // OBS: permite definir diferentes regras para cada tipo de action
      onFieldSubmitted: (String text) {
        if (inputActionNext != null) {
          FocusScope.of(context).requestFocus(inputFocusNode);
        } else if (inputActionSubmit != null) {
          // Atenção: precisa estar neste padrão!
          inputActionSubmit!();
        }
      },

      style: TextStyle(color: inputColor, fontSize: inputSize),

      // OBS: border: por padrão é UnderlineInputBorder
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: labelText,
          labelStyle: TextStyle(color: labelColor, fontSize: labelSize),
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor, fontSize: hintSize)),
    );
  }
}

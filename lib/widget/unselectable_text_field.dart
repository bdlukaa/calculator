import 'package:flutter/material.dart';

class UnselectableTextField extends StatelessWidget {
  UnselectableTextField({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  final TextEditingController controller = TextEditingController();

  UnderlineInputBorder get transparentBorder =>
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));

  @override
  Widget build(BuildContext context) {
    controller.text = text;
    return TextField(
      controller: controller,
      showCursor: true,
      readOnly: true,
      autofocus: true,
      textAlign: TextAlign.right,
      enableInteractiveSelection: false,
      style: TextStyle(
        fontSize: 32,
      ),
      decoration: InputDecoration(
        enabledBorder: transparentBorder,
        border: transparentBorder,
        focusedBorder: transparentBorder,
        disabledBorder: transparentBorder,
        errorBorder: transparentBorder,
        focusedErrorBorder: transparentBorder,
      ),
    );
  }
}

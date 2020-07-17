import 'package:calculator/langs/lang.dart';
import 'package:calculator/widget/cross_fade.dart';
import 'package:calculator/widget/unselectable_text_field.dart';
import 'package:flutter/material.dart';

import '../../utils.dart';

class DigitalArea extends StatefulWidget {
  DigitalArea({
    Key key,
    @required this.text,
    @required this.result,
  }) : super(key: key);

  final String text, result;

  @override
  _DigitalAreaState createState() => _DigitalAreaState();
}

class _DigitalAreaState extends State<DigitalArea> {
  @override
  Widget build(BuildContext context) {
    Language lang = Language.of(context);
    return Container(
      constraints: BoxConstraints(
          // minHeight: 120,
          ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CrossFade<String>(
            initialData: '',
            data: widget.text,
            builder: (value) => UnselectableTextField(
              text: format(value, lang),
            ),
          ),
          CrossFade<String>(
            initialData: '',
            data: widget.result != widget.text ? widget.result : '',
            builder: (value) => Text(
              value,
              style: TextStyle(fontSize: 20),
            ),
          ),
          // Spacer(),
        ],
      ),
    );
  }
}

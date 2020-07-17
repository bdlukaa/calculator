import 'package:calculator/langs/lang.dart';
import 'package:calculator/models/key.dart';
import 'package:flutter/material.dart';

import 'keyboard_key.dart';

class SpecialKeyboard extends StatefulWidget {
  SpecialKeyboard({
    Key key,
    @required this.onPressed,
    @required this.width,
    this.height,
  }) : super(key: key);

  final Function(String) onPressed;
  final double width;
  final double height;

  @override
  SpecialKeyboardState createState() => SpecialKeyboardState();
}

class SpecialKeyboardState extends State<SpecialKeyboard> {
  bool opened = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (opened) {
            setState(() => opened = false);
            return false;
          }
          return true;
        },
        child: Padding(
          padding: EdgeInsets.only(right: 7),
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (!details.delta.dx.isNegative) {
                if (!opened) setState(() => opened = true);
              } else {
                if (opened) setState(() => opened = false);
              }
            },
            child: Row(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: opened ? widget.width * 0.75 : 0,
                  height: double.infinity,
                  // height: widget.height,
                  color: Colors.blue[300],
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 3, right: 5),
                  child: opened
                      ? SpecialKeywords(onPressed: widget.onPressed)
                      : SizedBox(),
                ),
                InkWell(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  onTap: () => setState(() => opened = !opened),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      opened ? Icons.navigate_before : Icons.navigate_next,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class SpecialKeywords extends StatelessWidget {
  const SpecialKeywords({Key key, @required this.onPressed}) : super(key: key);

  final Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    Language lang = Language.of(context);
    return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              KeyboardKey(
                text: lang.sin,
                name: Keys.sin,
                onPressed: onPressed,
                tooltip: lang.sine,
                color: Colors.white,
              ),
              KeyboardKey(
                text: '(',
                name: Keys.left_parentheses,
                onPressed: onPressed,
                tooltip: lang.openParenthesis,
                color: Colors.white,
              ),
              KeyboardKey(
                text: 'π',
                name: Keys.pi,
                onPressed: onPressed,
                tooltip: lang.pi,
                color: Colors.white,
              ),
              KeyboardKey(
                text: '%',
                name: Keys.percentage,
                onPressed: onPressed,
                tooltip: lang.percentage,
                color: Colors.white,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              KeyboardKey(
                text: lang.cos,
                name: Keys.cos,
                onPressed: onPressed,
                tooltip: lang.cosine,
                color: Colors.white,
              ),
              KeyboardKey(
                text: ')',
                name: Keys.right_parentheses,
                onPressed: onPressed,
                tooltip: lang.closeParenthesisTooltip,
                color: Colors.white,
              ),
              KeyboardKey(
                text: 'e',
                name: Keys.e,
                onPressed: onPressed,
                tooltip: lang.e,
                color: Colors.white,
              ),
              AbsorbPointer(
                absorbing: true,
                child: Opacity(
                  opacity: 0.6,
                  child: KeyboardKey(
                    text: 'log',
                    name: Keys.log,
                    onPressed: onPressed,
                    tooltip: lang.logarithm,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              KeyboardKey(
                text: lang.tan,
                name: Keys.tan,
                onPressed: onPressed,
                tooltip: lang.tangent,
                color: Colors.white,
              ),
              KeyboardKey(
                text: '^',
                name: Keys.elevated,
                onPressed: onPressed,
                tooltip: lang.exponecial,
                color: Colors.white,
              ),
              AbsorbPointer(
                absorbing: true,
                child: Opacity(
                  opacity: 0.6,
                  child: KeyboardKey(
                    text: '!',
                    name: Keys.fatorial,
                    onPressed: onPressed,
                    tooltip: lang.factorial,
                    color: Colors.white,
                  ),
                ),
              ),
              KeyboardKey(
                text: '√',
                name: Keys.root,
                onPressed: onPressed,
                tooltip: lang.squareRoot,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

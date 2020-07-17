import 'package:calculator/langs/lang.dart';
import 'package:calculator/models/key.dart';
import 'package:calculator/widget/keyboard/special_keyboard.dart';
import 'package:flutter/material.dart';

import 'keyboard_key.dart';

class Keyboard extends StatefulWidget {
  Keyboard({Key key, @required this.onPressed}) : super(key: key);

  final Function(String) onPressed;

  @override
  KeyboardState createState() => KeyboardState();
}

class KeyboardState extends State<Keyboard> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        double width = size.biggest.width ?? MediaQuery.of(context).size.width;
        // double minWidth = 560;
        Language lang = Language.of(context);
        return Stack(
          children: [
            Padding(
              // padding: width >= minWidth
              //     ? EdgeInsets.zero
              //     : EdgeInsets.only(left: 25),
              padding: EdgeInsets.only(left: 25),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  KeyboardKey(
                                    text: '7',
                                    name: Keys.seven,
                                    onPressed: widget.onPressed,
                                    tooltip: lang.seven,
                                  ),
                                  KeyboardKey(
                                    text: '4',
                                    name: Keys.four,
                                    onPressed: widget.onPressed,
                                    tooltip: lang.four,
                                  ),
                                  KeyboardKey(
                                    text: '1',
                                    name: Keys.one,
                                    onPressed: widget.onPressed,
                                    tooltip: lang.one,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  KeyboardKey(
                                    text: '8',
                                    name: Keys.eight,
                                    onPressed: widget.onPressed,
                                    tooltip: lang.eight,
                                  ),
                                  KeyboardKey(
                                    text: '5',
                                    name: Keys.five,
                                    onPressed: widget.onPressed,
                                    tooltip: lang.five,
                                  ),
                                  KeyboardKey(
                                    text: '2',
                                    name: Keys.two,
                                    onPressed: widget.onPressed,
                                    tooltip: lang.two,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  KeyboardKey(
                                    text: '9',
                                    name: Keys.nine,
                                    onPressed: widget.onPressed,
                                    tooltip: lang.nine,
                                  ),
                                  KeyboardKey(
                                    text: '6',
                                    name: Keys.six,
                                    onPressed: widget.onPressed,
                                    tooltip: lang.six,
                                  ),
                                  KeyboardKey(
                                    text: '3',
                                    name: Keys.three,
                                    onPressed: widget.onPressed,
                                    tooltip: lang.three,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: KeyboardKey(
                              text: '0',
                              name: Keys.zero,
                              onPressed: widget.onPressed,
                              tooltip: lang.zero,
                            )),
                            Expanded(
                              child: KeyboardKey(
                                text: '.',
                                name: Keys.point,
                                onPressed: widget.onPressed,
                                tooltip: lang.point,
                              ),
                            ),
                            Expanded(
                              child: KeyboardKey(
                                text: '=',
                                name: Keys.equal,
                                onPressed: widget.onPressed,
                                tooltip: lang.equal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      ),
                      child: Column(
                        children: [
                          KeyboardKey(
                            text: 'C',
                            name: Keys.clear,
                            expanded: true,
                            onPressed: widget.onPressed,
                            color: Colors.white,
                            tooltip: lang.clear,
                          ),
                          KeyboardKey(
                            icon: Icons.backspace,
                            name: Keys.back,
                            onPressed: widget.onPressed,
                            color: Colors.white,
                            tooltip: lang.deleteLast,
                          ),
                          KeyboardKey(
                            text: '÷',
                            name: Keys.division,
                            onPressed: widget.onPressed,
                            color: Colors.white,
                            tooltip: lang.division,
                          ),
                          KeyboardKey(
                            text: '×',
                            name: Keys.times,
                            onPressed: widget.onPressed,
                            color: Colors.white,
                            tooltip: lang.times,
                          ),
                          KeyboardKey(
                            icon: Icons.remove,
                            name: Keys.minus,
                            onPressed: widget.onPressed,
                            color: Colors.white,
                            tooltip: lang.minus,
                          ),
                          KeyboardKey(
                            icon: Icons.add,
                            name: Keys.plus,
                            onPressed: widget.onPressed,
                            color: Colors.white,
                            tooltip: lang.plus,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // width >= minWidth
                  //     ? Expanded(
                  //         flex: 2,
                  //         child: Container(
                  //           // color: Colors.blue,
                  //           child: SpecialKeywords(onPressed: widget.onPressed),
                  //         ),
                  //       )
                  //     : SizedBox(),
                ],
              ),
            ),
            // width >= minWidth
            //     ? Container()
            //     :
            Positioned(
              left: 0,
              bottom: 0,
              top: 0,
              child: SpecialKeyboard(
                onPressed: widget.onPressed,
                width: width,
                height: size.biggest.height,
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:calculator/langs/lang.dart';
import 'package:calculator/models/key.dart';
import 'package:calculator/widget/cross_fade.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '../../theme_manager.dart';
import 'digital_area.dart';
import '../../widget/keyboard/keyboard.dart';

import 'dart:math' as math;

import 'history.dart';
import '../../models/databases/calculator_history/database.dart' as history;

double kGrabbingHeight = 30;

class Calculator extends StatefulWidget {
  Calculator({Key key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator>
    with AutomaticKeepAliveClientMixin {
  String currentEquation = '';

  int exception = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    dynamic math = doMath();

    String mathText = math.toString();
    if (mathText.endsWith('.0'))
      mathText = mathText.substring(0, mathText.length - 2);

    Language lang = Language.of(context);
    return Scaffold(
      body: SafeArea(
        child: SnappingSheet(
          initSnapPosition: SnapPosition(positionFactor: 1),
          sheetAbove: SnappingSheetContent(
            child: History(
              currentExpression: currentEquation,
              onPress: (text) {},
            ),
            heightBehavior: SnappingSheetHeight.fixed(),
          ),
          grabbingHeight: kGrabbingHeight,
          grabbing: GrabSection(),
          snapPositions: const [
            SnapPosition(
              positionPixel: 0.0,
              snappingCurve: Curves.bounceOut,
              snappingDuration: Duration(milliseconds: 750),
            ),
            SnapPosition(positionFactor: 0.4),
            // SnapPosition(positionFactor: 0.8),
            SnapPosition(positionFactor: 1),
          ],
          child: Padding(
            padding: EdgeInsets.only(top: kGrabbingHeight - 10),
            child: LayoutBuilder(builder: (context, size) {
              return SizedBox(
                height: size.biggest.height,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Spacer(),
                      DigitalArea(
                        text: currentEquation,
                        result: math != null ? mathText : '',
                      ),
                      // Spacer(),
                      SizedBox(
                        height: size.biggest.height > size.biggest.width
                            ? size.biggest.height * 0.113
                            : 0,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: 7, left: 10, right: 10),
                        child: CrossFade<String>(
                          initialData: '',
                          data: exception > 0 ? lang.exception(exception) : '',
                          builder: (value) => Text(
                            value,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      Keyboard(
                        onPressed: (key) {
                          // print(key);
                          if (key == Keys.clear.toString())
                            setState(() => currentEquation = '');
                          else if (key == Keys.back.toString()) {
                            if (currentEquation.length > 0)
                              setState(() => currentEquation = currentEquation
                                  .substring(0, currentEquation.length - 1));
                          } else if (key == Keys.equal.toString()) {
                            if (math != null) {
                              setState(() {
                                history.addToHistory(currentEquation);
                                currentEquation = mathText;
                              });
                            }
                          } else {
                            if (key == '-' ||
                                key == '+' ||
                                key == '*' ||
                                key == '/' ||
                                key == '^' ||
                                key == '%' ||
                                key == '.') {
                              if (canAddSpecialKey(key))
                                setState(() => currentEquation += key);
                            } else
                              setState(() => currentEquation += key);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  bool canAddSpecialKey(String key) {
    if (currentEquation.isEmpty) {
      if (key == '-') return true;
      return false;
    }
    String lastKey = currentEquation.substring(currentEquation.length - 1);
    // print(lastKey);
    return lastKey != '+' && lastKey != '/' && lastKey != '*' && lastKey != '-';
  }

  dynamic doMath() {
    exception = 0;
    if (currentEquation.isEmpty) return null;
    dynamic v;
    try {
      Parser p = Parser();
      var currentEquation = this
          .currentEquation
          .replaceAll('π', 'pi')
          .replaceAll('pi', math.pi.toString())
          .replaceAll('√', 'sqrt');
      Expression exp = p.parse(currentEquation);
      dynamic value = exp.simplify().evaluate(EvaluationType.REAL, null);
      v = value;
    } on FormatException catch (e) {
      if (e.message == 'Mismatched parenthesis.') exception = 1;
      if (e.message == 'Invalid double') exception = 2;
      // print(e);
    } on RangeError catch (_) {
      // error may be expected
      exception = 3;
      // print(e.invalidValue);
    }
    return v;
  }

  @override
  bool get wantKeepAlive => true;
}

class GrabSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeManager.isBright(context) ? Colors.white : Colors.black,
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color:
                (ThemeManager.isBright(context) ? Colors.black : Colors.white)
                    .withOpacity(0.2),
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 30.0,
            height: 8.0,
            margin: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}

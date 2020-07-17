import 'package:calculator/langs/lang.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math;
import '../../dialogs.dart';
import '../../models/databases/calculator_history/history.dart' as history;
import '../../models/databases/calculator_history/database.dart' as db;
import '../../theme_manager.dart';

// ignore: must_be_immutable
class History extends StatefulWidget {
  History({
    Key key,
    @required this.currentExpression,
    @required this.onPress,
  }) : super(key: key);

  final String currentExpression;

  final Function(String expression) onPress;

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<DateTime> addedTimes = [];

  @override
  Widget build(BuildContext context) {
    var h = history.History.history;
    Language lang = Language.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          lang.history,
          style: TextStyle(
            color: ThemeManager.isBright(context) ? Colors.black : Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor:
            ThemeManager.isBright(context) ? Colors.white : Colors.black,
        elevation: 0,
        actions: [
          Visibility(
            visible: h.isNotEmpty,
            child: IconButton(
              icon: Icon(
                Icons.delete_sweep,
                color: ThemeManager.isBright(context)
                    ? Colors.black
                    : Colors.white,
              ),
              tooltip: lang.clear,
              onPressed: () {
                showClearHistoryDialog(context, () async {
                  await db.clear();
                  setState(() {});
                });
              },
            ),
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          color: ThemeManager.isBright(context) ? Colors.white : Colors.black,
        ),
        child: h.isEmpty && widget.currentExpression.isEmpty
            ? Center(
                child: Text(
                  lang.noHistory,
                  textAlign: TextAlign.center,
                ),
              )
            : ListView(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                reverse: true,
                children: [
                  Visibility(
                    visible: widget.currentExpression != null &&
                        widget.currentExpression.isNotEmpty,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        HistoryTitle(expression: true, time: null),
                        HistoryItem(
                          expression: widget.currentExpression,
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: h.length,
                    reverse: false,
                    itemBuilder: (context, index) {
                      var e = h.keys.toList()[index];
                      var d = h[e];
                      bool showTitle = false;
                      final dayTime = DateTime(d.year, d.month, d.day);
                      if (!addedTimes.contains(dayTime)) {
                        addedTimes.add(dayTime);
                        showTitle = true;
                      } else {
                        if (history.History.expressionsFrom(dayTime).first == e)
                          showTitle = true;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: showTitle,
                            child:
                                HistoryTitle(expression: false, time: dayTime),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: HistoryItem(
                              expression: e,
                              // not the first
                              showDivider: (index + 1) == h.length,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}

class HistoryTitle extends StatelessWidget {
  const HistoryTitle({
    Key key,
    @required this.expression,
    @required this.time,
  }) : super(key: key);

  final bool expression;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    Language lang = Language.of(context);
    return Container(
      child: Text(
        expression
            ? lang.currentExpression
            : time.isToday
                ? lang.today
                : time.isYesterday ? lang.yesterday : '${time.toLocal()}',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.blueAccent[100],
        ),
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    Key key,
    @required this.expression,
    this.showDivider = false,
  }) : super(key: key);

  final String expression;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    var m = doMath();

    String mathText = m.toString();
    if (mathText.endsWith('.0'))
      mathText = mathText.substring(0, mathText.length - 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          child: Text(
            expression,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 32,
            ),
          ),
        ),
        Visibility(
          visible: m != null && mathText != expression,
          child: Container(
            child: Text(
              mathText,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Visibility(
          visible: showDivider,
          child: Divider(),
        ),
      ],
    );
  }

  dynamic doMath() {
    dynamic v;
    try {
      Parser p = Parser();
      var currentEquation = this
          .expression
          .replaceAll('π', 'pi')
          .replaceAll('pi', math.pi.toString())
          .replaceAll('√', 'sqrt');
      Expression exp = p.parse(currentEquation);
      dynamic value = exp.simplify().evaluate(EvaluationType.REAL, null);
      v = value;
    } on FormatException catch (_) {
      // if (e.message == 'Mismatched parenthesis.') exception = 1;
      // if (e.message == 'Invalid double') exception = 2;
      // print(e);
    } on RangeError catch (_) {
      // error may be expected
      // exception = 3;
      // print(e.invalidValue);
    }
    return v;
  }
}

extension DateDayChecker on DateTime {
  bool get isTomorrow {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day + 1);
    final aDate = DateTime(this.year, this.month, this.day);
    return aDate == today;
  }

  bool get isToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final aDate = DateTime(this.year, this.month, this.day);
    return aDate == today;
  }

  bool get isYesterday {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final aDate = DateTime(this.year, this.month, this.day);
    return aDate == yesterday;
  }

  bool get isDayBeforeYesterday {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 2);
    final aDate = DateTime(this.year, this.month, this.day);
    return aDate == yesterday;
  }
}

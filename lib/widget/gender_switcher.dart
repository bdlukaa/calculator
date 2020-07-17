import 'package:calculator/langs/lang.dart';
import 'package:flutter/material.dart';

import '../theme_manager.dart';

enum Gender { MALE, FEMALE }

class GenderSwitcher extends StatelessWidget {
  GenderSwitcher({
    Key key,
    @required this.onChange,
    @required this.gender,
  }) : super(key: key);

  final Gender gender;
  final Function(Gender) onChange;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      double height = 50;
      Language lang = Language.of(context);
      TextStyle style = TextStyle(
        color: ThemeManager.isBright(context) ? Colors.black : Colors.white,
      );
      TextStyle selectedStyle = TextStyle(
        color: Colors.blue,
      );
      return Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: size.biggest.width,
            height: height,
            alignment: gender == Gender.MALE
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              width: size.biggest.width / 2,
              color: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: height,
            width: size.biggest.width,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => onChange(Gender.MALE),
                    child: Center(
                      child: Text(
                        lang.male,
                        style: gender == Gender.MALE ? selectedStyle : style,
                      ),
                    ),
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: InkWell(
                    onTap: () => onChange(Gender.FEMALE),
                    child: Center(
                      child: Text(
                        lang.female,
                        style: gender == Gender.FEMALE ? selectedStyle : style,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

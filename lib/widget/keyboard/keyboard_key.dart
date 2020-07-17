import 'package:calculator/models/key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../theme_manager.dart';

class KeyboardKey extends StatelessWidget {
  KeyboardKey({
    Key key,
    @required this.name,
    this.text,
    this.tooltip,
    this.icon,
    this.expanded = false,
    this.color,
    @required this.onPressed,
  }) : super(key: key);

  final Keys name;
  final String text, tooltip;
  final IconData icon;
  final bool expanded;
  final Function(String) onPressed;
  final Color color;

  Color get backgroundColor {
    final Keys key = name;
    if (key == Keys.clear ||
        key == Keys.back ||
        key == Keys.plus ||
        key == Keys.minus ||
        key == Keys.times ||
        key == Keys.division) return Colors.amber[400];
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return buildTooltip(
      InkWell(
        borderRadius: backgroundColor != Colors.amber[400]
            ? BorderRadius.circular(12)
            : BorderRadius.zero,
        splashColor: Colors.transparent,
        onTap: () => onPressed(getFromKey(name)),
        child: Ink(
          padding: EdgeInsets.all(8),
          color: backgroundColor,
          child: Center(
            child: icon != null
                ? Icon(
                    icon,
                    color: color != null
                        ? color
                        : ThemeManager.isBright(context)
                            ? Colors.black
                            : Colors.white,
                    size: 24,
                  )
                : Text(
                    text ?? '?',
                    style: TextStyle(
                      color: color != null
                          ? color
                          : ThemeManager.isBright(context)
                              ? Colors.black
                              : Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget buildTooltip(Widget child) {
    if (tooltip != null)
      return Tooltip(
        child: child,
        message: tooltip,
      );
    return child;
  }
}

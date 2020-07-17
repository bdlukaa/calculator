import 'package:calculator/theme_manager.dart';
import 'package:calculator/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'langs/lang.dart';

showClearHistoryDialog(BuildContext context, Function onClear) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Center(child: Text('Clear history?')),
      contentPadding: EdgeInsets.only(top: 25),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Button(
            color: Colors.green,
            splashColor: Colors.greenAccent,
            text: Text('Clear'),
            radius: BorderRadius.zero,
            shadowEnabled: false,
            onTap: onClear,
          ),
          Button(
            color: Colors.redAccent,
            splashColor: Colors.red,
            text: Text('Cancel'),
            onTap: () => Navigator.pop(context),
            shadowEnabled: false,
            radius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
        ],
      ),
    ),
  );
}

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeManager theme = Provider.of<ThemeManager>(context);
    Language lang = Language.of(context);
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Center(
        child: Text(
          lang.theme,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      children: <Widget>[
        CheckboxListTile(
          value: theme.mode == ThemeMode.light,
          onChanged: (mode) {
            theme.mode = ThemeMode.light;
          },
          title: Text(lang.light),
        ),
        CheckboxListTile(
          value: theme.mode == ThemeMode.dark,
          onChanged: (mode) {
            theme.mode = ThemeMode.dark;
          },
          title: Text(lang.dark),
        ),
        CheckboxListTile(
          value: theme.mode == ThemeMode.system,
          onChanged: (mode) {
            theme.mode = ThemeMode.system;
          },
          title: Text(lang.system),
        ),
      ],
    );
  }
}

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({Key key}) : super(key: key);

  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  @override
  Widget build(BuildContext context) {
    Language lang = Language.of(context);
    Language.languages.sort((a, b) => a.code == lang.code ? 1 : -1);
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Center(
        child: Text(
          lang.language,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      children: List<Widget>.generate(Language.languages.length, (index) {
        Language l = Language.languages[index];
        return CheckboxListTile(
          value: Language.of(context).code == l.code,
          onChanged: (mode) async {
            await Language.set(context, l);
          },
          title: Text(l.name),
        );
      }),
    );
  }
}

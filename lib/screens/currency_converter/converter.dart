import 'package:calculator/langs/lang.dart';
import 'package:calculator/models/currencies.dart';
import 'package:flutter/material.dart';

import '../../theme_manager.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class Converter extends StatefulWidget {
  Converter({Key key}) : super(key: key);

  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter>
    with AutomaticKeepAliveClientMixin {
  String fromISO = 'USD', toISO = 'BRL';

  bool _loading = false;
  num currentValue;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Language lang = Language.of(context);
    return Scaffold(
      body: currencyKey == null
          ? Center(
              child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error, color: Colors.redAccent, size: 42),
                  Text(
                    lang.authKeyError,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ))
          : ListView(
              padding: EdgeInsets.all(10),
              children: [
                Column(
                  children: [
                    _CurrencyPicker(
                      current: fromISO,
                      onChange: (iso) => setState(() => fromISO = iso),
                    ),
                    IconButton(
                      icon: Icon(Icons.swap_vert),
                      // TODO: animate swapping
                      tooltip: lang.swapCurrencies,
                      onPressed: () => setState(() {
                        final String _fromIso = fromISO;
                        final String _toIso = toISO;

                        fromISO = _toIso;
                        toISO = _fromIso;
                      }),
                    ),
                    _CurrencyPicker(
                      current: toISO,
                      onChange: (iso) => setState(() => toISO = iso),
                    ),
                  ],
                ),
                FlatButton(
                  child: Center(
                    child: _loading
                        ? SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(lang.convert),
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () async {
                    setState(() => _loading = true);
                    currentValue = await Currency.to(fromISO, toISO);
                    if (currentValue == null) {
                      showToast(
                        lang.checkConnection,
                        context: context,
                      );
                    }
                    setState(() => _loading = false);
                  },
                ),
                Center(
                  child: Text(
                    currentValue == null ? '' : '\$$currentValue $toISO',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: ThemeManager.isBright(context)
                          ? Colors.grey
                          : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _CurrencyPicker extends StatelessWidget {
  const _CurrencyPicker({
    Key key,
    @required this.current,
    @required this.onChange,
  }) : super(key: key);

  final String current;
  final Function(String iso) onChange;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      onChanged: (v) => onChange(v.toUpperCase()),
      value: current,
      items:
          List<DropdownMenuItem<String>>.generate(currencies.length, (index) {
        String iso = currencies.keys.toList()[index];
        String place = currencies[iso];
        return DropdownMenuItem<String>(
          child: Text(place),
          value: iso.toUpperCase(),
        );
      }),
    );
  }
}

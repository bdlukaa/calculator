import 'package:calculator/langs/lang.dart';
import 'package:calculator/screens/settings/settings_home.dart';
// import 'package:calculator/screens/unities_converter/unities_converter.dart';
import 'package:calculator/widget/zoomed_scaffold.dart';
import 'package:flutter/material.dart';

import '../theme_manager.dart';
import 'basic_calculator/calculator.dart';
import 'currency_converter/converter.dart';
import 'imc/imc_calculator.dart';

class Root extends StatefulWidget {
  Root({Key key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> with TickerProviderStateMixin {
  MenuController controller;

  @override
  void initState() {
    controller = MenuController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Language lang = Language.of(context);
    return ZoomScaffold(
      controller: controller,
      menuScreen: SettingsHome(),
      shadowColor: ThemeManager.isBright(context) ? null : Colors.white10,
      contentScreen: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => controller.toggle(),
            ),
            title: Text(lang.calculator),
            centerTitle: true,
            elevation: 0,
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: lang.basic),
                Tab(text: lang.bmi),
                Tab(text: lang.currenciesConverter),
                // Tab(text: 'Unities converter'),
              ],
            ),
          ),
          body: Container(
            color: Theme.of(context).appBarTheme.color,
            padding: EdgeInsets.only(top: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Calculator(),
                  IMCCalculator(),
                  Converter(),
                  // UnitiesConverter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

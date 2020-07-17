import 'package:calculator/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/root.dart';
import 'models/databases/calculator_history/database.dart' as history;

var appBuilderKey = GlobalKey<AppBuilderState>();
SharedPreferences preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();

  await history.startDatabase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeManager>(
      builder: (context) =>
          ThemeManager(preferences.getString('theme') ?? 'ThemeMode.system'),
      child: AppBuilder(
        key: appBuilderKey,
        child: Consumer<ThemeManager>(
          builder: (context, theme, child) {
            return MaterialApp(
              title: 'Calculator',
              themeMode: theme.mode,
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                sliderTheme: SliderThemeData(
                  showValueIndicator: ShowValueIndicator.always,
                ),
                scaffoldBackgroundColor: Colors.grey[700],
                appBarTheme: AppBarTheme(color: Colors.grey[850]),
                tabBarTheme: TabBarTheme(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: Colors.white)),
                  labelColor: Colors.white,
                ),
              ),
              theme: ThemeData(
                primarySwatch: Colors.blue,
                appBarTheme: AppBarTheme(color: Colors.blue),
                visualDensity: VisualDensity.adaptivePlatformDensity,
                tabBarTheme: TabBarTheme(
                  indicatorSize: TabBarIndicatorSize.label,
                ),
                sliderTheme: SliderThemeData(
                  showValueIndicator: ShowValueIndicator.always,
                ),
              ),
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return ScrollConfiguration(
                  behavior: NoGlowBehavior(),
                  child: child,
                );
              },
              localizationsDelegates: [
                // ... app-specific localization delegate[s] here
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('en', ''), // English, no country code
                const Locale('pt', ''), // Portuguese, no country code
              ],
              home: Root(),
            );
          },
        ),
      ),
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) =>
      child;
}

class AppBuilder extends StatefulWidget {
  AppBuilder({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  AppBuilderState createState() => AppBuilderState();
}

class AppBuilderState extends State<AppBuilder> {
  @override
  Widget build(BuildContext context) => widget.child;

  void update() => Provider.of<ThemeManager>(context).notify();
}

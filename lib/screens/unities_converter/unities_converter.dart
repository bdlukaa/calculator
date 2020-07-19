import 'package:flutter/material.dart';

class UnitiesConverter extends StatefulWidget {
  UnitiesConverter({Key key}) : super(key: key);

  @override
  _UnitiesConverterState createState() => _UnitiesConverterState();
}

class _UnitiesConverterState extends State<UnitiesConverter>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class UnitiesConverterFrom extends StatelessWidget {
  const UnitiesConverterFrom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

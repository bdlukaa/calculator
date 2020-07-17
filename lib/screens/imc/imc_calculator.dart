import 'package:calculator/langs/lang.dart';
import 'package:calculator/widget/gender_switcher.dart';
import 'package:flutter/material.dart';

class IMCCalculator extends StatefulWidget {
  IMCCalculator({Key key}) : super(key: key);

  @override
  _IMCCalculatorState createState() => _IMCCalculatorState();
}

class _IMCCalculatorState extends State<IMCCalculator>
    with AutomaticKeepAliveClientMixin {
  double height = 170, weight = 59;
  int age = 20;
  Gender gender = Gender.MALE;

  void calculate() {
    // String status;
    double height = this.height / 100;
    double imc = weight / (height * height);

    showDialog(
      context: context,
      builder: (context) {
        Language lang = Language.of(context);
        return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Center(child: Text(lang.yourBMI)),
        contentPadding: EdgeInsets.all(15),
        children: [
          Text(lang.yourBmi(imc.toStringAsFixed(2))),
          Text(lang.bmiHeight(height.toStringAsFixed(2))),
          Text(lang.bmiWeight(weight.toStringAsFixed(2))),
          Text(lang.bmiAge(age)),
          Text(lang.gender(gender)),
          Divider(),
          _buildTable(age, context),
        ],
      );
      },
    );
  }

  Widget _buildTable(int age, BuildContext context) {
    Language lang = Language.of(context);
    if (age <= 5 || age > 15)
      return DataTable(
        columns: [
          DataColumn(label: Text(lang.bmi)),
          DataColumn(label: Text(lang.result)),
        ],
        rows: age > 60 // idoso
            ? [
                DataRow(
                  cells: [
                    DataCell(Text(lang.lessThan(22))),
                    DataCell(Text(lang.lowWeight))
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text(lang.between(22, 27))),
                    DataCell(Text(lang.normalWeight))
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text(lang.moreThan(27))),
                    DataCell(Text(lang.obesity()))
                  ],
                ),
              ]
            : age < 5
                ? [
                    DataRow(
                      cells: [
                        DataCell(Text(lang.lessThan(13.9))),
                        DataCell(Text(lang.lowWeight))
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text(lang.between(13.9, 17.2))),
                        DataCell(Text(lang.normalWeight))
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text(lang.between(17.3, 18.9))),
                        DataCell(Text(lang.overWeight))
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text(lang.moreThan(19))),
                        DataCell(Text(lang.obesity()))
                      ],
                    ),
                  ]
                : [
                    // adult
                    DataRow(
                      cells: [
                        DataCell(Text(lang.lessThan(18.5))),
                        DataCell(Text(lang.lowWeight))
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text(lang.between(18.5, 24.9))),
                        DataCell(Text(lang.normalWeight))
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text(lang.between(25, 29.9))),
                        DataCell(Text(lang.overWeight))
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text(lang.between(30, 34.9))),
                        DataCell(Text(lang.obesity(1)))
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text(lang.between(35, 39.9))),
                        DataCell(Text(lang.obesity(2)))
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text(lang.moreThan(40))),
                        DataCell(Text(lang.obesity(3)))
                      ],
                    ),
                  ],
      );
    else
      return DataTable(
        columns: [
          DataColumn(label: Text(lang.bmi)),
          DataColumn(label: Text(lang.result)),
        ],
        rows: gender == Gender.FEMALE
            ? [
                DataRow(
                  cells: [
                    DataCell(Text(lang.to(12,16))),
                    DataCell(Text(lang.lowWeight)),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text(lang.to(12.5, 22))),
                    DataCell(Text(lang.normalWeight)),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text(lang.to(16.5, 22))),
                    DataCell(Text(lang.overWeight)),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text(lang.moreThanTo(18.5, 28))),
                    DataCell(Text(lang.obesity())),
                  ],
                ),
              ]
            : [
              DataRow(
                  cells: [
                    DataCell(Text(lang.to(12.5, 16.1))),
                    DataCell(Text(lang.lowWeight)),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text(lang.to(12.7, 22.5))),
                    DataCell(Text(lang.normalWeight)),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text(lang.to(16.45, 26.1))),
                    DataCell(Text(lang.overWeight)),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text(lang.moreThanTo(18, 26.1))),
                    DataCell(Text(lang.obesity())),
                  ],
                ),
            ],
      );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Language lang = Language.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: Slider(
                    onChanged: (v) => setState(() => weight = v),
                    value: weight,
                    max: 800,
                    min: 2,
                    label: lang.weight,
                    activeColor: Colors.redAccent,
                    inactiveColor: Colors.redAccent.withOpacity(0.2),
                  ),
                ),
                Text(lang.kg(weight)),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    onChanged: (v) => setState(() => height = v),
                    value: height,
                    max: 246,
                    min: 15,
                    label: lang.height,
                    activeColor: Colors.yellow,
                    inactiveColor: Colors.yellow.withOpacity(0.2),
                  ),
                ),
                Text(lang.cm(height)),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    onChanged: (v) => setState(() => age = v.toInt()),
                    value: age.toDouble(),
                    max: 130,
                    min: 0,
                    label: lang.age,
                    activeColor: Colors.blueGrey,
                    inactiveColor: Colors.blueGrey.withOpacity(0.2),
                  ),
                ),
                Text(lang.yrs(age)),
              ],
            ),
            GenderSwitcher(
              gender: gender,
              onChange: (gender) => setState(() => this.gender = gender),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(lang.calculate),
                color: Colors.green,
                textColor: Colors.white,
                onPressed: calculate,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

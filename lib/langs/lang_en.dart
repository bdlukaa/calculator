import 'package:calculator/widget/gender_switcher.dart';

import 'lang.dart';

class English extends Language {
  String get code => 'en';
  String get name => 'English';

  String get calculator => 'Calculator';

  String get basic => 'Basic';

  String get bmi => 'BMI';
  String get male => 'Male';
  String get female => 'Female';
  String get calculate => 'Calculate';
  String kg(double kg) => '${kg.toStringAsFixed(2)} kg';
  String cm(double cm) => '${cm.toStringAsFixed(2)} cm';
  String yrs(int age) => '$age yrs';
  String get height => 'Height (centimeters)';
  String get weight => 'Weight (kilograms)';
  String get age => 'Age (years)';
  String get yourBMI => 'Your BMI';
  String yourBmi(String bmi) => 'Your BMI: $bmi';
  String bmiHeight(String height) => 'Height: $height meters';
  String bmiWeight(String weight) => 'Weight: $weight kg';
  String bmiAge(int age) => 'Age: $age years';
  String gender(Gender g) {
    String gender = g.toString().replaceAll('Gender.', '');
    String genderText = gender.substring(0, 1).toUpperCase() +
        gender.substring(1).toLowerCase();
    return 'Gender: $genderText';
  }

  String get result => 'Result';
  String lessThan(num number) => 'Less than $number';
  String moreThan(num number) => 'More than $number';
  String between(num number, num number2) => 'Between $number and $number2';
  String get lowWeight => 'Low weight';
  String get normalWeight => 'Normal weight';
  String get overWeight => 'Overweight';
  String obesity([int grau]) {
    if (grau == null) return 'Obesity';
    return 'Obesity $grau';
  }
  String to(num number, num number2) => '$number to $number2';
  String moreThanTo(num number, num number2) => 'More than $number to $number2';

  String get settings => 'Settings';
  String get user => 'User';
  String get app => 'App';
  String get theme => 'Theme';
  String get language => 'Language';

  String get light => 'Light';
  String get dark => 'Dark';
  String get system => 'System (default)';

  String get closeParenthesis => 'Close the parenthesis';

  String get zero => 'Zero';
  String get one => 'One';
  String get two => 'Two';
  String get three => 'Three';
  String get four => 'Four';
  String get five => 'Five';
  String get six => 'Six';
  String get seven => 'Seven';
  String get eight => 'Eight';
  String get nine => 'Nine';
  String get point => 'Point';
  String get equal => 'Equal';

  String get clear => 'Clear';
  String get deleteLast => 'Delete last';
  String get division => 'Division';
  String get times => 'Times';
  String get minus => 'Minus';
  String get plus => 'Plus';

  String get sin => 'sin';
  String get cos => 'cos';
  String get tan => 'tan';
  String get openParenthesis => 'Open parenthesis';
  String get closeParenthesisTooltip => 'Close parenthesis';
  String get pi => 'Pi';
  String get squareRoot => 'Square root';
  String get percentage => 'Percentage';
  String get e => 'Base of the natural logarithms.';
  String get exponecial => 'Exponetial';
  String get factorial => 'Factorial';
  String get logarithm => 'Logarithm';

  String get sine => 'Sine';
  String get tangent => 'Tangent';
  String get cosine => 'Cosine';

  String get mismatchedParenthesis => 'Mismatched parenthesis';
  String get invalidNumber => 'Invalid number';
  String get incompleteExpression => 'Incomplete expression';

  String get history => 'History';
  String get noHistory => 'Your history is empty';
  String get currentExpression => 'Current expression';
  String get today => 'Today';
  String get yesterday => 'Yesterday';

  String get authKeyError => 'Auth key missing!\nAdd your key at models/currencies';
  String get swapCurrencies => 'Swap currencies';
  String get convert => 'Convert';
  String get currenciesConverter => 'Currencies converter';

  String get checkConnection => 'An error occurred! Check your connection';

}

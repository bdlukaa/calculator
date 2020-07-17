import 'langs/lang.dart';

String format(String expression, Language lang) {
  return expression
      .replaceAll('/', '÷')
      .replaceAll('*', '×')
      .replaceAll('sin', lang.sin)
      .replaceAll('cos', lang.cos)
      .replaceAll('tan', lang.tan);
}

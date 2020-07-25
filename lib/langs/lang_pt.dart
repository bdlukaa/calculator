import 'package:calculator/widget/gender_switcher.dart';

import 'lang.dart';

class Portuguese extends Language {
  String get code => 'pt';
  String get name => 'Português';

  String get calculator => 'Calculadora';

  String get basic => 'Simples';

  String get bmi => 'IMC';
  String get male => 'Masculino';
  String get female => 'Feminino';
  String get calculate => 'Calcular';
  String kg(double kg) => '${kg.toStringAsFixed(2)} kg';
  String cm(double cm) => '${cm.toStringAsFixed(2)} cm';
  String yrs(int age) => '$age anos';
  String get height => 'Altura (centimetros)';
  String get weight => 'Peso (kilogramas)';
  String get age => 'Idade (anos)';
  String get yourBMI => 'Seu IMC';
  String yourBmi(String bmi) => 'Seu IMC: $bmi';
  String bmiHeight(String height) => 'Altura: $height metros';
  String bmiWeight(String weight) => 'Peso: $weight kg';
  String bmiAge(int age) => 'Idade: $age anos';
  String gender(Gender gender) {
    String g = gender == Gender.MALE ? this.male : this.female;
    return 'Gênero: $g';
  }

  String get result => 'Resultado';
  String lessThan(num number) => 'Menos que $number';
  String moreThan(num number) => 'Mais que $number';
  String between(num number, num number2) => 'Entre $number e $number2';
  String get lowWeight => 'Abaixo do peso';
  String get normalWeight => 'Peso normal';
  String get overWeight => 'Sobrepeso';
  String obesity([int grau]) {
    if (grau == null) return 'Obesidade';
    return 'Obesidade $grau';
  }

  String to(num number, num number2) => '$number até $number2';
  String moreThanTo(num number, num number2) => 'Mais que $number até $number2';

  String get settings => 'Configurações';
  String get user => 'Usuário';
  String get app => 'App';
  String get theme => 'Tema';
  String get language => 'Idioma';

  String get light => 'Claro';
  String get dark => 'Escuro';
  String get system => 'Sistema (padrão)';

  String get closeParenthesis => 'Feche os parênteses';

  String get zero => 'Zero';
  String get one => 'Um';
  String get two => 'Dois';
  String get three => 'Três';
  String get four => 'Quatro';
  String get five => 'Cinco';
  String get six => 'Seis';
  String get seven => 'Sete';
  String get eight => 'Oito';
  String get nine => 'Nove';
  String get point => 'Ponto';
  String get equal => 'Igual';

  String get clear => 'Limar';
  String get deleteLast => 'Apagar';
  String get division => 'Divisão';
  String get times => 'Multiplicação';
  String get minus => 'Subtração';
  String get plus => 'Adição';

  String get sin => 'sen';
  String get cos => 'cos';
  String get tan => 'tan';
  String get openParenthesis => 'Abrir parênteses';
  String get closeParenthesisTooltip => 'Fechar parênteses';
  String get pi => 'Pi';
  String get squareRoot => 'Raiz quadrada';
  String get percentage => 'Porcentagem';
  String get e => 'Base dos logarítimos naturais.';
  String get exponecial => 'Exponecial';
  String get factorial => 'Fatorial';
  String get logarithm => 'Logaritmo';

  String get sine => 'Seno';
  String get tangent => 'Tangente';
  String get cosine => 'Cosseno';

  String get mismatchedParenthesis => 'Parênteses incompatíveis';
  String get invalidNumber => 'Número inválido';
  String get incompleteExpression => 'Expressão incompleta';

  String get history => 'Histórico';
  String get noHistory => 'Seu histórico está vazio';
  String get currentExpression => 'Expressão atual';
  String get today => 'Hoje';
  String get yesterday => 'Ontem';

  String get authKeyError => 'Chave de autenticação faltando!\nAdicione sua chave em models/currencies';
  String get swapCurrencies => 'Trocar moeda';
  String get convert => 'Converter';
  String get currenciesConverter => 'Conversor de moeda';

  String get checkConnection => 'Um erro ocorreu! Cheque sua conexão';
  
}

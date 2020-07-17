String getFromKey(Keys key) {
  dynamic k;
  switch (key) {
    case Keys.zero:
      k = 0;
      break;
    case Keys.one:
      k = 1;
      break;
    case Keys.two:
      k = 2;
      break;
    case Keys.three:
      k = 3;
      break;
    case Keys.four:
      k = 4;
      break;
    case Keys.five:
      k = 5;
      break;
    case Keys.six:
      k = 6;
      break;
    case Keys.seven:
      k = 7;
      break;
    case Keys.eight:
      k = 8;
      break;
    case Keys.nine:
      k = 9;
      break;
    case Keys.division:
      k = '/';
      break;
    case Keys.times:
      k = '*';
      break;
    case Keys.plus:
      k = '+';
      break;
    case Keys.minus:
      k = '-';
      break;
    case Keys.point:
      k = '.';
      break;
    case Keys.left_parentheses:
      k = '(';
      break;
    case Keys.right_parentheses:
      k = ')';
      break;
    case Keys.log:
      k = 'log(';
      break;
    case Keys.e:
      k = 'e';
      break;
    case Keys.sin:
      k = 'sin';
      break;
    case Keys.cos:
      k = 'cos';
      break;
    case Keys.tan:
      k = 'tan';
      break;
    case Keys.root:
      k = '√';
      break;
    case Keys.elevated:
      k = '^';
      break;
    case Keys.pi:
      k = 'π';
      break;
    case Keys.fatorial:
      k = '!';
      break;
    case Keys.percentage:
      k = '%';
      break;
    default:
      k = key.toString();
      break;
  }
  return k.toString();
}

enum Keys {
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  plus,
  minus,
  times,
  division,
  equal,
  back,
  point,
  clear,
  log,
  root,
  left_parentheses,
  right_parentheses,
  e,
  elevated,
  fatorial,
  sin,
  cos,
  tan,
  percentage,
  pi,
}

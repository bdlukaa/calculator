class History {
  static Map<String, DateTime> history = {};

  static List<String> expressionsFrom(DateTime d) {
    List<String> expressions = [];
    final dayTime = DateTime(d.year, d.month, d.day);
    history.forEach((k, v) {
      final dTime = DateTime(v.year, v.month, v.day);
      if (dTime == dayTime) expressions.add(k);
    });
    return expressions;
  }

}
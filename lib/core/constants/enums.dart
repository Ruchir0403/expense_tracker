enum ExpenseCategory {
  food,
  travel,
  shopping,
  bills,
  others;

  String toJson() => name;
  static ExpenseCategory fromJson(String json) => values.byName(json);

  String get displayName {
    switch (this) {
      case ExpenseCategory.food:
        return 'Food';
      case ExpenseCategory.travel:
        return 'Travel';
      case ExpenseCategory.shopping:
        return 'Shopping';
      case ExpenseCategory.bills:
        return 'Bills';
      case ExpenseCategory.others:
        return 'Others';
    }
  }
}

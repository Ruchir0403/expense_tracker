import 'package:json_annotation/json_annotation.dart';
import '../../core/constants/enums.dart';

part 'expense_model.g.dart';

@JsonSerializable()
class Expense {
  final String? id;

  @JsonKey(name: 'user_id')
  final String? userId;

  final String title;

  final double amount;

  final ExpenseCategory category;

  @JsonKey(name: 'expense_date')
  final DateTime expenseDate;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  Expense({
    this.id,
    this.userId,
    required this.title,
    required this.amount,
    required this.category,
    required this.expenseDate,
    this.createdAt,
  });

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}

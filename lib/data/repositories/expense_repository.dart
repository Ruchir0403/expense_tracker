import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/expense_model.dart';

class ExpenseRepository {
  final SupabaseClient _supabase;

  ExpenseRepository(this._supabase);

  Future<void> addExpense(Expense expense) async {
    final data = expense.toJson();
    data.remove('id');
    data.remove('created_at');
    data.remove('user_id');

    await _supabase.from('expenses').insert(data);
  }

  Future<List<Expense>> getExpenses() async {
    final response = await _supabase
        .from('expenses')
        .select()
        .order('expense_date', ascending: false);

    return (response as List).map((e) => Expense.fromJson(e)).toList();
  }

  Future<void> updateExpense(Expense expense) async {
    if (expense.id == null) return;

    final data = expense.toJson();
    data.remove('id');
    data.remove('created_at');
    data.remove('user_id');

    await _supabase.from('expenses').update(data).eq('id', expense.id!);
  }

  Future<void> deleteExpense(String id) async {
    await _supabase.from('expenses').delete().eq('id', id);
  }
}

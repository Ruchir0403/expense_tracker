import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/models/expense_model.dart';
import '../../../data/repositories/expense_repository.dart';

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepository(Supabase.instance.client);
});

final expenseListProvider = FutureProvider.autoDispose<List<Expense>>((
  ref,
) async {
  final repository = ref.watch(expenseRepositoryProvider);
  return repository.getExpenses();
});

class ExpenseController extends StateNotifier<AsyncValue<void>> {
  final ExpenseRepository _repository;
  final Ref _ref;

  ExpenseController(this._repository, this._ref)
    : super(const AsyncValue.data(null));

  Future<void> addExpense(Expense expense) async {
    state = const AsyncValue.loading();
    try {
      await _repository.addExpense(expense);
      _ref.invalidate(expenseListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateExpense(Expense expense) async {
    state = const AsyncValue.loading();
    try {
      await _repository.updateExpense(expense);
      _ref.invalidate(expenseListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteExpense(String id) async {
    try {
      await _repository.deleteExpense(id);
      _ref.invalidate(expenseListProvider);
    } catch (e) {}
  }
}

final expenseControllerProvider =
    StateNotifierProvider<ExpenseController, AsyncValue<void>>((ref) {
      return ExpenseController(ref.watch(expenseRepositoryProvider), ref);
    });

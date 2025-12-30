import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/onboarding_screen.dart';
import '../../features/auth/presentation/signup_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/expenses/presentation/add_expense_screen.dart';
import '../../features/stats/presentation/stats_screen.dart';
import '../../data/models/expense_model.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  final authRepository = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: '/splash',

    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges),

    redirect: (context, state) {
      final isAuthenticated = authState.value?.session != null;
      final isSplash = state.matchedLocation == '/splash';
      if (authState.isLoading) return null;

      if (isSplash) {
        return null;
      }

      final isLoggingIn =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup' ||
          state.matchedLocation == '/onboarding';

      if (!isAuthenticated && !isLoggingIn) return '/login';
      if (isAuthenticated && isLoggingIn) return '/home';

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/add-expense',
        builder: (context, state) {
          final expenseToEdit = state.extra as Expense?;
          return AddExpenseScreen(expenseToEdit: expenseToEdit);
        },
      ),
      GoRoute(path: '/stats', builder: (context, state) => const StatsScreen()),
    ],
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

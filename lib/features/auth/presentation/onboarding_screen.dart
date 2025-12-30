import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(),

              Container(
                height: 350,
                width: double.infinity,
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/onboarding.png',
                  fit: BoxFit.contain,
                ),
              ),

              const Spacer(),
              Text(
                'Spend Smarter\nSave More',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppConstants.primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.push('/signup'),
                child: const Text('Get Started'),
              ),
              const SizedBox(height: 16),
              const Text("Already have an account?"),
              TextButton(
                onPressed: () => context.push('/login'),
                child: const Text('Log In'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

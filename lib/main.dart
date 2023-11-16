// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MainApp());
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const ScreenOne(useGoRouter: true),
      routes: [
        GoRoute(
          path: 'two',
          builder: (_, __) => const ScreenTwo(),
        ),
      ],
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Change this to swap between GoRouter and non-GoRouter
    const bool useGoRouter = false;
    return useGoRouter
        ? MaterialApp.router(routerConfig: router)
        : const MaterialApp(home: ScreenOne(useGoRouter: useGoRouter));
  }
}

class ScreenOne extends StatelessWidget {
  final bool useGoRouter;

  const ScreenOne({
    super.key,
    required this.useGoRouter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () => useGoRouter
              ? GoRouter.of(context).go('/two')
              : Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ScreenTwo(),
                  ),
                ),
          child: const Text('Go to Screen Two'),
        ),
      ),
    );
  }
}

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) => print('onPopInvoked didPop? $didPop'),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Screen Two'),
        ),
        body: const Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}

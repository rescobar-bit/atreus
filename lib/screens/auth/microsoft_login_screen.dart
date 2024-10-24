import 'package:flutter/material.dart';

class MicrosoftLoginScreen extends StatelessWidget {
  const MicrosoftLoginScreen({super.key});
  static const String routeName = 'microsoft-login';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Inicio con microsoft'),
      ),
    );
  }
}
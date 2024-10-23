import 'package:flutter/material.dart';

class SmallSphere extends StatelessWidget {
  const SmallSphere({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.blue.shade200.withOpacity(0.6),
            Colors.blue.shade400.withOpacity(0.3),
          ],
          center: Alignment.center,
          radius: 0.8, // Ajusta el radio del degradado
        ),
      ),
    );
  }
}
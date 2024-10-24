import 'package:flutter/material.dart';

class LargeSphere extends StatelessWidget {
  const LargeSphere({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.lightBlue.shade300, // Color del centro (más claro)
            Colors.lightBlue.shade700, // Color del borde (más oscuro)
          ],
          center: Alignment.center,
          radius: 0.8, // Ajusta el radio del degradado
        ),
      ),
    );
  }
}
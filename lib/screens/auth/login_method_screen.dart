import 'package:atreus/widgets/ui/large_sphere.dart';
import 'package:atreus/widgets/ui/small_sphere.dart';
import 'package:flutter/material.dart';

class LoginMethodScreen extends StatelessWidget {
  const LoginMethodScreen({super.key});
   static const String routeName = 'login-method';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: -50,
              left: -50,
              child: LargeSphere(),
            ),
            const Positioned(
              top: 200,
              right: -50,
              child: LargeSphere(),
            ),
            const Positioned(
              bottom: -80,
              left: 100,
              child: LargeSphere(),
            ),
            const Positioned(
              top: 90,
              left: -40,
              child: SmallSphere(),
            ),
            const Positioned(
              top: 150,
              right: -30,
              child: SmallSphere(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      width: size.width * .6,
                      height: size.height * .14,
                      child: const Placeholder(),
                    ),
                  ),
                  const SizedBox(height: 150,),
                  Text(
                    'Iniciar sesión',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      color: Colors.lightBlue.shade700,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      shadowColor: Colors.black.withOpacity(0.3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.window_rounded,
                          size: 30,
                          color: Colors.lightBlue.shade700,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Continuar con Microsoft',
                          style: TextStyle(fontSize: 16, color: Colors.lightBlue.shade700),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Center(
                    child: Text('o', style: TextStyle(fontSize: 20, color: Colors.lightBlue.shade700),)
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      shadowColor: Colors.black.withOpacity(0.3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.key,
                          size: 30,
                          color: Colors.lightBlue.shade700,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Correo y contraseña',
                          style: TextStyle(fontSize: 16, color: Colors.lightBlue.shade700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
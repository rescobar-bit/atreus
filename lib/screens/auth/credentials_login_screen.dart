import 'package:atreus/widgets/ui/large_sphere.dart';
import 'package:atreus/widgets/ui/small_sphere.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CredentialsLoginScreen extends StatefulWidget {
  const CredentialsLoginScreen({super.key});
  static const String routeName = 'credentials-login';

  @override
  State<CredentialsLoginScreen> createState() => _CredentialsLoginScreenState();
}

class _CredentialsLoginScreenState extends State<CredentialsLoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bienvenido: ${userCredential.user?.email}')),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Credenciales invalidas')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return Container(
              color: Colors.white,
              child: const Text("Error")
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(top: -50,left: -130,child: LargeSphere(),),
            const Positioned(top: 400,right: -120,child: LargeSphere(),),
            const Positioned(bottom: 80,left: -150,child: LargeSphere(),),
            const Positioned(top: 90,left: -40,child: SmallSphere(),),
            const Positioned(top: 80,right: 40,child: SmallSphere(),),
            const Positioned(bottom: -50,right: -60,child: SmallSphere(),),
            SizedBox(
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(Icons.arrow_back, color: Colors.lightBlue.shade700, size: 30,),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        Center(
                          child: SizedBox(
                            width: size.width * .6,
                            height: size.height * .14,
                            child: const Placeholder(),
                          ),
                        ),
                        const SizedBox(height: 40,),
                        Text(
                          'Correo electrónico',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.lightBlue.shade700,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextField(
                          controller: _emailController,
                          style: const TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF8F8FF),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.lightBlue.shade700,
                                width: .5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: .5,
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: 'ejemplo@gmail.com',
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Text(
                          'Contraseña',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.lightBlue.shade700,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextField(
                          obscureText: true,
                          controller: _passwordController,
                          style: const TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF8F8FF),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.lightBlue.shade700,
                                width: .5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: .5,
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: '* * * * * * * *',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    width: size.width * .7,
                    child: ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        backgroundColor: Colors.lightBlue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 2,
                        shadowColor: Colors.black.withOpacity(0.3),
                      ),
                      child: const Text(
                        'Iniciar sesión',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
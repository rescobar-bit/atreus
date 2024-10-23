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
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Column(
                  children: [
                    const Text('Correo electrónicode'),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: _emailController,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.grey,
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
                    const Text('Contraseña'),
                    const SizedBox(height: 10,),
                    TextField(
                      obscureText: true,
                      controller: _passwordController,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.grey,
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
              ElevatedButton(
                onPressed: login,
                child: const Text('Iniciar sesión')
              )
            ],
          )
        ),
      ),
    );
  }
}
import 'package:atreus/screens/auth/microsoft_login_screen.dart';
import 'package:atreus/widgets/general/atreus_input.dart';
import 'package:atreus/widgets/ui/large_sphere.dart';
import 'package:atreus/widgets/ui/small_sphere.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = 'credentials-login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciales invalidas')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) _formKey.currentState?.fields['email']?.validate();
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) _formKey.currentState?.fields['password']?.validate();
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void submit() async {
    bool? isValidated = _formKey.currentState?.saveAndValidate();
    if (isValidated!) await login();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final inputBorderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: Colors.lightBlue.shade700,
        width: .5,
      ),
    );
    final inputBorderErrorStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: Colors.red.shade400,
        width: .5,
      ),
    );
    InputDecoration inputDecoration(String placeholder) {
      return InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF8F8FF),
        disabledBorder: inputBorderStyle,
        enabledBorder: inputBorderStyle,
        border: inputBorderStyle,
        focusedErrorBorder: inputBorderStyle,
        errorBorder: inputBorderErrorStyle,
        contentPadding: const EdgeInsets.only(left: 10),
        hintText: placeholder,
        hintStyle: TextStyle(color: Colors.lightBlue.shade200, fontWeight: FontWeight.w400)
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                const Positioned(top: -50,left: -130,child: LargeSphere(),),
                const Positioned(top: 280,right: -120,child: LargeSphere(),),
                const Positioned(bottom: 80,left: -150,child: LargeSphere(),),
                const Positioned(top: 90,left: -40,child: SmallSphere(),),
                const Positioned(top: 80,right: 40,child: SmallSphere(),),
                const Positioned(bottom: -50,right: -60,child: SmallSphere(),),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24,),
                      Center(
                        child: SizedBox(
                          width: size.width * .7,
                          height: size.height * .18,
                          child: const Placeholder(),
                        ),
                      ),
                      const SizedBox(height: 40,),
                      Text(
                        'Iniciar sesión',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w400,
                          color: Colors.lightBlue.shade700,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      FormBuilder(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Correo electrónico',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.lightBlue.shade700,
                              ),
                            ),
                            const SizedBox(height: 6,),
                            AtreusInput(
                              name: 'email',
                              controller: _emailController,
                              inputStyle: inputDecoration('myemail@mail.com'),
                              validators: FormBuilderValidators.compose([
                                FormBuilderValidators.required(errorText: 'Debes proporcionar un correo electrónico'),
                                FormBuilderValidators.maxLength(40, errorText: 'El nombre de usuario debe tener máximo 40 caracteres'),
                              ]),
                            ),
                            const SizedBox(height: 30,),
                            Text(
                              'Contraseña',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.lightBlue.shade700,
                              ),
                            ),
                            const SizedBox(height: 6,),
                            AtreusInput(
                              name: 'password',
                              controller: _passwordController,
                              inputStyle: inputDecoration('x x x x x x x x'),
                              validators: FormBuilderValidators.compose([
                                FormBuilderValidators.required(errorText: 'Debes proporcionar una contraseña'),
                                FormBuilderValidators.maxLength(40, errorText: 'La contraseña debe tener máximo 40 caracteres'),
                              ]),
                            ),
                          ],
                        )
                      ),
                      const SizedBox(height: 12,),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Olvide mi contraseña',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.lightBlue.shade700,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      const SizedBox(height: 40,),
                      SizedBox(
                        width: size.width,
                        child: ElevatedButton(
                          onPressed: submit,
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
                      const SizedBox(height: 20,),
                      Center(
                        child: Text('o', style: TextStyle(fontSize: 20, color: Colors.lightBlue.shade700),)
                      ),
                      const SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: () => context.goNamed(MicrosoftLoginScreen.routeName),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 2,
                          shadowColor: Colors.black.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.window_rounded,
                              size: 26,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
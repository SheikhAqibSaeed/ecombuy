import 'package:ecom_buy/screens/home_screen.dart';
import 'package:ecom_buy/screens/sigup_screen.dart';
import 'package:ecom_buy/services/firebase_servieces.dart';
import 'package:ecom_buy/utils/styles.dart';
import 'package:ecom_buy/widgets/button.dart';
import 'package:ecom_buy/widgets/text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool formLoading = false;

  Future<void> ecoDialogue(String error) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error),
            actions: [
              EcoButton(
                title: 'Close',
                onPress: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  // submit() async {
  //   if (formKey.currentState!.validate()) {
  //     if (passwordController.text == retypePasswordController.text) {
  //       try {
  //         User? user = await FirebaseAuthService().signUpWithEmailAndPassword(
  //           emailController.text,
  //           passwordController.text,
  //         );
  //         if (user != null) {
  //           // Registration successful
  //           // ignore: use_build_context_synchronously
  //           Navigator.push(context,
  //               MaterialPageRoute(builder: (_) => const LoginScreen()));
  //         } else {
  //           ecoDialogue('Registration failed. Please try again.');
  //         }
  //       } catch (e) {
  //         ecoDialogue('An error occurred during registration: $e');
  //       }
  //     } else {
  //       ecoDialogue('Passwords do not match.');
  //     }
  //   }
  // }

  submit() async {
    if (formKey.currentState!.validate()) {
      // return ecoDialogue('Password Matched');  // this method is used for just example
      setState(() {
        formLoading = true;
      });
      String? accountStatus = await FirebaseServices.signInAccount(
          emailController.text, passwordController.text);
      if (accountStatus != null) {
        ecoDialogue(accountStatus);
        setState(() {
          formLoading = false;
        });
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    }
  }

  @override
  void dispose() {
    // email.dispose();
    // passwordController.dispose();
    // retypePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Welcome \n Please Login First',
                textAlign: TextAlign.center,
                style: EcoStyle.boldStyle,
              ),
              Column(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        EcoTextField(
                          controller: emailController,
                          hintText: 'Enter Email!',
                          validate: (v) {
                            if (v!.isEmpty) {
                              return 'Email is required';
                            }
                            return null;
                          },
                        ),
                        EcoTextField(
                          controller: passwordController,
                          isPassword: true,
                          hintText: 'Password..',
                          validate: (v) {
                            if (v!.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                        EcoButton(
                          title: 'Login',
                          isLoginButton: true,
                          isLoading: formLoading,
                          onPress: () {
                            submit();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              EcoButton(
                title: 'Create New Account',
                isLoginButton: false,
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SignUpScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

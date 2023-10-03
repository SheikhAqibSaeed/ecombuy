import 'package:ecom_buy/services/firebase_servieces.dart';
import 'package:ecom_buy/utils/styles.dart';
import 'package:ecom_buy/widgets/button.dart';
import 'package:ecom_buy/widgets/text_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController retypePasswordController = TextEditingController();
  FocusNode? passwordFocus;
  FocusNode? retypepasswordFocus;
  final formKey = GlobalKey<FormState>();

  bool ispassword = true;
  bool isretypepassword = true;

  bool formLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    retypePasswordController.dispose();
    super.dispose();
  }

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
      if (passwordController.text == retypePasswordController.text) {
        // return ecoDialogue('Password Matched');  // this method is used for just example
        setState(() {
          formLoading = true;
        });
        // FirebaseServices.createAccount(
        //         emailController.text, passwordController.text)
        //     .then((value) => Navigator.push(
        //         context, MaterialPageRoute(builder: (_) => LoginScreen())));
        String? accountStatus = await FirebaseServices.createAccount(
            emailController.text, passwordController.text);
        if (accountStatus != null) {
          ecoDialogue(accountStatus);
          setState(() {
            formLoading = false;
          });
        } else {
          Navigator.pop(context);
        }
      }
    }
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
                'Welcome \n Please Create your Account',
                textAlign: TextAlign.center,
                style: EcoStyle.boldStyle,
              ),
              Column(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // EcoTextField(
                        //   hintText: 'Username',
                        // ),
                        EcoTextField(
                          // check: true,
                          validate: (v) {
                            if (v!.isEmpty ||
                                !v.contains('@') ||
                                !v.contains('.com')) {
                              return 'Please enter the correct email';
                            }
                            return null;
                          },
                          inputAction: TextInputAction.next,
                          isPassword: false,
                          controller: emailController,
                          hintText: 'Email address',
                          icon: Icon(Icons.email_outlined),
                        ),
                        EcoTextField(
                          validate: (v) {
                            if (v!.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                          inputAction: TextInputAction.next,
                          focusNode: passwordFocus,
                          controller: passwordController,
                          isPassword: ispassword,
                          hintText: 'Password..',
                          icon: IconButton(
                              onPressed: () {
                                setState(() {
                                  ispassword = !ispassword;
                                });
                              },
                              icon: ispassword
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                        ),
                        EcoTextField(
                          validate: (v) {
                            if (v!.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                          isPassword: isretypepassword,
                          controller: retypePasswordController,
                          hintText: 'Retype-Password..',
                          icon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isretypepassword = !isretypepassword;
                                });
                              },
                              icon: isretypepassword
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off)),
                        ),
                        EcoButton(
                          title: 'Sign-Up',
                          isLoginButton: true,
                          onPress: () {
                            submit();
                          },
                          isLoading: formLoading,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              EcoButton(
                title: 'Back to login',
                isLoginButton: false,
                onPress: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (_)=> LoginScreen()));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

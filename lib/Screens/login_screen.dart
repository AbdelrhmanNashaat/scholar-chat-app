import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/Component/custom__text_field.dart';
import 'package:scholar_chat/Component/button.dart';
import 'package:scholar_chat/Screens/sign_up.dart';
import 'package:scholar_chat/Widgets/constants.dart';
import 'package:scholar_chat/cubit/login_cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Helper/show_snackbar.dart';
import '../cubit/chat_cubit/chat_cubit.dart';
import 'chat_page.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  static String id = 'log in';
  bool isHidden = true;

  bool isLoading = false;
  String? email;
  String? password;

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          isLoading = false;
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
        } else if (state is LoginFailure) {
          ShowSnackBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 110,
                  ),
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Scholar Chat',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Pacifico'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontFamily: 'Pacifico'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomFormTextFieldWidget(
                    icon: const Icon(
                      Icons.email,
                      color: Colors.white,
                      size: 24,
                    ),
                    hint: 'Email',
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormTextFieldWidget(
                    icon: const Icon(
                      Icons.visibility_off,
                      color: Colors.white,
                      size: 24,
                    ),
                    obscureText: true,
                    hint: 'Password',
                    onChanged: (data) {
                      password = data;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Button(
                    text: 'Log in',
                    onTab: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context)
                            .loginUser(email: email!, password: password!);
                      } else {}
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'don\'t have an account?',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, SignUp.id);
                        },
                        child: const Text(
                          ' Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffC7EDE6),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:scholar_chat/Component/button.dart';
import 'package:scholar_chat/Component/custom__text_field.dart';
import 'package:scholar_chat/Screens/chat_page.dart';
import 'package:scholar_chat/Screens/login_screen.dart';
import 'package:scholar_chat/Widgets/constants.dart';

import '../Helper/show_snackbar.dart';
import '../cubit/chat_cubit/chat_cubit.dart';
import '../cubit/sign_up_cubit/sign_up_cubit.dart';

bool isLoading = false;
bool passwordVisible = true;

class SignUp extends StatelessWidget {
  static String id = 'Sign Up';
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  SignUp({
    Key? key,
    this.email,
    this.password,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          isLoading = true;
        } else if (state is SignUpSuccess) {
          isLoading = false;
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
        } else if (state is SignUpFailure) {
          ShowSnackBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                    const Row(
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontFamily: 'Pacifico'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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
                      text: 'Register',
                      onTab: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<SignUpCubit>(context).registerUser(
                            email: email!,
                            password: password!,
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'already have an account?',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, LoginScreen.id,
                                arguments: email);
                          },
                          child: const Text(
                            ' Sign In',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffC7EDE6),
                            ),
                          ),
                        ),
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
        );
      },
    );
  }

  Future<void> registerUser() async {
    final UserCredential credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}

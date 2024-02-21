import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/Screens/chat_page.dart';
import 'package:scholar_chat/cubit/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/cubit/login_cubit/login_cubit.dart';
import 'Screens/login_screen.dart';
import 'Screens/sign_up.dart';
import 'cubit/sign_up_cubit/sign_up_cubit.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<SignUpCubit>(
          create: (context) => SignUpCubit(),
        ),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignUp.id: (context) => SignUp(
              ),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: LoginScreen.id,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

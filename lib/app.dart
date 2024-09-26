import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodfixer/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:foodfixer/features/auth/presentation/ui/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneAuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return HomePage();
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: ElevatedButton(
            onPressed: () {
              print('object');
              context.read<PhoneAuthCubit>().signOut();
              // showDialog(
              //   context: context,
              //   builder: (context) => const CustomDialog(
              //     title: 'Testing',
              //     description:
              //         'Something Went Wrong ! Please try again later',
              //     image: Icons.warning,
              //     buttonText: 'Okay',
              //   ),
              // );
            },
            child: const Text('Press Me')),
      ),
    );
  }
}

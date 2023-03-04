import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_bloc/cubits/cubit/cubit/signup_cubit.dart';
import 'package:phone_bloc/repository/repository.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SignupScreen());
  }

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
      ),
      body: Padding(padding: EdgeInsets.all(20.0),
      child: BlocProvider<SignupCubit>(
        create: (_) => SignupCubit(context.read<AuthRepository>()),
       child:const SignupForm()
       ),
      
    ));
  }
}
class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state.status == SignupStatus.error) ;
        // TODO: implement listener
      },
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _emailInput(),
        const SizedBox(height: 8),
         _passwordInput(),
        const SizedBox(height: 8),
         _SignupButton(),
        const SizedBox(height: 8),
      ],
    )
    );
  }
}
class _emailInput extends StatelessWidget {
  const _emailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            context.read<SignupCubit>().emailChanged(email);
          },
          decoration: InputDecoration(labelText: 'Email'),
        );
      },
    );
  }
}
class _passwordInput extends StatelessWidget {
  const _passwordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<SignupCubit>().passwordChanged(password);
          },
          decoration: InputDecoration(labelText: 'Password'),
        );
      },
    );
  }
}
class _SignupButton extends StatelessWidget {
  const _SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status ==SignupStatus.submitting
            ? CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(200, 40),
                ),
                onPressed: () {
                  context.read<SignupCubit>().signupFromSubmitted();
                },
                child: Text('Sign Up'),
              );
      },
    );
  }
}
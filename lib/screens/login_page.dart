// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:school_flutter/components/custom_button.dart';

import '../components/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //methods
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              //logo
              Image.asset(
                'lib/images/logo.png',
                height: 150,
              ),
              // Icon(
              //   Icons.lock,
              //   size: 100,
              // ),
              SizedBox(height: 50),
              //welcome text
              Text(
                'Добро пожаловать!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 25),
              //username field
              CustomTextField(
                controller: usernameController,
                hintText: 'Логин',
                obscureText: false,
              ),
              SizedBox(height: 25),
              CustomTextField(
                controller: passwordController,
                hintText: 'Пароль',
                obscureText: true,
              ),
              SizedBox(height: 15),
              //забыл пароль
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Забыли пароль?',
                      style: TextStyle(color: Colors.white54),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50),
              //button
              CustomButton(
                onTap: signUserIn,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_web_libraries_in_flutter, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:school_flutter/components/custom_button.dart';
import 'package:school_flutter/screens/schedule_list.dart';
import 'package:school_flutter/screens/todo_list.dart';
import 'package:school_flutter/services/auth_service.dart';
import '../components/custom_textfield.dart';
import '../models/user.dart';
import '../utils/snackbar_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<UserModel> user = [];
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Widget _buildImageBoxes() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Image.network("https://picsum.photos/500/500/?random"),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text("Text"),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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

//methods
  Future<void> signUserIn() async {
    final response = await AuthService.checkUser(body);
    var roles = [1, 2, 5, 6, 7];

    if (response != null) {
      if (roles.contains(response.roleId)) {
        navigateToAdminsPage(response);
      } else {
        navigateToUsersPage(response);
      }

      print(response.firstName);
    } else {
      showErrorMessage(context, message: 'Пользователь не найден');
    }
  }

  Future<void> navigateToUsersPage(UserModel user) async {
    final route = MaterialPageRoute(
      builder: (context) => ScheduleListPage(user: user),
    );
    await Navigator.push(context, route);
  }

  Future<void> navigateToAdminsPage(UserModel user) async {
    final route = MaterialPageRoute(
      builder: (context) => TodoListPage(user: user),
    );
    await Navigator.push(context, route);
  }

  Map get body {
    final login = usernameController.text;
    final password = passwordController.text;
    return {"login": login, "password": password};
  }
}

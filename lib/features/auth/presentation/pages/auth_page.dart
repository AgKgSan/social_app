/*
Auth Page - This page determine whether to show the login or register page
*/


import 'package:flutter/material.dart';
import 'package:social_app/features/auth/presentation/pages/login_page.dart';
import 'package:social_app/features/auth/presentation/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //initially , show login page
  bool showLoginPage = true;

  //toggle between pages
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(tooglePages: togglePages);
    }else{
      return RegisterPage(tooglePages: togglePages,);
    }
  }
}
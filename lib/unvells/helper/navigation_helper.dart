import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/login_signup/bloc/signin_signup_screen_bloc.dart';
import '../screens/login_signup/bloc/signin_signup_screen_repository.dart';
import '../screens/login_signup/view/create_account_screen.dart';
import '../screens/login_signup/view/signin_screen.dart';

class NavigationHelper {
  static navigateToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthBloc(
                repository: SigninSignupScreenRepositoryImp()),
            child: SignInScreen(false),
          ),
        ),
      );

  static navigateToRegister(BuildContext context,
          {required bool isComingFromCartPage}) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthBloc(
                repository: SigninSignupScreenRepositoryImp()),
            child: CreateAnAccount(isComingFromCartPage),
          ),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fudo_challenge/app/presentation/app_theme.dart';

import '../../../core/config/shared_preferences/app_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final appPreferences = AppPreferences();
    final isAuthenticated = appPreferences.isAuthenticated;
    await Future.delayed(Duration(seconds: 2));
    if (isAuthenticated) {
      Navigator.of(context).pushReplacementNamed('/posts');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorPrimary.primaryColor,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SvgPicture.asset(
            'assets/logo/fudo_white.svg',
            //height: 150,
            width: 200,
          ),
        ),
      ),
    );
  }
}

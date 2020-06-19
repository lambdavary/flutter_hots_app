import 'package:flutter/material.dart';
import 'package:heroesofthestormapp/pages/HeroDetail.dart';
import 'package:heroesofthestormapp/pages/HeroesList.dart';
import 'package:heroesofthestormapp/pages/SplashScreen.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/SplashScreen',
  routes: {
    '/HeroesList' : (context) => HeroesList(),
    '/SplashScreen' : (context) => SplashScreen(),
    '/HeroDetail' : (context) => HeroDetail()
  },
));
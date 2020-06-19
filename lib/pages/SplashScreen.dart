import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heroesofthestormapp/models/Hero.dart';
import 'package:http/http.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  void getHeroes() async{
    List<HeroItem> heroes = List();

    Response response = await get('https://hotsapi.net/api/v1/heroes');
    List<dynamic> list = jsonDecode(response.body);

    for(int i = 0; i<list.length; i++){
      HeroItem heroItem = HeroItem(name: list.elementAt(i)['name'].toString()
          , role: list.elementAt(i)['role'].toString()
          , type: list.elementAt(i)['type'].toString()
          , icon_url: list.elementAt(i)['icon_url'].toString());
      heroes.add(heroItem);
    }

    Navigator.pushReplacementNamed(context, '/HeroesList', arguments: {
      'listOfHeroes' : heroes
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHeroes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[800],
      child: SpinKitFoldingCube(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }
}

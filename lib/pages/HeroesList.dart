import 'package:flutter/material.dart';
import 'package:heroesofthestormapp/models/Hero.dart';

class HeroesList extends StatefulWidget {
  @override
  _HeroesListState createState() => _HeroesListState();
}

class _HeroesListState extends State<HeroesList> {
  Map heroes= {};

  @override
  Widget build(BuildContext context) {
    heroes = ModalRoute.of(context).settings.arguments;
    List<HeroItem> listOfHeroes = heroes['listOfHeroes'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Heroes of the Storm Heroes'
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('${listOfHeroes.elementAt(index).icon_url.substring(8, listOfHeroes.elementAt(index).icon_url.length-1)}'),
              ),
              onTap: (){},
              title: Text(
                listOfHeroes.elementAt(index).name
              ),
            ),
          );
        },
        itemCount: listOfHeroes.length,
      ),
    );
  }
}

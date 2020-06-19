import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroesofthestormapp/models/Hero.dart';
import 'package:heroesofthestormapp/models/HeroAbility.dart';
import 'package:heroesofthestormapp/models/HeroProperty.dart';
import 'package:http/http.dart';

class HeroDetail extends StatefulWidget {
  @override
  _HeroDetailState createState() => _HeroDetailState();
}

class _HeroDetailState extends State<HeroDetail> {
  HeroProperty heroProperty;

  String heroUrl() {
    String url = "https://hotsapi.net/api/v1/heroes/";
    Map data = ModalRoute.of(context).settings.arguments;
    String name = data['heroName'];
    url += name;
    print('url:' + url);
    return url;
  }

  void setData() async {
    String url = heroUrl();
    Response response = await get(url);
    Map data = jsonDecode(response.body);

    String name = data['name'].toString();
    String role = data['role'].toString();
    String type = data['type'].toString();
    String icon_url = data['icon_url'].toString();

    HeroItem heroItem =
        HeroItem(name: name, role: role, type: type, icon_url: icon_url);

    print('hero detail:' + heroItem.name);

    List<dynamic> list = data['abilities'];
    List<HeroAbility> abilities = List();

    for (int i = 0; i < list.length; i++) {
      String name = list.elementAt(i)['name'].toString();
      String title = list.elementAt(i)['title'].toString();
      String description = list.elementAt(i)['description'].toString();
      int cooldown = 0;
      if (list.elementAt(i)['cooldown'] != null) {
        cooldown = int.parse(list.elementAt(i)['cooldown'].toString());
      }
      int mana_cost = 0;
      if (list.elementAt(i)['mana_cost'] != null) {
        mana_cost = int.parse(list.elementAt(i)['mana_cost'].toString());
      }
      print(name);
      print(title);
      print(description);
      print(cooldown);
      print(mana_cost);
      HeroAbility heroAbility = HeroAbility(
          name: name,
          title: title,
          description: description,
          cooldown: cooldown,
          mana_cost: mana_cost);
      abilities.add(heroAbility);
    }

    heroProperty = HeroProperty(heroItem: heroItem, heroAbility: abilities);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      this.setData();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (heroProperty == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...'),
          centerTitle: true,
          backgroundColor: Colors.blue[800],
        ),
      );
    }
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(heroProperty.heroItem.name),
          centerTitle: true,
          backgroundColor: Colors.blue[800],
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(heroProperty.heroItem.icon_url
                      .substring(8, heroProperty.heroItem.icon_url.length - 1)),
                  radius: 50.0,
                ),
              ),
              Divider(
                height: 50.0,
                color: Colors.blue[900],
                thickness: 1.0,
              ),
              Text(
                'Role: ${heroProperty.heroItem.role}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Type: ${heroProperty.heroItem.type}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  scrollDirection: Axis.vertical,
                  itemCount: heroProperty.heroAbility.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.grey[200],
                      margin:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 1.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ability: ${heroProperty.heroAbility.elementAt(index).name}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            'Name: ${heroProperty.heroAbility.elementAt(index).title}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            'Description: ${heroProperty.heroAbility.elementAt(index).description}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            'Cooldown: ${heroProperty.heroAbility.elementAt(index).cooldown}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            'Mana cost: ${heroProperty.heroAbility.elementAt(index).mana_cost}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}

import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mycloud/history_point.dart';

import '../main.dart';

const kColormain = Color.fromARGB(255, 16, 47, 138);
const kColorSecond = Color.fromARGB(255, 158, 189, 255);
const kButtonColor = Color.fromARGB(255, 52, 81, 156);

class HomePage extends StatefulWidget {
  HomePage(User user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //HomePage(this.user);
  //final User user;
  int _currentIndex = 0;
  final _pageWidgets = [
    mainPage(),
    HistoryPoint(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 3, //太さ
              color: kColormain, //色
            ),
          ),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: 'History',
            ),
          ],
          currentIndex: _currentIndex,
          //currentIndex: _selectedIndex,
          selectedItemColor: kColormain,
          onTap: onItemTapped,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 254, 245),
      appBar: AppBar(
          shape: Border(bottom: BorderSide(color: kColormain, width: 3)),
          title: Text('あいぽい', style: TextStyle(color: kColormain)),
          backgroundColor: Colors.white),
      body: _pageWidgets[_currentIndex],
    );
  }

  void onItemTapped(int index) => setState(() => _currentIndex = index);
}

class mainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //SizedBox(height: 20),
        // Padding(padding: EdgeInsets.symmetric(horizontal: 200)),
        myAccount(
          user: '太島実穂',
          email: 'i211322@gm.ishikawa-nct.ac.jp',
          height: 200,
          point: 100,
        ),
        exchange(height: 300),
      ],
    );
  }
}

class myAccount extends StatelessWidget {
  final String user;
  final String email;
  final double height;
  final int point;

  const myAccount({
    Key? key,
    required this.user,
    required this.email,
    required this.height,
    required this.point,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(25),
        height: height,
        //padding: EdgeInsets.all(50),
        decoration: BoxDecoration(
          border: Border.all(color: kColormain, width: 4),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              height: height * 0.25,
              decoration: BoxDecoration(
                color: kColormain,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Padding(padding: EdgeInsets.symmetric(horizontal: 400)),
                      Text(user, style: TextStyle(color: Colors.white)),
                      Text(email, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '現在のポイント数は...',
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          '${point}',
                          style: TextStyle(fontSize: 65),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'ポイントです！',
                        ),
                      )
                    ]),
              ),
            ),
          ],
        ));
  }
}

class exchange extends StatelessWidget {
  final double height;

  const exchange({
    Key? key,
    required this.height,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(21),
        height: height,
        //padding: EdgeInsets.all(50),
        decoration: BoxDecoration(
          border: Border.all(color: kColormain, width: 4),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              height: height * 0.25,
              decoration: BoxDecoration(
                color: kColormain,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Padding(padding: EdgeInsets.symmetric(horizontal: 400)),
                  Text('アイス券', style: TextStyle(color: Colors.white)),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 30,
                          child: Image.asset('images/ICE_CARD2.png'),
                        ),
                        Text('  ×1', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kColorSecond,
                                ),
                                height: 80,
                                width: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '100',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    Text(
                                      'p',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.asset('images/100p.png'),
                            ),
                            Text('>>'),
                            SizedBox(
                              width: 123,
                              height: 90,
                              child: Image.asset('images/ICE_CARD1.png'),
                            ),
                          ]),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: kButtonColor,
                          padding: EdgeInsets.symmetric(horizontal: 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: () {},
                        child: Text('交換する！',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ]),
              ),
            ),
          ],
        ));
  }
}

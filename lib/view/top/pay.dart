import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycloud/config/styles.dart';
import 'package:mycloud/models/point.dart';
import 'package:mycloud/provider/login_provider.dart';
import 'package:mycloud/service/providers_provider.dart';
import 'package:mycloud/service/will_pop_callback.dart';

/*final userInputProvider = StateProvider<String>((ref) {
  return '';
});*/

class PayPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //String userInput = ref.watch(userInputProvider);
    Point point = ref.watch(pointProvider).point;

    final Size size = MediaQuery.of(context).size;
    double shortestSide = size.shortestSide;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/Icon.png'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              pointTile('現在の\nポイント ', point.point.toString(), shortestSide,
                  isWhite: true),
              pointTile(
                  '消費後の\nポイント ', (point.point - 100).toString(), shortestSide,
                  isWhite: true),
              pointTile('　消費 ', '100', shortestSide),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Styles.primaryColor),
                        ),
                        child: const Text(
                          'ポイントを使う',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          pay(context, ref);
                          Navigator.of(context).pushNamed('/top');
                        }),
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  Widget pointTile(String description, String point, double shortestSide,
      {bool isWhite = false}) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isWhite
                          ? Styles.secondaryColor900
                          : Styles.secondaryColor,
                    )),
                Container(
                    height: 60, width: 1.5, color: Styles.secondaryColor900),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(point,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: isWhite
                          ? Styles.secondaryColor900
                          : Styles.secondaryColor,
                    )),
                Text('pt',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isWhite
                          ? Styles.secondaryColor900
                          : Styles.secondaryColor,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future pay(BuildContext context, WidgetRef ref) async {
    var rand = math.Random();
    //String userInput = ref.watch(userInputProvider);
    Point point = ref.watch(pointProvider).point;
    final user = ref.watch(loginProvider);
    int updatePoint = point.point - 100;
    int updateUsedPoint = point.usedPoint + 100;
    ref.read(pointProvider.notifier).updatePoint(
          point.copyWith(point: updatePoint, usedPoint: updateUsedPoint),
        );

    final date = DateTime.now().toLocal().toIso8601String();
    await FirebaseFirestore.instance.collection('posts').doc().set({
      'point_of_change': 100,
      'transaction': 'pay',
      'way': 'ice',
      'current_point': updatePoint,
      'email': user.email,
      'date': date
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .update({
      'point': updatePoint,
      'used_point': updateUsedPoint,
      'date': DateTime.now().toLocal().toIso8601String(),
    });
    //await Navigator.of(context).pushNamed('/top');
  }
}

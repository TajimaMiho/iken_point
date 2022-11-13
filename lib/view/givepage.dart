import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycloud/config/styles.dart';
import 'package:mycloud/models/point.dart';
import 'package:mycloud/provider/login_provider.dart';
import 'package:mycloud/service/providers_provider.dart';
import 'package:mycloud/service/will_pop_callback.dart';

final DetailInputProvider = StateProvider<String>((ref) {
  return '';
});
final numberInputProvider = StateProvider<String>((ref) {
  return '';
});
final EmailInputProvider = StateProvider<String>((ref) {
  return '';
});

class GivePoint extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String userInput = ref.watch(DetailInputProvider);
    Point point = ref.watch(pointProvider).point;

    final Size size = MediaQuery.of(context).size;
    double shortestSide = size.shortestSide;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "おくる",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'メールアドレス'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onChanged: (String value) {
                  // Providerから値を更新
                  ref.read(EmailInputProvider.notifier).state = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '詳細'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onChanged: (String value) {
                  // Providerから値を更新
                  ref.read(DetailInputProvider.notifier).state = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '付与ポイント'),
                keyboardType: TextInputType.number,
                maxLines: 3,
                onChanged: (String value) {
                  // Providerから値を更新
                  ref.read(numberInputProvider.notifier).state = value;
                },
              ),
              //pointTile('　消費 ', '100', shortestSide),
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
                          'ポイントを贈る',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          pay(context, ref);
                        }),
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  /* Widget pointTile(String description, String point, double shortestSide,
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
  }*/

  Future pay(BuildContext context, WidgetRef ref) async {
    var rand = math.Random();
    String userInput = ref.watch(DetailInputProvider);
    String numberInput = ref.watch(numberInputProvider);
    String EmailInput = ref.watch(EmailInputProvider);
    Point point = ref.watch(pointProvider).point;
    final user = ref.watch(loginProvider);
    if (numberInput.isEmpty ||
        int.parse(userInput) <= 0 ||
        point.point < int.parse(userInput)) {
      return null;
    }
    int updatePoint = point.point + int.parse(numberInput);
    //int updateUsedPoint = point.usedPoint + int.parse(numberInput);
    ref.read(pointProvider.notifier).updatePoint(
          point.copyWith(point: updatePoint, usedPoint: 0),
        );

    final date = DateTime.now().toLocal().toIso8601String();
    await FirebaseFirestore.instance.collection('posts').doc().set({
      'point_of_change': numberInput,
      'transaction': '',
      'way': userInput,
      'current_point': updatePoint,
      'email': EmailInput,
      'date': date
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .update({
      'point': updatePoint,
      'used_point': 0,
      'date': DateTime.now().toLocal().toIso8601String(),
    });
  }
}

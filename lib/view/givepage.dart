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
          shape:
              Border(bottom: BorderSide(color: Styles.primaryColor, width: 3)),
          title: Container(
            width: 150,
            height: 30,
            child: Image.asset(
              'images/Icon.png',
              fit: BoxFit.contain,
            ),
          ),
          backgroundColor: Colors.white),
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
                          gift(context, ref);
                        }),
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  Future gift(BuildContext context, WidgetRef ref) async {
    var rand = math.Random();
    String DetailInput = ref.watch(DetailInputProvider);
    String numberInput = ref.watch(numberInputProvider);
    String EmailInput = ref.watch(EmailInputProvider);
    Point point = ref.watch(pointProvider).point;
    final user = ref.watch(loginProvider);
    /*if (numberInput.isEmpty ||
        int.parse(numberInput) <= 0 ||
        point.point < int.parse(numberInput)) {
      return null;
    }*/
    int updatePoint = point.point + int.parse(numberInput);
    //int updateUsedPoint = point.usedPoint + int.parse(numberInput);
    ref.read(pointProvider.notifier).updatePoint(
          point.copyWith(point: updatePoint, usedPoint: 0),
        );

    final date = DateTime.now().toLocal().toIso8601String();
    await FirebaseFirestore.instance.collection('posts').doc().set({
      'point_of_change': numberInput,
      'transaction': '',
      'way': DetailInput,
      'current_point': updatePoint,
      'email': EmailInput,
      'date': date
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .update({
      'point': updatePoint,
      'date': DateTime.now().toLocal().toIso8601String(),
    });

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("ポイントを贈る"),
          content: Text("宛先：" + EmailInput + "\n付与ポイント：" + numberInput),
          actions: <Widget>[
            // ボタン領域
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
    await Navigator.of(context).pushNamed('/payed_page');
  }
}

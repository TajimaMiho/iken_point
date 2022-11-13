import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycloud/config/styles.dart';
import 'package:mycloud/models/point.dart';
import 'package:mycloud/provider/login_provider.dart';
import 'package:mycloud/service/providers_provider.dart';
import 'package:mycloud/service/will_pop_callback.dart';
import 'package:mycloud/view/top/top_page.dart';

final userInputProvider = StateProvider<String>((ref) {
  return '';
});

class AddPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Point point = ref.watch(pointProvider).point;
    final Size size = MediaQuery.of(context).size;
    double shortestSide = size.shortestSide;
    double iconSize = shortestSide / 7.5;

    return WillPopScope(
      //前のページに戻らせたくない時に使う
      onWillPop: willPopCallback,
      child: Scaffold(
        appBar: AppBar(
            shape: Border(
                bottom: BorderSide(color: Styles.primaryColor, width: 3)),
            title: Text('あいぽい',
                style: TextStyle(
                  color: Styles.primaryColor,
                )),
            backgroundColor: Colors.white),
        body: Container(
          color: Styles.pageBackground,
          child: ListView(
            children: [
              SizedBox(height: shortestSide / 20),
              //buildNewsBand(shortestSide),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        //alignment: Alignment.topRight,
                        child: buildNameBand(shortestSide, point),
                      ),
                    ],
                  ),
                  buildPointBand(shortestSide, point),
                  SizedBox(
                    height: shortestSide / 15,
                  ),
                  buildExchangeUpBand(shortestSide, point),
                  buildExchangeDownBand(shortestSide, point, context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNameBand(double shortestSide, Point point) {
    return Container(
      decoration: const BoxDecoration(
        color: Styles.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      width: shortestSide / 1.1,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'ウィークリー',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: shortestSide / titleSize,
                color: Styles.secondaryTextColor,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Week1',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: shortestSide / titleSize,
                color: Styles.secondaryTextColor,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildPointBand(double shortestSide, Point point) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 6,
          color: Styles.primaryColor,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      width: shortestSide / 1.1,
      height: shortestSide / 3.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'お題は',
                  style: TextStyle(
                      fontSize: shortestSide / 30,
                      color: Styles.commonTextColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  '「アクションゲーム」',
                  style: TextStyle(
                      fontSize: shortestSide / 12,
                      fontWeight: FontWeight.bold,
                      color: Styles.commonTextColor),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo[800],
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () {},
                child: Text('応募する！', style: TextStyle(color: Colors.white)),
              ),
            ]),
      ),
    );
  }

  Widget buildExchangeUpBand(double shortestSide, Point point) {
    return Container(
      decoration: const BoxDecoration(
        color: Styles.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      width: shortestSide / 1.1,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'あいけんコンテスト',
            style: TextStyle(
                fontSize: shortestSide / titleSize,
                color: Styles.secondaryTextColor,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Season1',
            style: TextStyle(
                fontSize: shortestSide / titleSize,
                color: Styles.secondaryTextColor,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildExchangeDownBand(double shortestSide, Point point, context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 6,
          color: Styles.primaryColor,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      width: shortestSide / 1.1,
      height: shortestSide / 2.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        /*child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('-結果-')]),*/
      ),
    );
  }

  Widget buildNewsBand(double shortestSide) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        width: shortestSide,
        height: 70,
        color: Styles.primaryColor700,
        child: Center(
          child: Text('ウィークリーは11/5~11/12です。',
              style: TextStyle(
                  fontSize: shortestSide / 25,
                  color: Styles.commonTextColor,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

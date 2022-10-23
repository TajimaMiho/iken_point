import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycloud/config/styles.dart';
import 'package:mycloud/models/point.dart';
import 'package:mycloud/service/providers_provider.dart';
import 'package:mycloud/service/will_pop_callback.dart';

class TopPage extends ConsumerWidget {
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
            title: Text('あいぽい', style: TextStyle(color: Styles.primaryColor)),
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
                  buildExchangeDownBand(shortestSide, point),
                  /*Row(
                    children: [
                      ThumbnailImage(
                        shortestSide * 0.5,
                        shortestSide * 0.5,
                        Assets.images.common.dish.path,
                      ),
                      Column(
                        children: [
                          ThumbnailImage(
                            shortestSide * 0.5,
                            shortestSide * 0.5 / 3,
                            Assets.images.common.orihimeBus.path,
                          ),
                          ThumbnailImage(
                            shortestSide * 0.5,
                            shortestSide / 3,
                            Assets.images.common.roadsideStation.path,
                          )
                        ],
                      )
                    ],
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*Widget buildQRAndPointIcons(double iconSize, BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, right: 13),
            child: Column(
              children: [
                GestureDetector(
                  child: SvgPicture.asset(
                    Assets.images.common.icon.qrIc,
                    width: iconSize,
                    height: iconSize,
                    color: Styles.secondaryColor,
                  ),
                  onTap: () async {
                    await Navigator.of(context).pushNamed('/qr');
                  },
                ),
                const Text(
                  '二次元コード\nスキャン',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 25, left: 13),
          //   child:
          //   Column(
          //     children: [
          //       SvgPicture.asset(
          //         Assets.images.common.icon.pointSend,
          //         width: iconSize,
          //         height: iconSize,
          //         color: Styles.secondaryColor,
          //       ),
          //       const Text(
          //         'ポイント\n送受信',
          //         style: TextStyle(fontWeight: FontWeight.bold),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }*/

  /*Widget buildNewsBand(double shortestSide) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        width: shortestSide,
        height: 70,
        color: Styles.primaryColor700,
        child: Center(
          child: Text('【中能登町】実証実験は8/2〜8/19です。',
              style: TextStyle(
                  fontSize: shortestSide / 25,
                  color: Styles.commonTextColor,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }*/

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
      child: Text(
        point.name,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: shortestSide / 19,
            color: Styles.secondaryTextColor,
            fontWeight: FontWeight.bold),
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
                  '現在のポイント数は...',
                  style: TextStyle(
                      fontSize: shortestSide / 30,
                      color: Styles.commonTextColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  point.point.toString(),
                  style: TextStyle(
                      fontSize: shortestSide / 12,
                      fontWeight: FontWeight.bold,
                      color: Styles.commonTextColor),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  'ポイントです！',
                  style: TextStyle(
                      fontSize: shortestSide / 30,
                      fontWeight: FontWeight.bold,
                      color: Styles.commonTextColor),
                ),
              )
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
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Padding(padding: EdgeInsets.symmetric(horizontal: 400)),
          Text(
            'アイス券',
            style: TextStyle(
                fontSize: shortestSide / 19,
                color: Styles.secondaryTextColor,
                fontWeight: FontWeight.bold),
          ),
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 30,
                  child: Image.asset('images/ICE_CARD2.png'),
                ),
                Text(
                  '  ×1',
                  style: TextStyle(
                      fontSize: shortestSide / 19,
                      color: Styles.secondaryTextColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      /*child: Text(
        point.name,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: shortestSide / 19,
            color: Styles.secondaryTextColor,
            fontWeight: FontWeight.bold),
      ),*/
    );
  }

  Widget buildExchangeDownBand(double shortestSide, Point point) {
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
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset('images/100p.png'),
                ),
                Text(
                  '>>',
                  style: TextStyle(
                      fontSize: shortestSide / 19,
                      color: Styles.commonTextColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 123,
                  height: 90,
                  child: Image.asset('images/ICE_CARD1.png'),
                ),
              ]),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo[800],
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () {},
                child: Text('交換する！', style: TextStyle(color: Colors.white)),
              ),
            ]
            /*children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '現在のポイント数は...',
                  style: TextStyle(
                      fontSize: shortestSide / 30,
                      color: Styles.commonTextColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  point.point.toString(),
                  style: TextStyle(
                      fontSize: shortestSide / 12,
                      fontWeight: FontWeight.bold,
                      color: Styles.commonTextColor),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  'ポイントです！',
                  style: TextStyle(
                      fontSize: shortestSide / 30,
                      fontWeight: FontWeight.bold,
                      color: Styles.commonTextColor),
                ),
              )
            ]),*/
            ),
      ),
    );
  }
}

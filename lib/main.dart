import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import 'ad_manager.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatefulWidget {
  @override
  _XylophoneAppState createState() => _XylophoneAppState();
}

class _XylophoneAppState extends State<XylophoneApp> {
  BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.fullBanner,
    );
    _loadBannerAd();
  }

  @override
  void dispose() {
    // COMPLETE: Dispose BannerAd object
    _bannerAd?.dispose();
    super.dispose();
  }

  void _loadBannerAd() {
    _bannerAd
      ..load()
      ..show(anchorType: AnchorType.bottom);
  }

  void playSound(int i) {
    final player = AudioCache();
    player.play('note$i.wav');
  }

  Widget buildWidgetKey({MaterialColor colors, int note}) {
    return Expanded(
      child: FlatButton(
        child: null,
        color: colors,
        hoverColor: Colors.grey,
        onPressed: () {
          playSound(note);
          Wakelock.enable();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _initAdMob() {
      return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder<void>(
            future: _initAdMob(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              List<Widget> children = <Widget>[
                Expanded(
                  child: Container(
                    child: Center(
                      child: WavyAnimatedTextKit(
                        textStyle: TextStyle(
                            fontSize: 32.0, fontWeight: FontWeight.bold),
                        text: [
                          "Xylophone",
                          "Xylophone",
                        ],
                        isRepeatingAnimation: true,
                      ),
                    ),
                  ),
                ),
                buildWidgetKey(colors: Colors.purple, note: 1),
                buildWidgetKey(colors: Colors.blue, note: 2),
                buildWidgetKey(colors: Colors.green, note: 3),
                buildWidgetKey(colors: Colors.lightGreen, note: 4),
                buildWidgetKey(colors: Colors.yellow, note: 5),
                buildWidgetKey(colors: Colors.orange, note: 6),
                buildWidgetKey(colors: Colors.red, note: 7),
                Expanded(
                  child: Container(),
                ),
              ];
              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: children,
                ),
              );
            }),
      ),
    );
  }
}

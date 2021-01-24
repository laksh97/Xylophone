import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "YOUR_APP_ID";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "YOURz_AD_ID";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}

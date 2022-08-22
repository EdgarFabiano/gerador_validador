import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:gerador_validador/defaults/defaults_export.dart';

class AdMobService {
  static final String testAppId = 'ca-app-pub-3940256099942544~3347511713';

  static final String interstitialTestAdUnitId =
      'ca-app-pub-3940256099942544/1033173712';

  static final String appId = 'ca-app-pub-5932227223136302~5091687492';

  static String getAppId() {
    if (!Constants.isTesting) {
      return appId;
    }
    return testAppId;
  }

  static List<String> testDevices() {
    return [
      '4B0FDC40963AB3E77AED679FF240F802',
      '118F4E581E0D5DAA4F78D3B1A29E861C'
    ];
  }

  static double bannerPadding(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    if (height <= 400) {
      return 32;
    } else if (height >= 720) {
      return 90;
    }
    return 50;
  }

  /*banner*/
  static final String bannerId = 'ca-app-pub-5932227223136302/1970700133';

  static BannerAd _banner;

  static BannerAd startBanner() {
    if (_banner == null) {
      _banner = BannerAd(
        adUnitId: bannerId,
        size: AdSize.smartBanner,
        targetingInfo: MobileAdTargetingInfo(testDevices: testDevices()),
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            _banner?.show();
          }
          if (event == MobileAdEvent.clicked ||
              event == MobileAdEvent.closed ||
              event == MobileAdEvent.impression ||
              event == MobileAdEvent.leftApplication) {
            _banner?.load();
          }
        },
      );
    }
    return _banner;
  }

  static void displayBanner() {
    _banner
      ..load()
      ..show(
        anchorOffset: 0.0,
        anchorType: AnchorType.bottom,
      );
  }

  /*sorteio-interstitial*/
  static final String interstitialId = 'ca-app-pub-5932227223136302/8160418559';

  static InterstitialAd _interstitial;

  static InterstitialAd get interstitial => _interstitial;

  static InterstitialAd buildInterstitial() {
    _interstitial = InterstitialAd(
        adUnitId: interstitialId,
        targetingInfo: MobileAdTargetingInfo(testDevices: testDevices()),
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            _interstitial?.show();
          }
          if (event == MobileAdEvent.clicked ||
              event == MobileAdEvent.closed ||
              event == MobileAdEvent.impression ||
              event == MobileAdEvent.leftApplication) {
            _interstitial?.dispose();
            _interstitial = null;
          }
        });
    return _interstitial;
  }
}

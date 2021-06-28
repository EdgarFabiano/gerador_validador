import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:gerador_validador/defaults/defaults_export.dart';

class AdMobService {
  static final String testAppId = 'ca-app-pub-3940256099942544~3347511713';

  static final String bannerTestAdUnitId = 'ca-app-pub-5932227223136302/1970700133';

  static final String interstitialTestAdUnitId = 'ca-app-pub-3940256099942544/1033173712';

  static final String appId = 'ca-app-pub-5932227223136302~5091687492';

  static String getAppId() {
    if (!Constants.isTesting) {
      return appId;
    }
    return testAppId;
  }

  static double bannerPadding(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
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

  static String _getBannerId() {
    if (!Constants.isTesting) {
      return bannerId;
    }
    return bannerTestAdUnitId;
  }

  static BannerAd startBanner() {
    if (_banner == null) {
      _banner = BannerAd(
        adUnitId: _getBannerId(),
        size: AdSize.smartBanner,
        targetingInfo: MobileAdTargetingInfo(testDevices: ['4B0FDC40963AB3E77AED679FF240F802'])
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

  static String _getInterstitialId() {
    if (!Constants.isTesting) {
      return interstitialId;
    }
    return interstitialTestAdUnitId;
  }

  static InterstitialAd buildInterstitial() {
    return InterstitialAd(
        adUnitId: _getInterstitialId(),
        targetingInfo: MobileAdTargetingInfo(testDevices: ['4B0FDC40963AB3E77AED679FF240F802']),
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            _interstitial?.show();
          }
          if (event == MobileAdEvent.clicked || event == MobileAdEvent.closed) {
            _interstitial.dispose();
          }
        });
  }
}
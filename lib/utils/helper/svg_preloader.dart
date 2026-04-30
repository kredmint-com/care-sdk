import 'package:flutter_svg/flutter_svg.dart';
import '../../app/data/values/images.dart';

class SvgPreloader {
  static final List<String> svgAssets = [
    Images.kredmint,
    Images.phone,
    Images.otp,
    Images.headset,
    Images.done,
    Images.email,
    Images.whatsapp,
    Images.enterName,
    Images.document,
    Images.secure,
    Images.organization,
    Images.work,
    Images.directorPerson,
    Images.gstDocument,
    Images.panDocument,
    Images.home,
    Images.credit,
    Images.history,
    Images.offer,
    Images.homeClicked,
    Images.creditClicked,
    Images.historyClicked,
    Images.offerClicked,
    Images.dashboard,
    Images.more,
    Images.search,
    Images.notification,
    Images.profile,
    Images.arrowForward,
    Images.bharatConnect,
    Images.failedFilled,
    Images.failed,
    Images.paymentDone,
    Images.paymentCancelled,
    Images.paymentDoneFilled,
    Images.refund,
    Images.paymentPending,
    Images.copy,
    Images.kredmintLogo,
    Images.rbi,
    Images.privacy,
    Images.documents,
    Images.helpAndSupport,
    Images.invoices,
    Images.logout,
    Images.myCoupon,
    Images.privacyPolicy,
    Images.repayment,
    Images.termAndConditions
  ];

  static Future<void> preloadSvgAssets() async {
    for (String asset in svgAssets) {
      final SvgAssetLoader loader = SvgAssetLoader(asset);
      svg.cache
          .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }
  }
}

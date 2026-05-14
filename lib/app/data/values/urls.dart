import 'package:loan_sdk_package/app/config/env.dart';

class Urls {
  static String getOtp({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/auth/otp";

  static String verifyOtp({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/oauth/token";

  static String layoutPage({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/layout/page";

  static String accounts({
    required String userId,
    required String subType,
    required String baseUrlType,
  }) =>
      "${Env.getBaseUrl()[baseUrlType]}/user/$userId/accounts?subType=$subType";

  static String accountsV2({
    required String userId,
    required String subType,
    required String baseUrlType,
  }) =>
      "${Env.getBaseUrl()[baseUrlType]}/bbps/user/$userId/accounts?subType=$subType";

  static String mobileOperator({required String opId}) =>
      "https://static.mobikwik.com/appdata/operator_icons/op$opId.png";

  static String rechargeCircleV2({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/bbps/recharge/circles";

  static String rechargeCircle({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/recharge/circles";

  static String planTypesV2({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/bbps/recharge/planTypes";

  static String planTypes({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/recharge/planTypes";

  static String plansV2({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/bbps/recharge/plans";

  static String plans({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/recharge/plans";

  static String appConfig({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/appConfig";

  static String validatePlanV2({
    required String userId,
    required String baseUrlType,
  }) => "${Env.getBaseUrl()[baseUrlType]}/bbps/user/$userId/plan/validate";

  static String validatePlan({
    required String userId,
    required String baseUrlType,
  }) => "${Env.getBaseUrl()[baseUrlType]}/user/$userId/plan/validate";

  static String getPaymentAccessKey({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/bill/session";

  static String getPaymentAccessKeyV2({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/bbps/bill/txn/pay";

  static String updatePaymentStatus({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/pg/pay";

  static String getPaymentStatus({
    required String mbTxnId,
    required String baseUrlType,
  }) => "${Env.getBaseUrl()[baseUrlType]}/mobikwik/transaction/status/$mbTxnId";

  static String getOperatorListV2({
    required String subType,
    required String baseUrlType,
  }) => "${Env.getBaseUrl()[baseUrlType]}/bbps/$subType/operators";

  static String getOperatorList({
    required String subType,
    required String baseUrlType,
  }) => "${Env.getBaseUrl()[baseUrlType]}/$subType/operators";

  static String fetchBill({
    required String userId,
    required String baseUrlType,
  }) => "${Env.getBaseUrl()[baseUrlType]}/user/$userId/bill/fetch";

  static String fetchAccountBill({
    required String userId,
    required String accId,
    required String baseUrlType,
  }) =>
      "${Env.getBaseUrl()[baseUrlType]}/bbps/user/$userId/account/$accId/bill";

  static String fetchBillV2({
    required String userId,
    required String baseUrlType,
  }) => "${Env.getBaseUrl()[baseUrlType]}/bbps/user/$userId/bill/fetch";

  static String user({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/user/";

  static String userDevice({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/user/device";

  static String leadNotifications({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/lead/notifications";

  static String userProfilePage({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/lead/userProfileStage/page";

  static String leadDashboard({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/lead/dashboard/profile";

  static String updateUserProfileStage({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/lead/userProfileStage/submit";

  static String validateGst({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/kyc/validate/gst";

  static String validateBank({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/master/kyc/validate/bank";

  static String validateIfsc({
    required String baseUrlType,
    required String ifsc,
  }) => "${Env.getBaseUrl()[baseUrlType]}/master/kyc/validate/ifsc?ifsc=$ifsc";

  static const String getAddressDetail =
      "https://maps.googleapis.com/maps/api/geocode/json";

  static String uploadDocument({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/user/document/upload";

  static String deleteDocument({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/user/document";

  static String netbanking({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/underwriting/bank-statement";

  static String report({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/underwriting/scoreme/report";

  static String pay({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/account/payment/v1/pay";

  static String loi({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/user/loi";

  static String leadProfile({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/lead/userProfile/all/product";

  static String leadData({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/lead/userProfile/default";

  static String history({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/user/bill/transaction";

  static String historyDetail({
    required String baseUrlType,
    required String id,
  }) => "${Env.getBaseUrl()[baseUrlType]}/bill/session/id/$id";

  static String validatePan({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/kyc/validate/pan";

  static String footerNotification({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/notifications";

  static String repaymentNotification({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/event/notifications";

  static String bellNotification({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/event/notifications";

  static String markAsReadNotification({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/event/notifications/markAsRead";

  static String kredcoinWallet({
    required String baseUrlType,
    required String userId,
  }) => "${Env.getBaseUrl()[baseUrlType]}/account/kred/coin/user/$userId";

  static String kredcoinHistory({
    required String baseUrlType,
    required String userId,
  }) =>
      "${Env.getBaseUrl()[baseUrlType]}/account/kred/coin/statement/user/$userId";

  static String softScore({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/underwriting/cibil/soft/score";

  static String offerDetail({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/coupon/single/brandId";

  static String myCouponDetail({
    required String baseUrlType,
    required String myCouponId,
  }) => "${Env.getBaseUrl()[baseUrlType]}/user/myCoupon/$myCouponId";

  static String pgPay({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/account/pg/pay";

  static String myCoupon({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/user/myCoupon";

  static String redeemFreeCoupon({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/user/myCoupon/zero";

  static String myCouponList({
    required String baseUrlType,
    required String userId,
    String? query,
  }) => "${Env.getBaseUrl()[baseUrlType]}/user/myCoupon/search?userId=$userId";

  static String myCouponStats({
    required String baseUrlType,
    required String userId,
    String? query,
  }) => "${Env.getBaseUrl()[baseUrlType]}/user/myCoupon/stats?userId=$userId";

  static String getAllCoupons({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/coupon/promocode/offers";

  static String validateCouponCode({
    required String baseUrlType,
    required String userId,
    required String userBillId,
  }) =>
      "${Env.getBaseUrl()[baseUrlType]}user/$userId/bill/$userBillId/checkOffers";

  static String getCouponCategoryName({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/coupon/category/active";

  static String getCouponStatusName({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/user/myCoupon/status";

  static String getCouponBrands({required String baseUrlType, String? query}) {
    final baseUrl = Env.getBaseUrl()[baseUrlType];
    return "$baseUrl/coupon/brand/search";
  }

  static String getInvoiceList({
    required String baseUrlType,
    required String profileId,
    String? query,
  }) => "${Env.getBaseUrl()[baseUrlType]}/account/invoices?userId=$profileId";

  static String getRepaymentList({
    required String baseUrlType,
    required String profileId,
    String? query,
  }) =>
      "${Env.getBaseUrl()[baseUrlType]}/account/payment/v2/loans?userId=$profileId";

  static String getRepaymentDue({
    required String baseUrlType,
    required String payId,
    String? query,
  }) => "${Env.getBaseUrl()[baseUrlType]}/account/loan/$payId/repayments";

  static String getSupplierList({
    required String baseUrlType,
    required String profileId,
  }) =>
      "${Env.getBaseUrl()[baseUrlType]}/account/bank/supplier?userId=$profileId";

  static String createSupplier({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/account/bank";

  static String uploadInvoice({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/account/invoice/create";

  static String invoiceDetail({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/account/loan/invoices/detail";

  static String userLimit({required String baseUrlType}) {
    final baseUrl = Env.getBaseUrl()[baseUrlType];
    return "$baseUrl/account/v1/account/wallet";
  }

  static String getCreditDrawdown({
    required String baseUrlType,
    required String profileId,
  }) => "${Env.getBaseUrl()[baseUrlType]}/account/drawdown/user/$profileId";

  static String getKfs({required String baseUrlType, required String userId}) =>
      "${Env.getBaseUrl()[baseUrlType]}/user/kfs?userId=$userId";

  static String uploadDrawdownInvoice({
    required String baseUrlType,
    required String profileId,
  }) => "${Env.getBaseUrl()[baseUrlType]}/account/drawdown/user/$profileId";

  static String bill({
    required String baseUrlType,
    required String userId,
    required String id,
  }) {
    final baseUrl = Env.getBaseUrl()[baseUrlType];
    return "$baseUrl/user/$userId/bill/$id";
  }

  static String billV2({
    required String baseUrlType,
    required String userId,
    required String id,
  }) {
    final baseUrl = Env.getBaseUrl()[baseUrlType];
    return "$baseUrl/bbps/user/$userId/account/$id";
  }

  static String getUserCoupons({
    required String baseUrlType,
    required String userId,
  }) => "${Env.getBaseUrl()[baseUrlType]}/user/$userId/offers";

  static String settlement({required String baseUrlType}) {
    final baseUrl = Env.getBaseUrl()[baseUrlType];
    return "$baseUrl/account/payment/user/settlement";
  }

  static String applyBbpsCoupon({
    required String baseUrlType,
    required String userId,
    required String userBillId,
  }) =>
      "${Env.getBaseUrl()[baseUrlType]}/user/$userId/bill/$userBillId/checkOffers";

  static redeemKredcoin({required String baseUrlType, String? query}) =>
      "${Env.getBaseUrl()[baseUrlType]}/account/kred/coin/redeemable";

  static String orderConfig({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/layout/appConfig";

  static String checkToken({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/auth/dms/check/token";

  static layout({required String pageId, required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/layout/page/$pageId";

  static addItemInCart({required String cartId, required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/cart/$cartId/add";

  static cart({required String baseUrlType, required String userId}) =>
      "${Env.getBaseUrl()[baseUrlType]}/cart/$userId";

  static getRetailerAddress({
    required String baseUrlType,
    required String userId,
  }) => "${Env.getBaseUrl()[baseUrlType]}/user/$userId/retailer/address/all";

  static getPrimaryRetailerAddress({
    required String baseUrlType,
    required String userId,
  }) => "${Env.getBaseUrl()[baseUrlType]}/user/$userId/retailer/address";

  static updateRetailerAddress({
    required String baseUrlType,
    required String userId,
    String? query,
  }) => "${Env.getBaseUrl()[baseUrlType]}/user/$userId/retailer/address";

  static getSupplier({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/product/category/suppliers";

  static getSupplierProduct({
    required String baseUrlType,
    required String supplierId,
  }) => "${Env.getBaseUrl()[baseUrlType]}/product/supplier/$supplierId";

  static payOrder({required String baseUrlType, String? query}) =>
      "${Env.getBaseUrl()[baseUrlType]}/order/pay";

  static order({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/order";

  static getOrderStatus({
    required String baseUrlType,
    required String orderId,
  }) => "${Env.getBaseUrl()[baseUrlType]}/order/$orderId";

  static updateOrderStatus({
    required String baseUrlType,
    required String orderId,
  }) => "${Env.getBaseUrl()[baseUrlType]}/order/$orderId/pay";

  static searchProduct({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/inventory/search/products";

  static couponList({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/coupon/list";

  static removeCoupon({required String baseUrlType, required String cartId}) =>
      "${Env.getBaseUrl()[baseUrlType]}/cart/$cartId/coupon/remove";

  static String applyCoupon({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/coupon/promocode";

  static String applyOrderCoupon({
    required String baseUrlType,
    required String cartId,
  }) => "${Env.getBaseUrl()[baseUrlType]}/cart/$cartId/apply";

  static String getCompressionUrl({required int dpr, required String height}) =>
      "https://img.kredmint.in/unsafe/resize:auto:$height/dpr:$dpr/plain/";

  static String paymentMethod({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/order/config";

  static String orderType({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/order/type";

  static String eligibility({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/lead/eligibility";

  static String bank({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/account/bank";

  static String verifyEsign({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/user/kfs/esignStatus";

  static String verifyMandate({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/user/mandate";

  static String syncPan({required String baseUrlType}) =>
      "${Env.getBaseUrl()[baseUrlType]}/master/kyc/sync/pan";


}

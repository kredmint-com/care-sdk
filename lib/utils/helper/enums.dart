enum BaseUrlType {
  auth,
  master,
  user,
  lead,
  underwriting,
  account,
  event,
  zappfresh,
  client,
}

enum RailType {
  BANNER,
  DEFAULT_BG,
  DEFAULT,
  CIBIL_SUMMARY,
  CREDIT_SCORE,
  text,
  HERO,
  BENEFITS,
  CARD,
  FAQ,
  GRID,
  GRID_CARD,
  GRID_PREMIUM,
  GRID_BASIC,
  UTILITY_BILLS,
  CARD_WITH_IMG,
  TOP_COUPONS,
  HOME_FOOTER,
  NOTIFICATION,
  BANNER_SLIDER,
  HORIZONTAL_LIST,
}

enum InputType { text, select, date, address, file, heading, checkbox }

enum ActionType { Landline, MOBILE, FAS_TAG, BANNER, DTH, DEEPLINK }

enum PageType {
  PRE_BILL,
  POST_BILL,
  BBPS_DEFAULT,
  LOAN_DASHBOARD,
  OFFER_DASHBOARD,
  GOLD_LOAN,
  LAP_LOAN,
  VOUCHER,
  BANNER,
  CARD_WITH_IMG,
}

enum PaymentStatus {
  PAYMENT_SUCCESS,
  PAYMENT_FAILED,
  REFUND_INITIATED,
  PAYMENT_PENDING,
  PAYMENT_INITIATED,
  PENDING,
  INITIATED,
  SUCCESS,
  FAILED,
  COMPLETED,
}

enum RechargeStatus { RECHARGE_SUCCESS }

enum EaseBuzzPaymentStatus { success, userCancelled }

enum NotificationType { standard, bigPicture }

enum FieldDataType { static, date, option }

// enum PageType { external }

enum Pg { CASH_FREE, ORA, ZEAL, EaseBuzz, Razorpay }

enum OtpMedium { SMS, WHATSAPP }

enum NotificationActionType {
  INCOMPLETE_PROFILE,
  BOUNCE,
  BILL_PAYMENT,
  INVOICE,
  LOAN_APPLICATION,
}

enum LeadNotificationType { LOAN_APPLICATION }

enum AppUpdateAction { none, showFlexibleDialog, showForceDialog }

enum PaymentEnv { test, prod }

enum KeyboardType { number, text, email }

enum PageCategory {
  Promoter,
  IndividualPromoter,
  BankStatement,
  Gst,
  Itr,
  Review,
  LoiSummary,
  ProcessingFee,
  EmiPlans,
  KfsEsignUrl,
  MandateSignUrl,
  Success,
  BankDetail,
  ProfileRejected,
  DownPayment
}

enum AddressType { current, permanent }

enum DocumentType { BANK_STATEMENT, INVOICE }

enum FieldType { email }

enum LayoutSubtype { INVOICE_DISCOUNTING }

enum VoucherType { EXTERNAL_VOUCHER }

enum CouponStatus { PENDING, FAILED, COMPLETED, ACTIVE }

enum SortOption { lowToHigh, highToLow, aToZ, zToA }

enum BottomSheetType { CONTACT_SUPPORT, EXIT }

enum InvoiceStatus {
  ALL,
  REJECTED,
  PAID,
  CANCELLED,
  VERIFIED,
  INITIATED,
  COMPLETED,
  APPROVED,
}

enum RepaymentStatus { ALL, PENDING, PAID, OVERDUE, BOUNCED }

enum BellNotificationType { ALL, BILL_PAYMENT, LOAN_REPAYMENT, OTHERS }

enum ContentType { PRODUCT, CATEGORY, SUPPLIER }

enum RedeemProvider { OMS, AXIS, KREDMINT }

enum RedeemSourceType { FOOD, PAYMENT, BBPS, VOUCHER }

enum PaymentMethod { ONLINE, cod }

enum OrderType { DineIn, TakeAway, Delivery }

enum PaymentType { OMS_PRE_PAYMENT }

enum HistorySubType { FOOD }

enum DiscountType { value, percent }

enum OfferType { coupon, scheme }

enum OrderStatus {
  Delivered,
  Cancelled,
  Created,
  PartiallyDelivered,
  BatchAssigned,
  Packed,
}

enum KredcoinType { EARN, REDEEM }

enum KredcoinStatus { ACTIVE, EXHAUSTED, PENDING, CANCEL }

enum AllowedInvoiceTypes { SUPPLIER_INVOICE, DRAWDOWN_REQUEST }

enum BbpsApiVersion { v1, v2 }

enum EmiPlanType {monthly , weekly}

enum ProfileStatus {
   PROFILE_COMPLETED,
   PROFILE_REJECTED,
}

enum SdkStatus {
  SDK_CLOSED
}

class Regrex {
  static final characterRegex = RegExp("[a-zA-Z]");
  static final gstNumberRegrex =
      RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$');
  static final aadhaarRegrex = RegExp(r'^[2-9]{1}[0-9]{11}$');
  static final panRegrex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
  static final websiteRegrex = RegExp(r"<a href='(.*?)'>(.*?)<\/a>");
  static final gstRegrex = RegExp(r'^[0-9A-Z]{15}$');
  static final ifscRegrex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
}

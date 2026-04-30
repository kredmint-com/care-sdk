import 'package:intl/intl.dart';
import 'package:loan_sdk_package/utils/helper/regrex.dart';

extension StringExtensions on String {
  bool isValidEmail() =>
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(trim()) ||
      trim().isEmpty;

  bool isValidPhone() => RegExp(r'^[6-9]\d{9}$').hasMatch(trim());

  bool isValidOTP() => trim().length == 4;

  bool isValidName() => trim().isNotEmpty;

  String capitalize() =>  (trim().isEmpty) ? this : trim()[0].toUpperCase() + trim().toLowerCase().substring(1);

  bool isDataNotEmpty() => trim().isNotEmpty;

  bool isValidPincode() => RegExp(r'^\d{6}$').hasMatch(trim());

  bool isDataEmpty() => trim().isEmpty;

  bool isValidGST() =>
      Regrex.gstNumberRegrex.hasMatch(trim()) || trim().isEmpty;

  bool isValidIfsc() =>
      Regrex.ifscRegrex.hasMatch(trim()) || trim().isEmpty;

  bool isValidAadhaar() =>
      Regrex.aadhaarRegrex.hasMatch(trim()) || trim().isEmpty;

  bool isValidPan() => Regrex.panRegrex.hasMatch(trim()) || trim().isEmpty;

  String formatTimeInMinuteSecond() {
    int timeInSecond = int.tryParse(this) ?? 0;
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  String formatData() {
    String res = "";
    List<String> dataList = split(".");
    if (dataList.length == 2) {
      if ((dataList[1] == "0") || (dataList[1] == "00")) {
        res = dataList[0];
      } else {
        if (dataList[1].length >= 2) {
          res = "${dataList[0]}.${dataList[1].substring(0, 2)}";
        } else {
          res = "${dataList[0]}.${dataList[1]}";
        }
      }
    } else {
      res = this;
    }
    return res;
  }

  String formatDate() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      int.tryParse(this) ?? 0,
    );
    String formattedDate = DateFormat("d MMM yyyy, h:mm a").format(dateTime);
    return formattedDate;
  }

  String removeUnderscoreAndCapitalize() {
    List<String> refactoredString = [];
    List<String> wordList = [];
    if(isNotEmpty){
      wordList= toLowerCase().replaceAll('_', ' ').split(' ');
    }
    if(wordList.isEmpty){
      return capitalize();
    }
    for (int i = 0; i < wordList.length; i++) {
      refactoredString.add(
        ((i == 0) ? wordList[i][0].toUpperCase() : wordList[i][0]) +
            wordList[i].substring(1),
      );
    }
    return wordList.isEmpty ? this : refactoredString.join(" ");
  }

  String removeSpaceAndAddNewLine() {
    final wordList = split(' ');
    if (wordList.length <= 1) return this;
    if (wordList.length == 2) return wordList.join('\n');

    final lastWord = wordList.removeLast();
    return '${wordList.join(' ')}\n$lastWord';
  }

  String convertBackendDateFormat() {
    return replaceAll('DD', 'dd').replaceAll('YYYY', 'yyyy');
  }

  bool containsHtml() {
    return RegExp(r"<[^>]+>").hasMatch(this);
  }
}

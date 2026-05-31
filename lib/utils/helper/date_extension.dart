import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String formatDateInMMMD() => DateFormat.MMMd().format(this);

  String formatInYYYYMMD() => DateFormat('yyyy-MM-dd').format(this);

  String formatInDDMMYYYY() => DateFormat('dd/MM/yyyy').format(this);

  String formatDateInYMMMD() => DateFormat.yMMMd().format(this);

  String twelveHourFormat() => DateFormat.jm().format(this);

  String formatDateWithRegrex({required String regrex}) =>
      DateFormat(regrex).format(this);

  String formatDateWithTime() =>
      DateFormat('dd MMM yyyy \'at\' hh:mm a').format(this);
}

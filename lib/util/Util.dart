import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Util {

  static final String ymd = "yyyy/MM/dd(E) HH:mm";
  static final String localJp = "ja_JP";

  String getNowDateAndTime() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
    String formatted = formatter.format(now);
    return formatted;
  }

  String dateTimeString(String string, String formatterString, String local) {
    initializeDateFormatting(local);

    DateTime datetime = DateTime.tryParse(string); // StringからDate
    if (datetime == null)
      return "";
    var formatter = new DateFormat(formatterString, local);
    var formatted = formatter.format(datetime); // DateからString
    return formatted;
  }

}
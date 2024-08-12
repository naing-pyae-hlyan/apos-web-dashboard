import 'package:apos/lib_exp.dart';
import 'package:apos/models/_exp.dart';

class CommonUtils {
  static Widget versionLabel({
    String? prefix,
    Color? color,
  }) =>
      FutureBuilder(
        future: appVersion(prefix: prefix),
        builder: (_, snapshot) => SafeArea(
          child: myTitle(
            (snapshot.hasData && snapshot.data != null)
                ? snapshot.data as String
                : '',
            fontSize: 13,
          ),
        ),
      );

  static Future<String> appVersion({
    String? prefix,
  }) async {
    String v = prefix ?? 'Version : ';

    final packageInfo = await PackageInfoUtils.packageInfo();

    v += packageInfo.version;
    return v;
  }

  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  static Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static void showCannotAccessDialog(BuildContext context) => showErrorDialog(
        context,
        title: "Warning",
        description:
            "You cannot access this feature.\nPlease contact to SuperAdmin.",
        onTapOk: () {},
      );
}

void doAfterBuild({
  Function()? callback,
  Duration duration = Duration.zero,
}) {
  Future.delayed(duration, callback);
}

bool stringCompare(String? name, String? query) {
  if (name == null || query == null) return true;
  if (name.isEmpty || query.isEmpty) return true;

  return name
      .toUpperCase()
      .replaceAll(' ', '')
      .contains(query.toUpperCase().replaceAll(' ', ''));
}

String slugify(String input) {
  return input
      .toUpperCase()
      .replaceAll(' ', '-')
      .replaceAll(RegExp(r'[^A-Z0-9\-]'), '');
}

String idsGenerator(String prefix, int length) {
  String id = (length < 10)
      ? "000$length"
      : (length < 100)
          ? "00$length"
          : (length < 1000)
              ? "0$length"
              : "$length";

  return slugify("$prefix $id");
}

String formatToStar(String value) {
  return value.replaceAll(RegExp(r'.'), "*");
}

List<num> calcByDate(List<OrderModel> orders) {
  num jan = 0;
  num feb = 0;
  num mar = 0;
  num apr = 0;
  num may = 0;
  num jun = 0;
  num jul = 0;
  num aug = 0;
  num sep = 0;
  num oct = 0;
  num nov = 0;
  num dec = 0;
  final now = DateTime.now();
  for (OrderModel order in orders) {
    if (now.year == order.orderDate.year) {
      if (order.orderDate.month == DateTime.january) {
        jan += order.totalAmount;
      }
      if (order.orderDate.month == DateTime.february) {
        feb += order.totalAmount;
      }
      if (order.orderDate.month == DateTime.march) {
        mar += order.totalAmount;
      }
      if (order.orderDate.month == DateTime.april) {
        apr += order.totalAmount;
      }
      if (order.orderDate.month == DateTime.may) {
        may += order.totalAmount;
      }
      if (order.orderDate.month == DateTime.june) {
        jun += order.totalAmount;
      }
      if (order.orderDate.month == DateTime.july) {
        jul += order.totalAmount;
      }
      if (order.orderDate.month == DateTime.august) {}
      aug += order.totalAmount;
      if (order.orderDate.month == DateTime.september) {
        sep += order.totalAmount;
      }
      if (order.orderDate.month == DateTime.october) {
        oct += order.totalAmount;
      }
      if (order.orderDate.month == DateTime.november) {
        nov += order.totalAmount;
      }
      if (order.orderDate.month == DateTime.december) {
        dec += order.totalAmount;
      }
    }
  }

  return [jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec];
}

import 'package:apos/lib_exp.dart';

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

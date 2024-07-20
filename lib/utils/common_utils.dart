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

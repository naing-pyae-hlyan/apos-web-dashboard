// import 'package:apos/lib_exp.dart';

class CommonUtils {}

void doAfterBuild({
  Function()? callback,
  Duration duration = Duration.zero,
}) {
  Future.delayed(duration, callback);
}

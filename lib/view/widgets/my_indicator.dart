import 'package:apos/lib_exp.dart';

class MyIndicator extends StatelessWidget {
  const MyIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: LinearProgressIndicator(
        backgroundColor: Consts.primaryColor.withOpacity(0.1),
        color: Consts.primaryColor,
      ),
    );
  }
}

class MyCircularIndicator extends StatelessWidget {
  const MyCircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Consts.primaryColor.withOpacity(0.1),
      color: Consts.primaryColor,
    );
  }
}

import 'package:apos/lib_exp.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
    return LoadingAnimationWidget.threeArchedCircle(
      color: Consts.primaryColor,
      size: 24,
    );
  }
}

class MyLoadingIndicator extends StatelessWidget {
  const MyLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: Consts.primaryColor,
      size: 24,
    );
  }
}

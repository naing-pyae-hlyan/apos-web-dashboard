import 'package:apos/lib_exp.dart';
import 'package:fl_chart/fl_chart.dart';

class DailyChartCard extends StatefulWidget {
  const DailyChartCard({super.key});

  @override
  State<DailyChartCard> createState() => _DailyChartCardState();
}

class _DailyChartCardState extends State<DailyChartCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Consts.secondaryColor2,
      surfaceTintColor: Consts.secondaryColor2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: LineChart(
            LineChartData(),
          ),
        ),
      ),
    );
  }
}

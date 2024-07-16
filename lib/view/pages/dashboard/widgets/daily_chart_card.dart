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
    return SizedBox(
      // width: context.screenWidth * 0.3 + 80,
      width: double.maxFinite,
      height: dashboardCardHeight,
      child: AspectRatio(
        aspectRatio: 16 / 7,
        child: MyCard(
          cardColor: Consts.primaryColor,
          child: LineChart(
            LineChartData(
              minX: 1,
              minY: 0,
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: _bottomTitleWidget,
                  ),
                ),
              ),
              lineTouchData: LineTouchData(
                enabled: true,
                handleBuiltInTouches: false,
                touchCallback: (event, LineTouchResponse? response) {},
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (touchSpots) =>
                      touchSpots.map((e) => null).toList(),
                ),
                touchSpotThreshold: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomTitleWidget(double value, TitleMeta meta) {
    // if (value.toInt() > (widget.summaryData.weekEarnings ?? []).length) {
    //   return emptyUI;
    // }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: myText(
        "Hello", // (widget.summaryData.weekEarnings ?? [])[value.toInt() - 1].weekDay,

        color: Consts.descriptionColor,
      ),
    );
  }
}

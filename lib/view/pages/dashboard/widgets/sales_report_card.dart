import 'package:apos/lib_exp.dart';
import 'package:fl_chart/fl_chart.dart';

class SalesReportCard extends StatefulWidget {
  const SalesReportCard({super.key});

  @override
  State<SalesReportCard> createState() => _SalesReportCardState();
}

class _SalesReportCardState extends State<SalesReportCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: context.screenWidth * 0.3 + 80,
      width: double.maxFinite,
      height: dashboardCardHeight,
      child: AspectRatio(
        aspectRatio: 16 / 7,
        child: MyCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              myText(
                "SALES REPORT",
                color: Consts.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              verticalHeight8,
              Expanded(
                child: LineChart(
                  LineChartData(
                    maxX: 11,
                    maxY: 10,
                    lineTouchData: LineTouchData(
                      handleBuiltInTouches: true,
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipColor: (_) => Colors.amber,
                        getTooltipItems: tooltipItem,
                      ),
                    ),
                    gridData: FlGridData(
                      horizontalInterval: 1,
                      verticalInterval: 1,
                      getDrawingHorizontalLine: (_) =>
                          const FlLine(strokeWidth: 0.1),
                      getDrawingVerticalLine: (_) =>
                          const FlLine(strokeWidth: 0.1),
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 32,
                          interval: 1,
                          getTitlesWidget: (double value, _) {
                            return myText(
                              "${value.toInt() * 10}k",
                              textAlign: TextAlign.end,
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          interval: 1,
                          getTitlesWidget: bottomTitleWidgets,
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 8,
                          getTitlesWidget: (_, __) => emptyUI,
                        ),
                      ),
                      topTitles: const AxisTitles(sideTitles: SideTitles()),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border:
                          Border(bottom: border, right: border, top: border),
                    ),
                    lineBarsData: [
                      lineChartBarData1_1,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final BorderSide border = const BorderSide(
    color: Consts.primaryFontColor,
    width: 0.5,
  );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = "Jan";
        break;
      case 1:
        text = "Feb";
        break;
      case 2:
        text = "Mar";
        break;
      case 3:
        text = "Apr";
        break;
      case 4:
        text = "May";
      case 5:
        text = "Jun";
      case 6:
        text = "Jul";
        break;
      case 7:
        text = "Aug";
        break;
      case 8:
        text = "Sep";
        break;
      case 9:
        text = "Oct";
        break;
      case 10:
        text = "Nov";
        break;
      case 11:
        text = "Dec";
      default:
        text = "";
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: myText(text),
    );
  }

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: Consts.primaryColor,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: true),
        spots: const [
          FlSpot(0, 0.4),
          FlSpot(1, 1),
          FlSpot(2, 1),
          FlSpot(3, 2.5),
          FlSpot(4, 3),
          FlSpot(5, 1.5),
          FlSpot(6, 4),
          FlSpot(7, 5),
          FlSpot(8, 8),
          FlSpot(9, 6),
          FlSpot(10, 5.5),
          FlSpot(11, 6.5),
        ],
      );

  List<LineTooltipItem> tooltipItem(List<LineBarSpot> touchedSpots) {
    return touchedSpots.map(
      (LineBarSpot touchedSpot) {
        const textStyle = TextStyle(
          color: Consts.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        );
        return LineTooltipItem("${touchedSpot.y * 10}k", textStyle);
      },
    ).toList();
  }
}

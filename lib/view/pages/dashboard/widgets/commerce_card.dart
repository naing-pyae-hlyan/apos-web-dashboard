import 'package:apos/lib_exp.dart';

class DashboardCommerceCard extends StatelessWidget {
  final String title;
  final double amount;
  final IconData icon;
  final String lblTodayRecord;
  final String lblMonthlyRecord;
  final int todayRecord;
  final int monthlyRecord;
  const DashboardCommerceCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.lblTodayRecord,
    required this.lblMonthlyRecord,
    required this.todayRecord,
    required this.monthlyRecord,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth * 0.3,
      height: dashboardCardHeight,
      child: AspectRatio(
        aspectRatio: 16 / 7,
        child: MyCard(
          cardColor: Consts.primaryColor,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  myText(
                    title,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    maxLines: 1,
                  ),
                  verticalHeight4,
                  myTitle(
                    amount.toCurrencyFormat(),
                    color: Colors.white,
                    fontSize: 21,
                    maxLines: 1,
                  ),
                  verticalHeight16,
                  const Divider(thickness: 0.5),
                  verticalHeight16,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: myText(
                          lblTodayRecord,
                          color: Colors.white,
                          maxLines: 1,
                        ),
                      ),
                      horizontalWidth16,
                      Flexible(
                        child: myText(
                          lblMonthlyRecord,
                          color: Colors.white,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  verticalHeight4,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: myTitle(
                          todayRecord.toCurrencyFormat(),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          maxLines: 1,
                        ),
                      ),
                      horizontalWidth16,
                      Flexible(
                        child: myTitle(
                          monthlyRecord.toCurrencyFormat(),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                icon,
                size: 48,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

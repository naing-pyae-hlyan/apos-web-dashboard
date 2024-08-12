import 'package:apos/lib_exp.dart';

class DashboardCommerceCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final String lblTodayRecord;
  final String lblMonthlyRecord;
  final int todayRecord;
  final int monthlyRecord;
  final bool isLoadingState;
  const DashboardCommerceCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.lblTodayRecord,
    required this.lblMonthlyRecord,
    required this.todayRecord,
    required this.monthlyRecord,
    required this.isLoadingState,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth * 0.3,
      height: dashboardCardHeight,
      child: AspectRatio(
        aspectRatio: 16 / 7,
        child: MyCard(
          // cardColor: Consts.primaryColor,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  myText(
                    title,
                    color: Consts.primaryColor,
                    fontWeight: FontWeight.bold,
                    maxLines: 1,
                  ),
                  verticalHeight4,
                  if (isLoadingState)
                    const MyLoadingIndicator()
                  else
                    myTitle(
                      count.toCurrencyFormat(),
                      color: Consts.primaryColor,
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
                          lblTodayRecord.toCurrencyFormat(),
                          color: Consts.primaryColor,
                          maxLines: 1,
                        ),
                      ),
                      horizontalWidth16,
                      Flexible(
                        child: myText(
                          lblMonthlyRecord.toCurrencyFormat(),
                          color: Consts.primaryColor,
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
                        child: (isLoadingState)
                            ? const MyLoadingIndicator()
                            : myTitle(
                                todayRecord.toCurrencyFormat(),
                                fontWeight: FontWeight.bold,
                                color: Consts.primaryColor,
                                maxLines: 1,
                              ),
                      ),
                      horizontalWidth16,
                      Flexible(
                        child: (isLoadingState)
                            ? const MyLoadingIndicator()
                            : myTitle(
                                monthlyRecord.toCurrencyFormat(),
                                fontWeight: FontWeight.bold,
                                color: Consts.primaryColor,
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
                color: Consts.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

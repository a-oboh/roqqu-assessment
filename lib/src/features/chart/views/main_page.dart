import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:roqqu_test_app/src/common/common.dart';
import 'package:roqqu_test_app/src/common/context_ext.dart';
import 'package:roqqu_test_app/src/features/chart/notifier/chart_notifier.dart';
import 'package:roqqu_test_app/src/features/chart/views/widgets/appbar_widget.dart';
import 'package:roqqu_test_app/src/features/chart/views/widgets/candlestick_chart.dart';
import 'package:roqqu_test_app/src/features/chart/views/widgets/daily_change_percent.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({
    super.key,
  });

  static const routeName = '/';

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(chartNotifier.notifier).getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chartNotifier);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: ListView(
        children: [
          const AppbarWidget(),
          Divider(color: AppColors.black3.withOpacity(0.5)),
          const Gap(16),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 58,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Stack(
                    children: [
                      SvgPicture.asset('assets/svg/btc.svg'),
                      Positioned(
                        right: 0,
                        child: SvgPicture.asset('assets/svg/usd.svg'),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(12),
              const Text(
                'BTC/USDT',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(20),
              SvgPicture.asset('assets/svg/down_arrow.svg'),
              const Gap(27),
              const Text(
                '\$20,634',
                style: TextStyle(
                  color: AppColors.chartGreen,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                DailyChangePercent(),
              ],
            ),
          ),
          const Gap(16),
          //divider
          Container(
            decoration: const BoxDecoration(color: AppColors.darkCard),
            height: 12,
          ),
          const SizedBox(height: 16),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: AppColors.tabBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.tabBorder),
                  ),
                  child: TabBar(
                      padding: const EdgeInsets.all(3),
                      labelStyle: const TextStyle(fontSize: 14),
                      indicator: BoxDecoration(
                        color: AppColors.darkCard,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      tabs: const [
                        Tab(
                          child: Text('Charts'),
                        ),
                        Tab(
                          child: Text('Orderbook'),
                        ),
                        Tab(
                          child: Text('Recent trades'),
                        ),
                      ]),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: context.screenHeight * 0.6,
                  child: TabBarView(
                    children: [
                      Column(
                        children: [
                          // timeframe
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                color: AppColors.black3,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              child: Row(children: [
                                const Text('Time'),
                                const Gap(16),
                                const Text('1H'),
                                const Gap(16),
                                const Text('2H'),
                                const Gap(16),
                                const Text('4H'),
                                const Gap(16),
                                //selected
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.black2,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Text(
                                    '1D',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const Gap(16),
                                const Text('1W'),
                                const Gap(16),
                                const Text('1M'),
                                const Gap(16),
                              ]),
                            ),
                          ),
                          const Gap(16),
                          Divider(color: AppColors.black3.withOpacity(0.1)),
                          const Gap(16),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                color: AppColors.black3,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              child: Row(
                                children: [
                                  //selected
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: AppColors.black2,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Text(
                                      'Trading View',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const Gap(20),
                                  const Text('Depth'),
                                  const Gap(16),
                                  SvgPicture.asset(Assets.expand),
                                ],
                              ),
                            ),
                          ),
                          const Gap(16),
                          Divider(color: AppColors.black3.withOpacity(0.1)),

                          CustomPaint(
                            painter: CryptoCandlePainter(
                                timeSeries:
                                    state.assetData.data?.first.timeSeries),
                            child: const SizedBox(height: 190, width: 300),
                          ),
                        ],
                      ),
                      const Placeholder(),
                      const Placeholder(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          //divider
          Container(
            decoration: const BoxDecoration(color: AppColors.darkCard),
            height: 12,
          ),
          const SizedBox(height: 16),
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: AppColors.tabBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.tabBorder),
                  ),
                  child: TabBar(
                      padding: const EdgeInsets.all(3),
                      labelStyle: const TextStyle(fontSize: 14),
                      indicator: BoxDecoration(
                        color: AppColors.darkCard,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      indicatorPadding: const EdgeInsets.all(0),
                      tabs: const [
                        Tab(
                          child: Text('Open Orders'),
                        ),
                        Tab(
                          child: Text('Positions'),
                        ),
                      ]),
                ),
                SizedBox(
                  height: context.screenHeight * 0.4,
                  child: const TabBarView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No Open Orders',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(8),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.black3,
                              ),
                            )
                          ],
                        ),
                      ),
                      Placeholder(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Border radius
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Buy'),
                  ),
                ),
              ),
              const Gap(16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Border radius
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Sell'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

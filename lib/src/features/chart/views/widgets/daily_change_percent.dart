import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:roqqu_test_app/src/common/common.dart';

class DailyChangePercent extends StatelessWidget {
  const DailyChangePercent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: 17,
              color: AppColors.black3,
            ),
            Gap(4),
            Text(
              '24h change',
              style: TextStyle(fontSize: 12, color: AppColors.black3),
            )
          ],
        ),
        Gap(6),
        Text(
          '520.80 +1.25%',
          style: TextStyle(
            color: AppColors.chartGreen,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

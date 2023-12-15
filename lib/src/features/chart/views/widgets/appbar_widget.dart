import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:roqqu_test_app/src/common/util/assets.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 15,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.companyLogo,
            height: 34,
          ),
          const Spacer(),
         Image.asset('assets/images/face.png'),
          const Gap(16),
          SvgPicture.asset(Assets.globe),
          const Gap(16),
          SvgPicture.asset(Assets.menu),
        ],
      ),
    );
  }
}

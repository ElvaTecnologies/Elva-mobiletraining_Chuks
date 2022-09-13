import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/constants/app_color.dart';
import 'splash_screen_viewmodel.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenViewModel>.reactive(
      viewModelBuilder: () => SplashScreenViewModel(),
      onModelReady: (viewModel) => viewModel.waitTime(),
      builder: (context, data, child) => Scaffold(
        backgroundColor: Muroexe.mainColor,
        body: Center(
          child: RichText(
            overflow: TextOverflow.fade,
            text: TextSpan(
                text: data.namePart1,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey.shade900,
                    letterSpacing: 3.0),
                children: [
                  TextSpan(
                    text: data.namePart2,
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 3),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

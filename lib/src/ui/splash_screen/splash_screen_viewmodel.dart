import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.dart';
import '../../app/app.router.dart';
import '../home_screen/home_screen_view.dart';

class SplashScreenViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final String _namePart1 = 'M U R O ';
  final String _namePart2 = 'E X E';

  String get namePart1 => _namePart1;
  String get namePart2 => _namePart2;

  void waitTime() async {
    await Future.delayed(
        const Duration(
          seconds: 3,
        ),
        () => _navigationService.navigateTo(Routes.homeScreenView));
    notifyListeners();
  }
}

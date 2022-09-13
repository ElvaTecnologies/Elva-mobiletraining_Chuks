import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:muroexe_store/src/ui/home_screen/home_screen_view.dart';
import 'package:muroexe_store/src/ui/sign_in_screen/sign_in_view.dart';
import 'package:muroexe_store/src/ui/splash_screen/splash_screen_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../core/constants/helper/snackbar_services.dart';
import '../services/api_services/api_services.dart';

final locator = GetIt.instance;

@StackedApp(routes: [
  CupertinoRoute(page: HomeScreenView),
  CupertinoRoute(page: SignInView),
  MaterialRoute(page: SplashScreenView, initial: true),
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: SnackServices),
  LazySingleton(classType: ApiServices)
])
class AppSetup {
  /** Serves no purpose besides having annotation attached to it */
}

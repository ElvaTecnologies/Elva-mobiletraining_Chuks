import 'dart:core';
import 'dart:developer';

import 'package:muroexe_store/src/app/app.router.dart';
import 'package:muroexe_store/src/services/base/failure.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.dart';
import '../../core/constants/helper/snackbar_services.dart';

import '../../models/product_list/product_list.dart';
import '../../services/api_services/api_services.dart';

const String _singleProduct = 'singleProduct';
const String _limitedProduct = 'limitedProduct';

class HomeScreenViewModel extends MultipleFutureViewModel {
  final ApiServices _apiServices = locator<ApiServices>();
  final _navigationServices = locator<NavigationService>();
  final _snackbarServices = locator<SnackServices>();

  String advertText = '-10% First APP purchase -> Voucher: APP10';
  String networkErrorText = 'Check your network connections';

  ///Map data made accessible
  List<Product>? get limitedProductData => dataMap![_limitedProduct];
  Product? get product => dataMap![_singleProduct];

  ///check for busy....isBusy?
  bool get limitedProductLoading => busy(_limitedProduct);
  bool get singleProductLoading => busy(_singleProduct);

  void navigateToSignIn() => _navigationServices.navigateTo(Routes.signInView);

  Future<Product?> singleProduct() async {
    try {
      setBusy(true);
      final Product result = await _apiServices.singleProduct();
      return result;
      // var timeOut = await runBusyFuture(requestTimeOut());
    } on Failure catch (ex) {
      log(ex.devMessage);
      _snackbarServices.showErrorSnackBar(ex.message);
    } finally {
      setBusy(false);
    }
  }

  Future<List<Product>?> limitedProducts() async {
    setBusy(true);

    try {
      final List<Product> limited = await _apiServices.limitedProduct();
      return limited;
    } on Failure catch (ex) {
      _snackbarServices.showErrorSnackBar(ex.message);
    } finally {
      setBusy(false);
    }
  }

  Future requestTimeOut() async {
    await Future.delayed(const Duration(seconds: 5));
    throw Exception(
        'Something went wrong!!! Please check your network connections');
  }

  @override
  Map<String, Future Function()> get futuresMap => {
        _singleProduct: singleProduct,
        _limitedProduct: limitedProducts,
      };
}

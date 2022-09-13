import 'package:muroexe_store/src/core/constants/helper/snackbar_services.dart';
import 'package:muroexe_store/src/models/signin.dart';
import 'package:muroexe_store/src/services/api_services/api_services.dart';
import 'package:muroexe_store/src/services/base/failure.dart';
import 'package:stacked/stacked.dart';

import '../../app/app.dart';

class SignInViewModel extends FutureViewModel {
  String title = 'Log in to your account';
  String forgotPassword = 'Forgot your password?';
  String createAccount = 'No account? Create one here >';

  final signin = const Signin();
  final _snackbarServices = locator<SnackServices>();
  final _apiServices = locator<ApiServices>();

  bool _isFilled = false;
  bool _isHidden = true;

  bool get isFilled => _isFilled;
  bool get isHidden => _isHidden;

  set isFilled(bool value) => value = _isFilled;

  void toggleFilled() {
    _isFilled = !_isFilled;
    notifyListeners();
  }

  void toggleHidden() {
    _isHidden = !_isHidden;
    notifyListeners();
  }

  Future signIn(Signin signin) async {
    setBusy(true);
    try {
      var response = _apiServices.signIn(signin);
      return response;
    } on Failure catch (ex) {
      _snackbarServices.showErrorSnackBar(ex.message);
    } finally {
      setBusy(false);
    }
  }

  @override
  Future futureToRun() {
    // TODO: implement futureToRun
    return signIn(signin);
  }
}

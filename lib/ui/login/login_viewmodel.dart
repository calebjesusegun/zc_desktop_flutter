import 'package:stacked/stacked.dart';
import 'package:zc_desktop_flutter/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:zc_desktop_flutter/app/app.logger.dart';
import 'package:zc_desktop_flutter/app/app.router.dart';
import '../../services/local_storage_service.dart';

const testLocalKey = 'TESTKEY';

class LoginViewModel extends BaseViewModel {
  final log = getLogger("HomeViewwModel");
  final _navigationService = locator<NavigationService>();
  final _storageService = locator<LocalStorageService>();

  String _logoUrl = 'assets/images/zc_logo2.png';
  String _logoUrlG = 'assets/images/google.png';
  String _logoUrlF = 'assets/images/facebook.png';
  String _logoUrlT = 'assets/images/twitter.png';
  double _logoWidth = 5.0;
  double _logoHeight = 5.0;
  String _title = 'Unlimited Team Collaboration Platform';
  String _subTitle =
      'Unlimited team collaboration platform with emphasis on team building,\n fun, team manageent and above all, project management.';
  String _signIn = 'Sign in';
  String _email = 'Email';
  String _password = 'Password';
  String _emailhint = 'password@gmail.com';
  String _hint = 'password';
  String _circularImage = 'assets/images/circularImage.png';
  String get circularImage => _circularImage;

  String get logoUrl => _logoUrl;
  String get logoUrlG => _logoUrlG;

  String get title => _title;
  String get subTitle => _subTitle;
  String get signIn => _signIn;
  String get logoUrlF => _logoUrlF;
  String get logoUrlT => _logoUrlT;

  double get logoWidth => _logoWidth;

  double get logoHeight => _logoHeight;

  String get emailhint => _emailhint;

  String get email => _email;
  String get password => _password;
  String get hint => _hint;

  String emailText = '';
  String passwordText = '';

  void emailChanged(String? value) {
    emailText = value!;
  }

  void passwordChanged(String? value) {
    passwordText = value!;
  }

  void goToHome() {
    if (emailText.isEmpty) {
      _navigationService.navigateTo(Routes.homeView);
      return;
    }

    _storageService.saveToDisk(testLocalKey, emailText);

    _navigationService.navigateTo(Routes.homeView);
  }
}
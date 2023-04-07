import 'package:flutter/cupertino.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_provider/session_data_provider.dart';
import 'package:themoviedb/services/navigation/navigation_service.dart';
import 'package:themoviedb/services/validate_service.dart';

class AuthModel extends ChangeNotifier {
  final _sessionDataProvider = SessionDataProvider();
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool isValid = true;
  bool isRequest = false;
  String errorText = '';
  final _apiClient = ApiClient();

  auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;
    if (!(ValidateService.isValidateLogin(login) &&
        ValidateService.isPasswordValid(password))) {
      isValid = false;
      errorText = 'Неверний логин или пароль';
      notifyListeners();
      return;
    }
    isValid = true;
    isRequest = true;
    notifyListeners();
    var sessionId = '';
    try {
      sessionId = await _apiClient.auth(login: login, password: password);
    } catch (_) {
      errorText = 'введи правильно';
      isValid = false;
      isRequest = false;
      notifyListeners();
      return;
    }
    _sessionDataProvider.setSessionId(sessionId);

    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .pushReplacementNamed(MainNavigationRoutesName.mainScreen);
    // notifyListeners();
    //
  }
}

//MARK: -Inherited-
class AuthProvider extends InheritedNotifier<AuthModel> {
  final AuthModel model;
  const AuthProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child, notifier: model);

  static AuthProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

  static AuthProvider? read(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
    return widget is AuthProvider ? widget : null;
  }
}

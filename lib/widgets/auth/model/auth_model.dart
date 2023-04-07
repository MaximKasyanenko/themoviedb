import 'dart:io';
import 'package:flutter/material.dart';
import 'package:themoviedb/domain/auth_api_client/auth_api_client.dart';
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
  final _apiClient = AuthApiClient();

  auth(BuildContext context) async {
    errorMessage(String message) {
      errorText = message;
      isValid = false;
      isRequest = false;
      notifyListeners();
    }

    final login = loginTextController.text;
    final password = passwordTextController.text;
    if (!(ValidateService.isValidateLogin(login) &&
        ValidateService.isPasswordValid(password))) {
      isValid = false;
      errorText = 'Невалидный логин или пароль';
      notifyListeners();
      return;
    }
    isValid = true;
    isRequest = true;
    notifyListeners();
    var sessionId = '';
    try {
      sessionId = await _apiClient.auth(login: login, password: password);
    } on ApiClientException catch (error) {
      errorMessage(error.message);
      return;
    } on SocketException {
      errorMessage('Проверьте интернет');
      return;
    } catch (error) {
      errorMessage(error.toString());
      return;
    }
    _sessionDataProvider.setSessionId(sessionId);
    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .pushReplacementNamed(MainNavigationRoutesName.mainScreen);
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

import 'package:themoviedb/domain/data_provider/session_data_provider.dart';

class MainAppModel {
  final _sessionProvider = SessionDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final sessionId = await _sessionProvider.getSessionId();
    _isAuth = sessionId != null;
    // sessionId
    //     .then((_) => _isAuth = true)
    //     .onError((error, stackTrace) => _isAuth = true);
  }
}

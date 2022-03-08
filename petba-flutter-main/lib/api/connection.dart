import 'dart:io';

class InternetConnection {
  static InternetConnection _instance;
  static InternetConnection getInstance() => _instance ??= InternetConnection();
  status() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return ConnectionStatus(status: ConnectionStatus.online);
      }
    } on SocketException catch (_) {
      return ConnectionStatus(status: ConnectionStatus.offline);
    }
  }
}

class ConnectionStatus {
  final String status;
  ConnectionStatus({this.status});
  static String online = "Online";
  static String offline = "Offline";
}

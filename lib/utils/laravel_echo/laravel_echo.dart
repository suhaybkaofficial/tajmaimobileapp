import 'package:laravel_echo/laravel_echo.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:shop_o/core/remote_urls.dart';

class LaravelEcho {
  static LaravelEcho? _singleton;
  static late Echo _echo;
  final String token;

  LaravelEcho._({
    required this.token,
  }) {
    _echo = createLaravelEcho(token);
  }

  factory LaravelEcho.init({
    required String token,
  }) {
    if (_singleton == null || token != _singleton?.token) {
      _singleton = LaravelEcho._(token: token);
    }

    return _singleton!;
  }

  static Echo get instance => _echo;

  static String get socketId => _echo.socketId() ?? "11111.11111111";
}

// app_id = "1338069"
// key = "e013174602072a186b1d"
// secret = "46de951521010c14b205"
// cluster = "mt1

class PusherConfig {
  // static String appId = "1569059";
  // static String key = "f3a19752d50b8d5afe04";
  // static String secret = "3ef27a781572b5ea3b92";
  // static String cluster = "ap2";
  static String appId = "";
  static String key = "";
  static String secret = "";
  static String cluster = "";
  static const hostEndPoint = RemoteUrls.baseUrl;
  static const hostAuthEndPoint = "${hostEndPoint}broadcasting/auth";
  static const port = 6001;
  // PusherConfig._(
  //     {required String id,
  //     required String key,
  //     required String secretId,
  //     required String clusterId}) {
  //   appId = id;
  //   key = key;
  //   secret = secretId;
  //   cluster = clusterId;
  // }

}

PusherClient createPusherClient(String token) {
  PusherOptions options = PusherOptions(
    wsPort: PusherConfig.port,
    encrypted: true,
    host: PusherConfig.hostEndPoint,
    cluster: PusherConfig.cluster,
    auth: PusherAuth(
      PusherConfig.hostAuthEndPoint,
      headers: {
        'Authorization': "Bearer $token",
        'Content-Type': "application/json",
        'Accept': 'application/json'
      },
    ),
  );

  PusherClient pusherClient = PusherClient(
    PusherConfig.key,
    options,
    autoConnect: false,
    enableLogging: true,
  );

  return pusherClient;
}

Echo createLaravelEcho(String token) {
  return Echo(
    client: createPusherClient(token),
    broadcaster: EchoBroadcasterType.Pusher,
  );
}

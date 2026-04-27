import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<bool> requestAllPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
      Permission.microphone,
      Permission.activityRecognition,
      Permission.sensors,
    ].request();

    return statuses.values.every((status) => status.isGranted);
  }
}
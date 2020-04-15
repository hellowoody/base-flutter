import 'dart:io';
import 'package:device_info/device_info.dart';

class Device {
  static Map<String,dynamic> _map;

  static Future<Map<String,dynamic>> get deviceInfo async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _createAndoridInfo(androidInfo);
    }else if(Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      _createIosInfo(iosInfo);
    }
    return _map;
  }

  static void _createAndoridInfo(AndroidDeviceInfo data){
    _map = <String, dynamic>{
      'deviceId':data.androidId,
      'version.securityPatch': data.version.securityPatch,
      'version.sdkInt': data.version.sdkInt,
      'version.release': data.version.release,
      'version.previewSdkInt': data.version.previewSdkInt,
      'version.incremental': data.version.incremental,
      'version.codename': data.version.codename,
      'version.baseOS': data.version.baseOS,
      'board': data.board,
      'bootloader': data.bootloader,
      'brand': data.brand,
      'device': data.device,
      'display': data.display,
      'fingerprint': data.fingerprint,
      'hardware': data.hardware,
      'host': data.host,
      'id': data.id,
      'manufacturer': data.manufacturer,
      'model': data.model,
      'product': data.product,
      'supported32BitAbis': data.supported32BitAbis,
      'supported64BitAbis': data.supported64BitAbis,
      'supportedAbis': data.supportedAbis,
      'tags': data.tags,
      'type': data.type,
      'isPhysicalDevice': data.isPhysicalDevice,
      'androidId': data.androidId,
    };
  }

  static void _createIosInfo(IosDeviceInfo data){
    _map = <String, dynamic>{
      'deviceId':data.identifierForVendor,
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}
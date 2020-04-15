import 'dart:convert';
import 'package:base/kits/Device.dart';
import 'package:base/kits/SharedPreferences.dart' as sp;
import 'package:http/http.dart' as http;

String baseUrl = "http://localhost:9060/api";
class HttpKit {
  static void post(String api,Map<String,dynamic> params,Function successCallback,Function errorCallBack) async {
    try {
      Map<String,dynamic> deviceInfo = await Device.deviceInfo;
      params["deviceId"] = deviceInfo["deviceId"];
      params["sessionId"] = await sp.getString("sessionId");
      Map<String,dynamic> _formdata = {
        "param":jsonEncode(params)
      };
      http.Response res =await http.post(baseUrl+api,body: _formdata);
      if(successCallback != null){
        if(res.statusCode == 200 ){
          Utf8Decoder decode = new Utf8Decoder();
          successCallback(json.decode(decode.convert(res.bodyBytes)));
        }else{
          print(res.statusCode);
        }
      }
    }catch(e) {
      if(errorCallBack != null) {
        errorCallBack(e);
      }
    }
  }
}
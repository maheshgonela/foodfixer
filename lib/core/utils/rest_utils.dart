import 'dart:convert';

import 'package:foodfixer/core/utils/string_utils.dart';

class RestUtils {
  static Uri constructUri(String baseUrl, [Map<String, dynamic>? params]) {
    final String url = baseUrl.replaceAll('https://', '').replaceAll('http://', '');
    final Map<String, String> urlParams = <String, String>{};

    params?.forEach((String key, value) {
      urlParams[key] = value.toString();
    });
    final isIPV4Add = StringUtils.isIPv4(url.split('/').first);
    final strParams = encodeParams(urlParams);
    if(isIPV4Add) {
      final fullUrl = 'http://'.concat(url, strParams);
      return Uri.parse(fullUrl);
    }
    final fullUrl = 'https://'.concat(url, strParams);
    return Uri.parse(fullUrl);
  }

  static String encodeParams(Map<String, String> params) {
    final StringBuffer sb = StringBuffer();
    params.forEach((key, value) {
      if (value.isNotEmpty && value != 'null') {
        sb.isEmpty ? sb.write('?') : sb.write('&');
        sb.write('$key=$value');
      }
    });

    return sb.toString();
  }

  static String basicAuth(String username, String password) {
    assert(username.isNotEmpty, 'Username can not be empty');
    assert(password.isNotEmpty, 'Password can not be empty');

    return 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  }

  static String withAnd(List<String> values) => values
      .where((String element) => element.containsValidValue)
      .join(' and ');
  static String withOr(List<String> values) =>
      values.where((String element) => element.containsValidValue).join(' or ');
}

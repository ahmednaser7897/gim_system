import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'api_urls.dart';

void dPrint(String message, {int level = 1, String? tag}) {
  if (kDebugMode) {
    var a = StackTrace.current;
    final regexCodeLine = RegExp(r" (\(.*\))$");
    var i = regexCodeLine
        .stringMatch(a.toString().split("\n")[level])
        .toString()
        .replaceAll("(", "")
        .replaceAll(")", "")
        .trim() /*.split("/")*/;
    var tPrent = "$i\n${tag != null ? tag + ": " : ""}$message";
    if (message.length > 1800) {
      log(tPrent);
    } else {
      print(tPrent);
    }
  }
}

String getImageUrl(String? url) {
  if (url != null) {
    return ApiUrls.imageBaseUrl + url;
  } else {
    return '';
  }
}

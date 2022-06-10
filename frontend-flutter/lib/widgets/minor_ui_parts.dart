import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showLoading(BuildContext context) {
  return const CircularProgressIndicator(
    color: Colors.red,
  );
}

manualToastMsg(msg) {
  return Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.teal,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM);
}

import 'package:flutter/cupertino.dart';

class FormKeyManager {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> getLoginFormKey() {
    return _loginFormKey;
  }
}

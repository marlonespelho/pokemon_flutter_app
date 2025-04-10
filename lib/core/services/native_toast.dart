import 'package:flutter/services.dart';
import 'package:pokemon_app/core/design/widgets/main.dart';
import 'package:pokemon_app/generated/l10n.dart';

class NativeToast {
  static const MethodChannel _channel = MethodChannel('pokemon/toast');

  static Future<void> showToast(String message) async {
    try {
      await _channel.invokeMethod('showToast', {'message': message});
    } on PlatformException catch (e) {
      showSnackBarMessage(
        message: S.current.showToastErrorMessage,
        type: SnackBarTypeEnum.error,
      );
    }
  }
}

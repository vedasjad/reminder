import 'package:fluttertoast/fluttertoast.dart';
import 'package:reminder/core/theme/colors.dart';

showToast(String message) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.blue,
    textColor: AppColors.white,
    fontSize: 16.0,
  );
}

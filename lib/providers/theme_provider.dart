import 'package:flutter/cupertino.dart';

class ThemeProvider extends ChangeNotifier {
  String bgImage = 'assets/images/dark.jpg';
  Color textColor = const Color(0xffffd8d8);
  Color bgQuestionColor = const Color(0xffffffff).withOpacity(0.3);

  changeTheme(bool isDark) {
    if (isDark) {
      bgImage = 'assets/images/dark.jpg';
      textColor = const Color(0xffffffff);
      bgQuestionColor = const Color(0xffffffff).withOpacity(0.3);
    } else {
      bgImage = 'assets/images/light.jpg';
      textColor = const Color(0xff000000).withOpacity(0.7);
      bgQuestionColor = const Color(0xff000000).withOpacity(0.3);
    }
    notifyListeners();
  }
}
 
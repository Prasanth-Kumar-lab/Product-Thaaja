import 'package:get/get.dart';

class Language {
  final String name;
  final String flag;

  Language(this.name, this.flag);
}

class LanguageController extends GetxController {
  var languages = <Language>[
    Language('Hindi', 'assets/hindi.png'),
    Language('English', 'assets/english.png'),
    Language('Spanish', 'assets/spanish.png'),
    Language('Russian', 'assets/russian.png'),
    Language('Bangla', 'assets/bangla.png'),
    Language('Korean', 'assets/korean.png'),
    Language('Hindi', 'assets/hindi.png'),
    Language('English', 'assets/english.png'),
    Language('Spanish', 'assets/spanish.png'),
    Language('Russian', 'assets/russian.png'),
    Language('Bangla', 'assets/bangla.png'),
    Language('Korean', 'assets/korean.png'),
  ].obs;

  var selectedIndex = 0.obs;

  void selectLanguage(int index) {
    selectedIndex.value = index;
  }
}
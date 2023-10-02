class Validations {
  static bool isOnlyNumber(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  static bool isOnlyArabicNumber(String? s) {
    var arNumbers = '٠١٢٣٤٥٦٧٨٩'.split('');
    if (s == null) {
      return false;
    }
    return s.split('').every((element) => arNumbers.contains(element));
  }

  static RegExp emailRegix =
      RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?)*$");
  static RegExp capitalLettersRegix = RegExp(r'^(?=.*?[A-Z]).{1,}$');
  static RegExp smallLettersRegix = RegExp(r'^(?=.*?[a-z]).{1,}$');
  static RegExp numbersRegix = RegExp(r'^(?=.*?[0-9]).{1,}$');
  static RegExp arabic = RegExp(r'^[ّء-ي 0-9]+$');

  static RegExp english = RegExp('[a-zA-Z]');

  // static String? emailValidation(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return MyApp.tr.pleaseEnterEmail;
  //   }
  //   if (!emailRegix.hasMatch(value)) {
  //     return MyApp.tr.pleaseEnterCorrectEmail;
  //   } else {
  //     return null;
  //   }
  // }

  // static String? numberValidation(
  //     {String? value, required String name, bool isInt = false}) {
  //   RegExp specialcharactersRegex =
  //       RegExp(r'^(?=.*[*"!@#$%^&(){}:;<>,?/~_+-]).{1,}$');
  //   if (value == null || value.isEmpty) {
  //     print(value);
  //     return '${MyApp.tr.pleaseEnter} $name';
  //   }
  //   if (value.contains(' ')) {
  //     return ' $name ${MyApp.tr.mustNotHaveSpace} ';
  //   }
  //   if (isInt) {
  //     if (int.tryParse(value) == null) {
  //       return ' $name ${MyApp.tr.mustBeInt} ';
  //     }
  //   }
  //   if (capitalLettersRegix.hasMatch(value) ||
  //       smallLettersRegix.hasMatch(value)) {
  //     return ' $name ${MyApp.tr.mustNotHaveLitters} ';
  //   }

  //   if (specialcharactersRegex.hasMatch(value)) {
  //     return ' $name  ${MyApp.tr.mustNotHaveSpecialcharacters}';
  //   } else {
  //     return null;
  //   }
  // }

  // static String? passwordValidation(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return MyApp.tr.pleaseEnterPassword;
  //   }
  //   if (value.length < 6) {
  //     return '${MyApp.tr.pleaseEnter} ${MyApp.tr.passwordMustHaveSixLitters} ';
  //     //return ' من فضلك ادخل كلمة مرور تحتوي علي 6 حروف وارقام';
  //   } else {
  //     if (!capitalLettersRegix.hasMatch(value)) {
  //       return MyApp.tr.passwordHaveCapitalLetters;
  //       //return ' من فضلك ادخل كلمة مرور تحتوي علي حروف كبيره';
  //     } else if (!smallLettersRegix.hasMatch(value)) {
  //       return MyApp.tr.passwordHaveSmallLetters;
  //       //return ' من فضلك ادخل كلمة مرور تحتوي علي حروف صغيره' ;
  //     } else if (!numbersRegix.hasMatch(value)) {
  //       return MyApp.tr.passwordHaveNumber;
  //       //return ' من فضلك ادخل كلمة مرور تحتوي علي ارقام';
  //     } else {
  //       return null;
  //     }
  //   }
  // }

  // static String? userNameValidation(
  //     {String? value,
  //     required String name,
  //     int? index,
  //     bool building = false}) {
  //   RegExp specialcharactersRegex =
  //       RegExp(r'^(?=.*[*".!@#$%^&(){}:;<>,.?/~_+-]).{1,}$');
  //   if (value == null || value.isEmpty) {
  //     return '${MyApp.tr.pleaseEnter} $name';
  //   }
  //   if (value[0] == ' ') {
  //     return '$name ${MyApp.tr.mustNotHaveSpace}';
  //   }
  //   if (value.length < 2 && building == false) {
  //     return '$name ${MyApp.tr.mustNotBeLessThentwoLitters}';
  //   } else if (isOnlyNumber(value)) {
  //     return '$name ${MyApp.tr.mustNotHaveNumbrsOnly}';
  //   } else if (isOnlyArabicNumber(value)) {
  //     return '$name ${MyApp.tr.mustNotHaveNumbrsOnly}';
  //   } else if (specialcharactersRegex.hasMatch(value)) {
  //     return '$name ${MyApp.tr.mustNotHaveSpecialcharacters}';
  //   } else if (english.hasMatch(value) && index == 1) {
  //     return MyApp.tr.typeInArabic;
  //   } else if (!english.hasMatch(value) && index == 0) {
  //     return MyApp.tr.typeInEnglish;
  //   } else {
  //     return null;
  //   }
  // }

  // static String? mobileValidation(
  //     {required String? value, required String countryCode}) {
  //   RegExp specialcharactersRegex =
  //       RegExp(r'^(?=.*[*".!@#$%^&(){}:;<>,.?/~_+-]).{1,}$');
  //   if (value == null || value.isEmpty) {
  //     return '${MyApp.tr.pleaseEnter} ${MyApp.tr.phone}';
  //   }
  //   if (value.startsWith(countryCode)) {
  //     return '${MyApp.tr.phone} ${MyApp.tr.mustNotStartWithCountryCode}';
  //   }
  //   if (value.contains(' ')) {
  //     return '${MyApp.tr.phone} ${MyApp.tr.mustNotHaveSpace}';
  //     //return 'رقم الهاتف يجب الا يحتوي علي مسافه';
  //   }
  //   if (capitalLettersRegix.hasMatch(value) ||
  //       smallLettersRegix.hasMatch(value)) {
  //     return '${MyApp.tr.phone} ${MyApp.tr.mustNotHaveLitters}';
  //     //return 'رقم الهاتف يجب الا يحتوي علي حروف';
  //   }
  //   if (specialcharactersRegex.hasMatch(value)) {
  //     return '${MyApp.tr.phone} ${MyApp.tr.mustNotHaveSpecialcharacters}';
  //     //return 'رقم الهاتف يجب الا يحتوي علي حروف مميزه';
  //   }
  //   if (value.length > 11) {
  //     return '${MyApp.tr.phone} ${MyApp.tr.mustNotBeMoreThenEleven}';
  //     //return 'رقم الهاتف يجب الا يحتوي علي حروف مميزه';
  //   }

  //   return null;
  // }

  // static String? confirmValidation(String? value, String input) {
  //   if (value == null || value.isEmpty) {
  //     return MyApp.tr.pleaseEnterPasswordAgien;
  //   }
  //   if (value != input) {
  //     return MyApp.tr.passwordMustMach;
  //   } else {
  //     return null;
  //   }
  // }

  // static String? discValidation(String? value, int? index) {
  //   if (value == null || value.isEmpty) {
  //     return "${MyApp.tr.pleaseEnter} ${MyApp.tr.productDescription}";
  //   } else if (english.hasMatch(value) && index == 1) {
  //     return MyApp.tr.typeInArabic;
  //   } else if (!english.hasMatch(value) && index == 0) {
  //     return MyApp.tr.typeInEnglish;
  //   } else {
  //     return null;
  //   }
  // }
}

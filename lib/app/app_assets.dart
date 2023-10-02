class AppAssets {
  static const String iconsPath = "assets/icons/";
  static const String imagesPath = "assets/images/";

  /// SVG icons
  static String addIcon = "${iconsPath}add_icon.svg";

  /// App Images
  static String appLogo = "${imagesPath}logo.png";

  /// example to how make assets aware of app brightness
  // static String get homeHeaderBg =>
  //     MyApp.isDark ? '${imagesPath}updateprofile.png' : "${imagesPath}background2.png";

  static const String defaultImage =
      'https://www.w3schools.com/howto/img_avatar.png';
  static const String defaultImage2 =
      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';
  static const String defaultSchool =
      "https://media.istockphoto.com/id/1319938106/vector/school-building-facade-with-green-grass-and-trees-public-educational-institution-exterior.jpg?s=612x612&w=0&k=20&c=DwOHvs1pe1DemAymxwS6qg7nrgTw0CwLum_sqfB-H3U=";
  static const String defaultAdmin =
      "https://firebasestorage.googleapis.com/v0/b/teatcher-f4b3a.appspot.com/o/default%20images%2Fadmin.jpeg?alt=media&token=934e481f-986f-4660-a264-aaf751dfc5d8";
  static const String defaultSupervisor =
      "https://firebasestorage.googleapis.com/v0/b/teatcher-f4b3a.appspot.com/o/default%20images%2Fsupervisor.jpeg?alt=media&token=298b368b-aae3-4a77-89ac-6d8cd736803c";
  static const String defaultTeacher =
      "https://firebasestorage.googleapis.com/v0/b/teatcher-f4b3a.appspot.com/o/default%20images%2Fteacher.jpeg?alt=media&token=695871f6-5f72-457d-8a01-d1231be59208";
  static const String defaultChildren =
      "https://firebasestorage.googleapis.com/v0/b/teatcher-f4b3a.appspot.com/o/default%20images%2Fstudent.jpeg?alt=media&token=2e1c7cbc-37c8-4c6f-a1f2-08e7bda64719";
  static const String defaultChildren01 =
      "https://firebasestorage.googleapis.com/v0/b/teatcher-f4b3a.appspot.com/o/default%20images%2Fstudent.jpeg?alt=media&token=2e1c7cbc-37c8-4c6f-a1f2-08e7bda64719";
}

class JsonAssets {
  static const String jsonPath = "assets/json";
  static const String splash = "$jsonPath/splash.json";
  static const String loading = "$jsonPath/loading.json";
  static const String error = "$jsonPath/error.json";
  static const String empty = "$jsonPath/empty.json";
  static const String success = "$jsonPath/success.json";
}

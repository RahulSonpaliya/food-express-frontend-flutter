class PreferenceKeys {
  static const PreferenceKeys ACCESS_TOKEN =
      PreferenceKeys._("ACCESS_TOKEN");
  static const PreferenceKeys DEVICE_ID = PreferenceKeys._("DEVICE_ID");
  static const PreferenceKeys MENU_ITEM_SELECTED_INDEX =
      PreferenceKeys._("MENU_ITEM_SELECTED_INDEX");
  static const PreferenceKeys PROCESS_ID = PreferenceKeys._("PROCESS_ID");
  static const PreferenceKeys NOTIFICATION_COUNT =
      PreferenceKeys._("NOTIFICATION_COUNT");

  /*SIGN IN KEYS*/
  static const PreferenceKeys USER_EMAIL = PreferenceKeys._("USER_EMAIL");
  static const PreferenceKeys USER_PASSWORD =
      PreferenceKeys._("USER_PASSWORD");
  static const PreferenceKeys REMEMBER_ME =
      PreferenceKeys._("REMEMBER_ME");
  static const PreferenceKeys PHONE_NUMBER =
      PreferenceKeys._("PHONE_NUMBER");
  static const PreferenceKeys USER_NAME = PreferenceKeys._("USER_NAME");
  static const PreferenceKeys USER_IMAGE_URL =
      PreferenceKeys._("USER_IMAGE_URL");
  static const PreferenceKeys USER_ID = PreferenceKeys._("USER_ID");
  static const PreferenceKeys USER_DATA = PreferenceKeys._("USER_DATA");
  static const PreferenceKeys USER_ADDRESS_DATA =
      PreferenceKeys._("USER_ADDRESS_DATA");
  static const PreferenceKeys STATE_LIST = PreferenceKeys._("STATE_LIST");
  static const PreferenceKeys APP_LANGUAGE =
      PreferenceKeys._("APP_LANGUAGE");
  static const PreferenceKeys FIRST_TIME = PreferenceKeys._("FIRST_TIME");
  static const PreferenceKeys FIRST_TIME_ACCESS_LOCATION =
      PreferenceKeys._("FIRST_TIME_ACCESS_LOCATION");
  static const PreferenceKeys GUEST_USER = PreferenceKeys._("GUEST_USER");
  final String text;

  const PreferenceKeys._(this.text);

  String getKey() => text;
}

class AppConfig {
  static const bool enableAlice =
      bool.fromEnvironment('ENABLE_ALICE', defaultValue: false);
}

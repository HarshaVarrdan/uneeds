class TempValues {
  static final TempValues _instance = TempValues._internal();
  factory TempValues() => _instance;

  TempValues._internal();

  Map<String, dynamic> temp = {};
}

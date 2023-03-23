class DataManager {

  DataManager._privateConstructor();

  static final DataManager _instance = DataManager._privateConstructor();

  static DataManager get instance => _instance;

  String requestToken = '';
}
import 'package:get_storage/get_storage.dart';

class LocalStorageService {
  final box = GetStorage();

  Future<void> write(String key, dynamic value) async {
    await box.write(key, value);
  }

  dynamic read(String key) => box.read(key);
}

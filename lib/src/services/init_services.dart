import 'package:st_test_app/src/services/characters_service.dart';
import 'package:get/get.dart';

class InitServices {
  static void init() {
    Get.put<GetConnect>(GetConnect()); // Inicialización GetConnect
    Get.put<CharactersService>(CharactersService());
  }
}

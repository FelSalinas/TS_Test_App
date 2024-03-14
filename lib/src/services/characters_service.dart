import 'package:st_test_app/src/models/characters_model.dart';
import 'package:st_test_app/src/utils/globals.dart';
import 'package:get/get.dart';

class CharactersService extends GetxService {
  final GetConnect connect = Get.find<GetConnect>();
  late List<Result> result = [];
  bool completeItems = false;
  int limit = 20;

  void reset() {
    result.clear();
    limit = 20;
  }

  void nextPage() => limit = 10;

  Future<CharactersModel> getCharacters(String search) async {
    try {
      final paramSearch = search != '' ? '&nameStartsWith=$search' : '';
      final paramOffset = result.isNotEmpty ? '&offset=${result.length}' : '';
      final Response response = await connect.get(
        '${Globals().urlApi}$paramSearch&limit=$limit$paramOffset',
      );
      final data = CharactersModel.fromJson(response.body['data']);
      completeItems = data.count < 10;
      result = result + data.results;
      return data;
    } catch (e) {
      return CharactersModel.fromJson({});
    }
  }
}

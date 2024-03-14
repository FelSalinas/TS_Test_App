import 'package:get/get.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'es_MX': {
          'title': 'Marvel App',
          'characters': 'Personajes de Marvel',
          'details': 'Detalles',
          'empty_description': 'Sin descripción',
          'empty_items': 'No se han encontrado personajes',
          'total_items': 'Total: @total',
          'loaded_items': 'Cargados: @total',
        },
      };
}

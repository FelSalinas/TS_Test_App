import 'package:st_test_app/src/models/characters_model.dart';
import 'package:st_test_app/src/pages/details_screen.dart';
import 'package:st_test_app/src/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCard extends StatelessWidget {
  final Result character;

  const CustomCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => DetailsScreen(character: character)),
      child: SizedBox(
        width: (Get.width / 2) - 8,
        height: 350,
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 200,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    _buildPath(character.thumbnail),
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : const Center(child: CircularProgressIndicator()),
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.black26,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8).copyWith(bottom: 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 48,
                      child: Text(
                        character.name,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      character.description != ''
                          ? character.description
                          : 'empty_description'.tr,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _buildPath(Thumbnail data) {
  return '${data.path}/${Globals().imgTypeCard}.${data.extension}';
}

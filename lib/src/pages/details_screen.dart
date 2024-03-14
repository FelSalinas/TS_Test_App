import 'package:st_test_app/src/models/characters_model.dart';
import 'package:st_test_app/src/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatelessWidget {
  final Result character;

  const DetailsScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              width: double.infinity,
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                character.description != ''
                    ? character.description
                    : 'empty_description'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _buildPath(Thumbnail data) {
  return '${data.path}/${Globals().imgTypeDetails}.${data.extension}';
}

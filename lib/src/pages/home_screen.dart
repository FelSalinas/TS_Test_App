import 'package:st_test_app/src/services/characters_service.dart';
import 'package:st_test_app/src/models/characters_model.dart';
import 'package:st_test_app/src/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CharactersService charactersServ = Get.find<CharactersService>();
  final ScrollController scrollController = ScrollController();
  late Future<CharactersModel> dataCharacters;
  Timer? _debounceSearch;

  TextEditingController searchController = TextEditingController();
  RxBool isSearching = false.obs;

  Future _loadList() async {
    dataCharacters = charactersServ.getCharacters(searchController.text);
    setState(() {});
  }

  Timer _handlerDebounce(Timer? debounce, VoidCallback action) {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () => action());
    return debounce;
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange &&
        !charactersServ.completeItems) {
      charactersServ.nextPage();
      _loadList();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadList();
    scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        toolbarHeight: 70,
        title: Column(
          children: [
            Obx(
              () => SizedBox(
                // Input de búsqueda
                height: 32,
                child: isSearching.value
                    ? TextFormField(
                        autofocus: true,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        controller: searchController,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.zero,
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (searchController.text.isNotEmpty) {
                                searchController.clear();
                                charactersServ.reset();
                                _loadList();
                              }
                              isSearching.value = false;
                            },
                            child: const Icon(Icons.close_rounded),
                          ),
                        ),
                        onEditingComplete: () =>
                            FocusScope.of(context).unfocus(),
                        onChanged: (value) {
                          charactersServ.reset();
                          _debounceSearch = _handlerDebounce(
                            _debounceSearch,
                            () async => _loadList(),
                          );
                        },
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('characters'.tr),
                          Obx(
                            () => !isSearching.value
                                ? IconButton(
                                    onPressed: () => isSearching.value = true,
                                    icon: const Icon(Icons.search),
                                  )
                                : Container(),
                          ),
                        ],
                      ),
              ),
            ),
            FutureBuilder(
              future: dataCharacters,
              builder: (context, snapshot) => snapshot.hasData
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'total_items'.trParams(
                              {'total': '${snapshot.data?.total}'},
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'loaded_items'.trParams(
                              {'total': '${charactersServ.result.length}'},
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        // Lista de personajes
        future: dataCharacters,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return charactersServ.result.isNotEmpty
                ? SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: charactersServ.result
                                .map(
                                  (Result item) =>
                                      // Tarjeta de personaje
                                      CustomCard(character: item),
                                )
                                .toList(),
                          ),
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            const Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: CircularProgressIndicator(),
                            )
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      'empty_items'.tr,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

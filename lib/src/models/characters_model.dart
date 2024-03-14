class CharactersModel {
  final int offset;
  final int limit;
  final int total;
  final int count;
  final List<Result> results;

  CharactersModel({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });

  factory CharactersModel.fromJson(Map<String, dynamic> json) =>
      CharactersModel(
        offset: json["offset"],
        limit: json["limit"],
        total: json["total"],
        count: json["count"],
        results: json["results"] != null
            ? List<Result>.from(
                json["results"].map((x) => Result.fromJson(x)),
              )
            : [],
      );
}

class Result {
  final int id;
  final String name;
  final String description;
  final String modified;
  final Thumbnail thumbnail;

  Result({
    required this.id,
    required this.name,
    required this.description,
    required this.modified,
    required this.thumbnail,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        modified: json["modified"],
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
      );
}

class Thumbnail {
  final String path;
  final String extension;

  Thumbnail({
    required this.path,
    required this.extension,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        path: json["path"],
        extension: json["extension"],
      );
}

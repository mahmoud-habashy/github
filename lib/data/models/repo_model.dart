class RepoModel {
  int id;
  String name;
  String? description;
  String? language;
  RepoLicense? license;
  int forksCount;
  int watchersCount;
  String htmlUrl;
  String? createdAt;
  String? updatedAt;

  RepoModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.language,
      required this.license,
      required this.forksCount,
      required this.watchersCount,
      required this.htmlUrl,
      required this.createdAt,
      required this.updatedAt});

  factory RepoModel.fromJson(Map<String, dynamic> json) => RepoModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        language: json["language"],
        license: json["license"] != null
            ? RepoLicense.fromJson(json["license"])
            : null,
        forksCount: json["forks_count"],
        watchersCount: json["watchers_count"],
        htmlUrl: json["html_url"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "language": language,
        "license": license?.toJson(),
        "forks_count": forksCount,
        "watchers_count": watchersCount,
        "html_url": htmlUrl,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  static List<RepoModel> listFromJson(List<dynamic> repos) {
    return repos.map((repo) => RepoModel.fromJson(repo)).toList();
  }
}

class RepoLicense {
  String key;
  String name;
  String? url;

  RepoLicense({
    required this.key,
    required this.name,
    required this.url,
  });
  factory RepoLicense.fromJson(json) => RepoLicense(
        key: json["key"],
        name: json["name"],
        url: json["url"],
      );
  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
        "url": url,
      };
}

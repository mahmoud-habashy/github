class UserModel {
  String login;
  int id;
  String avatarUrl;
  String htmlUrl;
  String reposUrl;
  String? name;
  String? company;
  String? location;
  String? blog;
  String? email;
  String? bio;
  int publicRepos;
  int followers;
  int following;

  UserModel({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.htmlUrl,
    required this.reposUrl,
    required this.name,
    required this.company,
    required this.location,
    required this.blog,
    required this.email,
    required this.bio,
    required this.publicRepos,
    required this.followers,
    required this.following,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        login: json["login"],
        id: json["id"],
        avatarUrl: json["avatar_url"],
        htmlUrl: json["html_url"],
        reposUrl: json["repos_url"],
        name: json["name"],
        company: json["company"],
        location: json["location"],
        blog: json["blog"],
        email: json["email"],
        bio: json["bio"],
        publicRepos: json["public_repos"],
        followers: json["followers"],
        following: json["following"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "avatar_url": avatarUrl,
        "html_url": htmlUrl,
        "repos_url": reposUrl,
        "name": name,
        "company": company,
        "location": location,
        "blog": blog,
        "email": email,
        "bio": bio,
        "public_repos": publicRepos,
        "followers": followers,
        "following": following,
      };
}

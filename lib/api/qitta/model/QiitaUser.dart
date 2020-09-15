
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'QiitaUser.g.dart';

@JsonSerializable()
class QiitaUser {
  String description;
  @JsonKey(name: 'facebook_id')
  String facebookId;
  @JsonKey(name: 'followees_count')
  int followeesCount;
  @JsonKey(name: 'followers_count')
  int followersCount;
  @JsonKey(name: 'github_login_name')
  String githubLoginName;
  String id;
  @JsonKey(name: 'items_count')
  int itemsCount;
  @JsonKey(name: 'linkedin_id')
  String linkedinId;
  String location;
  String name;
  String organization;
  @JsonKey(name: 'permanent_id')
  int permanentId;
  @JsonKey(name: 'profile_image_url')
  String profileImageUrl;
  @JsonKey(name: 'team_only')
  bool teamOnly;
  @JsonKey(name: 'twitter_screen_name')
  String twitterScreenName;
  @JsonKey(name: 'website_url')
  String websiteUrl;

  QiitaUser({
    this.description,
    this.facebookId,
    this.followeesCount,
    this.followersCount,
    this.githubLoginName,
    this.id,
    this.itemsCount,
    this.linkedinId,
    this.location,
    this.name,
    this.organization,
    this.permanentId,
    this.profileImageUrl,
    this.teamOnly,
    this.twitterScreenName,
    this.websiteUrl,
  });

  // ↓　ここは.g.dartを自動生成してから追記
  // （注意）先に書いておいてもエラーとなりg.dartが生成されないことがある？
  factory QiitaUser.fromJson(Map<String, dynamic> json) => _$QiitaUserFromJson(json);
  Map<String, dynamic> toJson() => _$QiitaUserToJson(this);

  @override
  String toString() => json.encode(toJson());

  static final String anonymousUserName = "匿名ユーザ";

  get displayUserName {
    var userName = (this.name ?? "").trim().isEmpty ? anonymousUserName : "${this.name}";
    return "$userNameさん";
  }
  // ↑　ここは.g.dartを自動生成してから追記

}

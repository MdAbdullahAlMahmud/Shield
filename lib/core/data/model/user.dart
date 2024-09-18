import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class UserItem{
  String? uid;
  String? name;
  String? email;
  String? password;

  UserItem({this.uid,this.name, this.email, this.password});

  factory UserItem.fromJson(Map<String, dynamic> json) => _$UserItemFromJson(json);
  Map<String, dynamic> toJson() => _$UserItemToJson(this);

}
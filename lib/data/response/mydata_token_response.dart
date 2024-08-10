import 'package:json_annotation/json_annotation.dart';

part 'mydata_token_response.g.dart';

@JsonSerializable()
class MyDataTokenResponse {
  final String token;

  const MyDataTokenResponse({required this.token});

  factory MyDataTokenResponse.fromJson(Map<String, dynamic> json) => _$MyDataTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyDataTokenResponseToJson(this);
}

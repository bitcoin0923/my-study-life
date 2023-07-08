import 'dart:convert';

class AccessToken {
  int id;
  int expiryDate;
  //String token;
  int iat;
  String refreshToken;

  AccessToken(
      {required this.id,
      required this.expiryDate,
      required this.iat,
      required this.refreshToken});

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(
      id: json['id'],
      expiryDate: json['exp'],
      iat: json['iat'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['exp'] = expiryDate;
    data['iat'] = iat;
    data['refreshToken'] = refreshToken;
    return data;
  }
}



// factory AccessToken.fromReqBody(String body) {
//   Map<String, dynamic> json = body.fromJson();

//   return AccessToken(
//     tokenType: json['token_type'],
//     expiresIn: json['expires_in'],
//     token: json['access_token'],
//     refreshToken: json['refresh_token'],
//   );
// }

// class AccessTokenAdapter extends TypeAdapter<AccessToken> {
//   @override
//   final typeId = 1;

//   @override
//   AccessToken read(BinaryReader reader) {
//     int numOfFields = reader.readByte();
//     Map fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };

//     return AccessToken(
//       expiresIn: fields[1],
//       token: fields[2],
//       refreshToken: fields[3],
//       tokenType: fields[0],
//     );

//     // return AccessToken.fromJson(reader.read() as Map<String, dynamic>);

//     // var json = reader.readMap() as Map<String, dynamic>;
//     // return AccessToken.fromJson(json);

//     // return AccessToken(
//     //     expiresIn: reader.read(),
//     //     token: reader.read(),
//     //     refreshToken: reader.read(),
//     //     tokenType: reader.read());
//   }
// }

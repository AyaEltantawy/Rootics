class UserModel {
  String? imageUrl;
  String? username;
  String? email;
  String? country;
  String? dateOfBirth;
 String? address;

  UserModel(
      {this.imageUrl,
      this.username,
      this.email,
      this.country,
      this.dateOfBirth,
      this.address});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      imageUrl: json['imageUrl'],
      username: json['username'],
      email: json['email'],
      country: json['country'],
      dateOfBirth: json['dateOfBirth'],
      address: json['address'],
    );
  }

}


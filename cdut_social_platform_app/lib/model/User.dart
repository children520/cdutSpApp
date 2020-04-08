class User{
  String userName;
  String phoneNumber;
  String password;
  String sex;
  String collage;

  User({this.userName, this.phoneNumber, this.password, this.sex, this.collage});
  factory User.fromJson(Map<String,dynamic> json){
    return User(
        userName: json['userName'],
        phoneNumber:json['phoneNumber'],
        password:json['password'],
        sex:json['sex'],
        collage:json['collage']
    );
  }
}

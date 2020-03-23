class User{
  String name;
  String phoneNumber;
  String password;
  int sex;
  String collage;

  User({this.name, this.phoneNumber, this.password, this.sex, this.collage});
  factory User.fromJson(Map<String,dynamic> json){
    return User(
        name: json['name'],
        phoneNumber:json['phoneNumber'],
        password:json['password'],
        sex:json['sex'],
        collage:json['collage']
    );
  }
}

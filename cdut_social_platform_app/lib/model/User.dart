class User{
  String userName;
  String email;
  String password;
  String sex;
  String collage;
  String phoneNumber;
  User({this.userName, this.email, this.password, this.sex, this.collage,this.phoneNumber});
  factory User.fromJson(Map<String,dynamic> json){
    return User(
        userName: json['userName'],
        email:json['email'],
        password:json['password'],
        sex:json['sex'],
        collage:json['collage'],
        phoneNumber:json['phoneNumber']
    );
  }
}

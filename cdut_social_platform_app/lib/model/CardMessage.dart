class CardMessage{
  String userName;
  String message;
  CardMessage({
    this.userName,
    this.message
  });
  factory CardMessage.fromjson(Map<String,dynamic> json){
    return CardMessage(
      userName: json['userName'],
      message: json['message']
    );
  }
}
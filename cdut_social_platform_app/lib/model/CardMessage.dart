class CardMessage{
  String userName;
  String message;
  String label;
  int likeNum;
  String date;
  String collage;
  int id;
  CardMessage({
    this.userName,
    this.message,
    this.label,
    this.date,
    this.likeNum,
    this.collage,
    this.id
  });
  factory CardMessage.fromjson(Map<String,dynamic> json){
    return CardMessage(
      userName: json['userName'],
      message: json['message'],
      label: json['label'],
      date: json['date'],
      likeNum: json['likeNum'],
      collage: json['collage'],
      id: json['id']
    );
  }
}
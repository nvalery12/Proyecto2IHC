class Reminder{
  int id;
  String title;
  String subTitle;
  bool isFinish;
  DateTime deadLine = DateTime.now();
  Reminder({this.title,this.subTitle,this.id,this.isFinish});

  Map<String, dynamic> toMap(){
    return {
      "title": title,
      "subtitle": subTitle,
      "finish": isFinish ? 1 : 0,
      "time": deadLine.toString(),
    };
  }

  Reminder.fromMap(Map<String, dynamic> map){
    id= map["id"];
    title= map["title"];
    subTitle=map["subtitle"];
    isFinish= map["finish"] == 1;
    deadLine = DateTime.tryParse(map["time"]);
  }
}
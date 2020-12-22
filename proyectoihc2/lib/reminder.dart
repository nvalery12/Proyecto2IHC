class Reminder{
  int id;
  String title;
  String subTitle;
  bool isFinish;
  DateTime deadLine = DateTime.utc(2020,12,24);
  Reminder({this.title,this.subTitle,this.id});

  String remainigTime(){
    Duration difference = deadLine.difference(DateTime.now());
    var day = difference.inDays;
    return "$day";
  }

  String deadLineDate(){
    var day = this.deadLine.day;
    var month = this.deadLine.month;
    var year = this.deadLine.year;
    return "$day/$month/$year";
  }

  Map<String, dynamic> toMap(){
    return {
      "title": title,
      "subtitle": subTitle,
      "finish": isFinish ? 1 : 0,
      "time": deadLine.toString(),
      "id": id,
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
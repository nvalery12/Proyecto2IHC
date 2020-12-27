class Reminder{
  int id;
  String title;
  String subTitle;
  bool isFinish;
  DateTime deadLine = DateTime.now();
  Reminder({this.title,this.subTitle,this.id,this.isFinish});

  String remainigTime(){
    Duration difference = deadLine.difference(DateTime.now());
    var day = difference.inDays;
    if(day == 0)
      return "Hoy";
    return "$day";
  }

  String deadLineDate(){
    var day = this.deadLine.day;
    var month = this.deadLine.month;
    var year = this.deadLine.year;
    return "$day/$month/$year";
  }

  String deadLineTime(){
    var hour = this.deadLine.hour;
    var minutes = this.deadLine.minute;
    var hourString = timeToString(hour);
    var minutesString = timeToString(minutes);
    return hourString + ":" + minutesString;
  }

  String timeToString(int time){
    String num = time.toString();
    if(time>9){
      return num;
    }else{
      return "0$num";
    }
  }
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
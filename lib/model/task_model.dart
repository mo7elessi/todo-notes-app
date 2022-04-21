import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

class Task{
  late int id;
  late String title;
  late String description;
  late String date;
  late Timestamped time;
  late String state;

  Task(this.title,this.description,this.date,this.time,this.state);
}

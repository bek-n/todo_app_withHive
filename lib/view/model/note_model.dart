import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {
   @HiveField(0)
  final String title;
   @HiveField(1)
  final String date;

  TodoModel({required this.title, required this.date});

  factory TodoModel.fromJson(Map data) {
    return TodoModel(title: data['title'], date: data['date']);
  }

  toJson() {
    return {
      "title": title,
      "date": date,
    };
  }
}

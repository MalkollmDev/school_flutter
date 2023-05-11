class LessonModel {
  int id;
  String name;

  LessonModel(
    {
      required this.id,
      required this.name
    }
  );

  factory LessonModel.fromJson(Map<String, dynamic> parsedJson){
    return LessonModel(
      id: parsedJson['id'],
      name : parsedJson['name']
    );
  }
}
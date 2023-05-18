class HomeworkModel {
  int id;
  String lessonName;
  int numberGroup;
  String task;
  String date;

  HomeworkModel(
    {
      required this.id,
      required this.lessonName,
      required this.numberGroup,
      required this.task,
      required this.date,
    }
  );

  factory HomeworkModel.fromJson(Map<String, dynamic> parsedJson){
    return HomeworkModel(
      id: parsedJson['id'],
      lessonName : parsedJson['lessonName'],
      numberGroup : parsedJson['numberGroup'],
      task : parsedJson['task'],
      date : parsedJson['date'],
    );
  }
}
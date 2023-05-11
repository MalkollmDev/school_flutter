class GroupModel {
  int id;
  String number;

  GroupModel(
    {
      required this.id,
      required this.number
    }
  );

  factory GroupModel.fromJson(Map<String, dynamic> parsedJson){
    return GroupModel(
      id: parsedJson['id'],
      number : parsedJson['number'].toString()
    );
  }
}
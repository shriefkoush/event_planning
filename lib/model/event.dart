class Event{
 static const String collectionName = "Events";
  String id;
  String image;
  String title;
  String description;
  String eventName;
  String time;
  DateTime dateTime;
  bool isFavorite;

  Event({
    this.id = "", required this.title ,required this.description,
  required this.eventName ,required this.image ,required this.time ,
    required this.dateTime , this.isFavorite = false
});

  Event.fromJson(Map<String , dynamic> data ) : this(
    id: data['id'] as String,
    image: data['image'] as String,
    title: data['title'] as String,
    description: data['description'] as String,
    eventName: data['eventName'] as String,
    time: data['time'],
    dateTime: DateTime.fromMillisecondsSinceEpoch(data ['dateTime']) ,
    isFavorite: data['isFavorite'] as bool,
  );


  Map<String, dynamic> toFireStore(){   /// to Json
    return {
      'id' : id ,
      'image' : image ,
      'title' : title ,
      'description' : description ,
      'eventName' : eventName ,
      'time' : time ,
      'dateTime' : dateTime.millisecondsSinceEpoch,
      'isFavorite' : isFavorite
    };
  }


}
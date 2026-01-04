import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_3/model/event.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection (){
   return FirebaseFirestore.instance.collection(Event.collectionName).withConverter<Event>(
        fromFirestore: (snapshot , option)=> Event.fromJson(snapshot.data()!),
        toFirestore: (event,_)=> event.toFireStore()
    );
  }
  static Future<void> addEventToFireStore(Event event){
    CollectionReference<Event> collectionRef = getEventCollection();  ///collection
    DocumentReference<Event> documentRef = collectionRef.doc();   ///document
    event.id = documentRef.id ;   /// auto id
    return documentRef.set(event);
  }
}
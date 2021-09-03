import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:keep_notes_clone_yt/model/MyNoteModel.dart';
import 'db.dart';
class FireDB{
  //CREATE,READ,UPDATE,DELETE
final FirebaseAuth _auth  = FirebaseAuth.instance;

createNewNoteFirestore(Note note) async{
final User? current_user =  _auth.currentUser;
  await FirebaseFirestore.instance.collection("notes").doc(current_user!.email).collection("usernotes").doc(note.id.toString()).set(
  {
    "Title" : note.title,
    "content" : note.content,
    "date" :note.createdTime,

  }).then((_){
    print("DATA ADDED SUCCESSFULLY");
  });


}




getAllStoredNotes() async{
final User? current_user =  _auth.currentUser;
    await FirebaseFirestore.instance.collection("notes").doc(current_user!.email).collection("usernotes").orderBy("date").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      Map note = result.data();
   
      NotesDatabse.instance.InsertEntry(Note(title:note["Title"] , content : note["content"] , createdTime: note["date"] , pin: false, isArchieve: false));  //Add Notes In Database
    });
  });
   
}


updateNoteFirestore(Note note ) async{
final User? current_user =  _auth.currentUser;
   await FirebaseFirestore.instance
        .collection("notes")
        .doc(current_user!.email).collection("usernotes").doc(note.id.toString())
        .update({"title": note.title.toString() , "content" : note.content}).then((_) {
      print("DATA ADDED SUCCESFULLY");
    });
}



deleteNoteFirestore(Note note) async{
  final User? current_user =  _auth.currentUser;
    await FirebaseFirestore.instance.collection("notes").doc(current_user!.email.toString()).collection("usernotes").doc(note.id.toString()).delete().then((_) {
    print("DATA DELETED SUCCESS FULLY");
  });
}
}
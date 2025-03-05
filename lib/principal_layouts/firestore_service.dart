import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';


// class FirestoreService {
//
//   Future<List<DocumentSnapshot>> getDocuments(int limit, DocumentSnapshot? startAfter) async {
//     Query query = _collection.limit(limit);
//
//     if (startAfter != null) {
//       query = query.startAfterDocument(startAfter);
//     }
//
//     QuerySnapshot querySnapshot = await query.get();
//     return querySnapshot.docs;
//   }
// }

class FirestoreService {
  late SharedPreferences preferences;
  late CollectionReference _collectionAllClasses;
  late CollectionReference _collectionAllAnnouncements;

  FirestoreService() {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await _initializePreferences();
      _initializeCollections();
    } catch (e) {
      // Handle initialization errors
      print('Error initializing FirestoreService: $e');
    }
  }

  Future<void> _initializePreferences() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences == null) {
      throw Exception('SharedPreferences could not be initialized');
    }
  }

  void _initializeCollections() {
    final String? schoolCode = preferences.getString('code');
    if (schoolCode == null) {
      throw Exception('School code not found in SharedPreferences');
    }

    _collectionAllClasses = FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolCode)
        .collection("All classes");

    _collectionAllAnnouncements = FirebaseFirestore
        .instance
        .collection("Schools")
        .doc(schoolCode)
        .collection("announcement");
  }

  Future<List<DocumentSnapshot>> getDocumentsOfAllClasses(
      int limit, DocumentSnapshot? startAfter) async {
    Query query = _collectionAllClasses
        .orderBy('classroom', descending: true)
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    QuerySnapshot querySnapshot = await query.get();
    return querySnapshot.docs;
  }

  Future<List<DocumentSnapshot>> getDocumentsOfAllAnnouncements(
      int limit, DocumentSnapshot? startAfter) async {
    Query query = _collectionAllAnnouncements
        .orderBy('timeInMillis', descending: true)
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    QuerySnapshot querySnapshot = await query.get();
    return querySnapshot.docs;
  }
}



// import 'package:connectivity/connectivity.dart';
// import 'package:ed_skool/single_layouts/single_post_look_with_image.dart';
// import 'package:ed_skool/utils/app_size.dart';
// import 'package:ed_skool/utils/app_styles.dart';
// import 'package:flutter/material.dart';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../principal_layouts/firestore_service.dart';
//
// class AnnouncementsFetch extends StatefulWidget {
//   const AnnouncementsFetch({super.key});
//
//   @override
//   State<AnnouncementsFetch> createState() => _AnnouncementsFetchState();
// }
//
// class _AnnouncementsFetchState extends State<AnnouncementsFetch> {
//   final FirestoreService _firestoreService = FirestoreService();
//   final int _batchSize = 10;
//   List<DocumentSnapshot> _documents = [];
//   DocumentSnapshot? _lastDocument;
//   ScrollController _scrollController = ScrollController();
//
//   final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
//   GlobalKey<ScaffoldMessengerState>();
//
//   String internetOrClass = "No announcements yet!";
//
//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//
//     // Add a listener to the scroll controller to detect when reaching the end
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels ==
//           _scrollController.position.maxScrollExtent) {
//         print("scroller called");
//         _loadData();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       scaffoldMessengerKey: scaffoldMessengerKey,
//       home: Scaffold(
//         backgroundColor: Color(0xfff8f3f3),
//         body: _documents.isEmpty
//             ? Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: AppSize.getWidth(100, context),
//                 height: AppSize.getHeight(100, context),
//                 child: Image.asset("assets/images/classroom_photo1.png"),
//               ),
//               Text(
//                 internetOrClass,
//                 style: TextStyle(
//                   fontSize: AppSize.getWidth(22, context),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         )
//             : ListView.builder(
//           controller: _scrollController,
//           itemCount: _documents.length,
//           itemBuilder: (context, index) {
//
//             return Container(
//               margin: EdgeInsets.symmetric(
//                 vertical: AppSize.getHeight(7, context),
//               ),
//               padding: EdgeInsets.symmetric(
//                 vertical: AppSize.getHeight(9, context),
//                 horizontal: AppSize.getWidth(6, context),
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(AppSize.getWidth(10, context)),
//                 ),
//                 color: Colors.white,
//               ),
//               child: InstagramPost(
//                 urlString: _documents[index]['imageUrl'],
//                 caption: _documents[index]['caption'],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Future<bool> isNetworkAvailable() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.none) {
//       return false;
//     } else if (connectivityResult == ConnectivityResult.wifi ||
//         connectivityResult == ConnectivityResult.mobile) {
//       return true;
//     }
//     return false;
//   }
//
//   Future<void> _loadData() async {
//     // Check for internet connectivity
//     bool isInternetAvailable = await isNetworkAvailable();
//
//     if (!isInternetAvailable) {
//       // Handle the case where there is no internet connection
//       scaffoldMessengerKey.currentState?.showSnackBar(
//         const SnackBar(
//           content: Text("Internet error!"),
//         ),
//       );
//       setState(() {
//         internetOrClass = 'Internet not available!';
//       });
//       return;
//     }
//     setState(() {
//       internetOrClass = 'No announcements yet!';
//     });
//
//     print("loaddata called");
//     List<DocumentSnapshot> newDocuments = await _firestoreService
//         .getDocumentsOfAllAnnouncements(_batchSize, _lastDocument);
//
//     // Ensure that newDocuments do not contain duplicates
//     newDocuments.removeWhere(
//             (doc) => _documents.any((existingDoc) => existingDoc.id == doc.id));
//
//     setState(() {
//       _documents.addAll(newDocuments);
//
//       // Check if there are new documents before updating _lastDocument
//       if (newDocuments.isNotEmpty) {
//         _lastDocument = newDocuments.last;
//       } else {
//         // Handle the case where there are no more documents
//         // You might want to disable further loading or show a message.
//         _lastDocument = null;
//       }
//     });
//   }
// }


















































//correct
//
// import 'package:connectivity/connectivity.dart';
// import 'package:ed_skool/single_layouts/single_post_look_with_image.dart';
// import 'package:ed_skool/utils/app_size.dart';
// import 'package:ed_skool/utils/app_styles.dart';
// import 'package:flutter/material.dart';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../principal_layouts/firestore_service.dart';
// import '../single_layouts/single_text_layout_post.dart';
//
// class AnnouncementsFetch extends StatefulWidget {
//   const AnnouncementsFetch({super.key});
//
//   @override
//   State<AnnouncementsFetch> createState() => _AnnouncementsFetchState();
// }
//
// class _AnnouncementsFetchState extends State<AnnouncementsFetch> {
//   final FirestoreService _firestoreService = FirestoreService();
//   final int _batchSize = 5;
//   List<DocumentSnapshot> _documents = [];
//   DocumentSnapshot? _lastDocument;
//   ScrollController _scrollController = ScrollController();
//
//   final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
//   GlobalKey<ScaffoldMessengerState>();
//
//   String internetOrClass = "No announcements yet!";
//
//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//
//     // Add a listener to the scroll controller to detect when reaching the end
//     // _scrollController.addListener(() {
//     //   if (_scrollController.position.pixels ==
//     //       _scrollController.position.maxScrollExtent) {
//     //     print("scroller called");
//     //     _loadData();
//     //   }
//     // });
//     _scrollController.addListener(_scrollListener);
//   }
//   void _scrollListener() {
//     if (_scrollController.position.pixels ==
//         _scrollController.position.maxScrollExtent) {
//       print("scroller called");
//       _loadData();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       scaffoldMessengerKey: scaffoldMessengerKey,
//       home: Scaffold(
//         backgroundColor: Color(0xfff8f3f3),
//         body: _documents.isEmpty
//             ? Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: AppSize.getWidth(100, context),
//                 height: AppSize.getHeight(100, context),
//                 child: Image.asset("assets/images/classroom_photo1.png"),
//               ),
//               Text(
//                 internetOrClass,
//                 style: TextStyle(
//                   fontSize: AppSize.getWidth(22, context),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         )
//             : ListView.builder(
//           controller: _scrollController,
//           itemCount: _documents.length,
//           itemBuilder: (context, index) {
//             String imageUrl = _documents[index]['imageUrl'];
//
//             if (imageUrl == 'nothing') {
//               // If imageUrl is 'nothing', display post without image
//               return Container(
//                 margin: EdgeInsets.symmetric(
//                   vertical: AppSize.getHeight(7, context),
//                 ),
//                 padding: EdgeInsets.symmetric(
//                   vertical: AppSize.getHeight(9, context),
//                   horizontal: AppSize.getWidth(6, context),
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(AppSize.getWidth(10, context)),
//                   ),
//                   color: Colors.white,
//                 ),
//                 child: SingleTextLayoutPost(
//                   caption: _documents[index]['caption'],
//                 ),
//               );
//             } else {
//               // If imageUrl is not 'nothing', display post with image
//               return Container(
//                 margin: EdgeInsets.symmetric(
//                   vertical: AppSize.getHeight(7, context),
//                 ),
//                 padding: EdgeInsets.symmetric(
//                   vertical: AppSize.getHeight(9, context),
//                   horizontal: AppSize.getWidth(6, context),
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(AppSize.getWidth(10, context)),
//                   ),
//                   color: Colors.white,
//                 ),
//                 child: InstagramPost(
//                   urlString: imageUrl,
//                   caption: _documents[index]['caption'],
//                 ),
//               );
//             }
//           },
//         ),
//
//
//       ),
//     );
//   }
//
//   Future<bool> isNetworkAvailable() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.none) {
//       return false;
//     } else if (connectivityResult == ConnectivityResult.wifi ||
//         connectivityResult == ConnectivityResult.mobile) {
//       return true;
//     }
//     return false;
//   }
//
//   Future<void> _loadData() async {
//
//     print("imagehahhaha: load called");
//     // Check for internet connectivity
//     bool isInternetAvailable = await isNetworkAvailable();
//
//     if (!isInternetAvailable) {
//       // Handle the case where there is no internet connection
//       scaffoldMessengerKey.currentState?.showSnackBar(
//         const SnackBar(
//           content: Text("Internet error!"),
//         ),
//       );
//       setState(() {
//         internetOrClass = 'Internet not available!';
//       });
//       return;
//     }
//     setState(() {
//       internetOrClass = 'No announcements yet!';
//     });
//
//     //print("loaddata called");
//     List<DocumentSnapshot> newDocuments = await _firestoreService
//         .getDocumentsOfAllAnnouncements(_batchSize, _lastDocument);
//
//     // Ensure that newDocuments do not contain duplicates
//     newDocuments.removeWhere(
//             (doc) => _documents.any((existingDoc) => existingDoc.id == doc.id));
//
//     setState(() {
//       _documents.addAll(newDocuments);
//
//       // Check if there are new documents before updating _lastDocument
//       if (newDocuments.isNotEmpty) {
//         _lastDocument = newDocuments.last;
//       } else {
//         // Handle the case where there are no more documents
//         // You might want to disable further loading or show a message.
//         _lastDocument = null;
//       }
//     });
//   }
// }



// For full screen use this MediaQuery

//import 'package:flutter/material.dart';

// class InstagramPost extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Instagram Post'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Image
//           Image.network(
//             'https://firebasestorage.googleapis.com/v0/b/edskoolflutter.appspot.com/o/101%2F1707510089414?alt=media&token=d2baae51-1744-40f7-83d1-ece5c1fa5071',
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.width, // Make image square
//             fit: BoxFit.cover,
//           ),
//           // Caption
//           Container(
//             padding: EdgeInsets.all(16),
//             child: Text(
//               'This is the caption for the Instagram post. You can add any text here.',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: InstagramPost(),
//   ));
// }




































// Image.network(
// 'https://firebasestorage.googleapis.com/v0/b/edskoolflutter.appspot.com/o/101%2F1707510089414?alt=media&token=d2baae51-1744-40f7-83d1-ece5c1fa5071',
// loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
// if (loadingProgress == null) {
// return child;
// } else {
// return CircularProgressIndicator(
// value: loadingProgress.expectedTotalBytes != null
// ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
//     : null,
// );
// }
// },
// )












// ListTile(
//   leading: Image.network(
//     _documents[index]['imageUrl'],
//     loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//       try {
//         if (loadingProgress == null) {
//           return child; // Image loaded successfully
//         } else {
//           return CircularProgressIndicator(); // Show loading indicator while image is loading
//         }
//       } catch (e) {
//         return Text('Error loading image'); // Show error message if image failed to load
//       }
//     },
//     errorBuilder: (context, error, stackTrace) {
//       return Text('Error loading image'); // Show error message if image failed to load
//     },
//     width: 50,
//     height: 50,
//     fit: BoxFit.cover,
//   ),
//
//   title: Text(
//     _documents[index]['caption'],
//     style: Styles.headLineStyle2.copyWith(
//       color: Colors.black,
//       fontWeight: FontWeight.w500,
//     ),
//   ),
//   onTap: () {
//     print(' ${_documents[index]['caption']}');
//   },
// ),
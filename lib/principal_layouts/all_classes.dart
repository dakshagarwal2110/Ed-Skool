import 'package:connectivity/connectivity.dart';
import 'package:ed_skool/utils/app_size.dart';
import 'package:ed_skool/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_service.dart';


// Left when principal clicks on a class functionality
class LazyLoadingWidget extends StatefulWidget {
  @override
  _LazyLoadingWidgetState createState() => _LazyLoadingWidgetState();
}

class _LazyLoadingWidgetState extends State<LazyLoadingWidget> {
  final FirestoreService _firestoreService = FirestoreService();
  final int _batchSize = 10;
  List<DocumentSnapshot> _documents = [];
  DocumentSnapshot? _lastDocument;
  ScrollController _scrollController = ScrollController();
  List<String> imagePaths = [
    "assets/images/classroom_photo1.png",
    "assets/images/classroom_photo2.png",
    "assets/images/classroom_photo3.png",
    "assets/images/classroom_photo4.png",
    "assets/images/classroom_photo5.png",
    "assets/images/classroom_photo6.png",
    // Add more paths as needed
  ];
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  String internetOrClass="NO CLASSES YET!";

  @override
  void initState() {
    super.initState();
    _loadData();

    // Add a listener to the scroll controller to detect when reaching the end
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("scroller called");
        _loadData();
      }
    });
  }



  Future<void> _loadData() async {
    // Check for internet connectivity
    bool isInternetAvailable = await isNetworkAvailable();

    if (!isInternetAvailable) {
      // Handle the case where there is no internet connection
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text("Internet error!"),
        ),
      );
      setState(() {
        internetOrClass = 'Internet not available!';
      });
      return;
    }
    setState(() {
      internetOrClass = 'No classes yet!';
    });

    print("loaddata called");
    List<DocumentSnapshot> newDocuments =
    await _firestoreService.getDocumentsOfAllClasses(_batchSize, _lastDocument);

    // Ensure that newDocuments do not contain duplicates
    newDocuments.removeWhere(
            (doc) => _documents.any((existingDoc) => existingDoc.id == doc.id));

    setState(() {
      _documents.addAll(newDocuments);

      // Check if there are new documents before updating _lastDocument
      if (newDocuments.isNotEmpty) {
        _lastDocument = newDocuments.last;
      } else {
        // Handle the case where there are no more documents
        // You might want to disable further loading or show a message.
        _lastDocument = null;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'All classes',
            style: Styles.headLineStyle2.copyWith(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: AppSize.getWidth(27.0, context),
            ),
          ),
          // You can customize the AppBar further as needed
        ),
        backgroundColor: Color(0xfff8f3f3),
        body: _documents.isEmpty
            ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: AppSize.getWidth(100, context),
                  height: AppSize.getHeight(100, context),
                  child: Image.asset("assets/images/classroom_photo1.png"),
                )
                ,
                Text(
                  internetOrClass,
                  style: TextStyle(
                      fontSize: AppSize.getWidth(22, context),
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
        )
            : ListView.builder(
          controller: _scrollController,
          itemCount: _documents.length,
          itemBuilder: (context, index) {
            int imagePathIndex = index % imagePaths.length;
            // Build your UI using _documents[index]
            return Container(
              margin: EdgeInsets.symmetric(
                  vertical: AppSize.getHeight(7, context)),
              padding: EdgeInsets.symmetric(
                  vertical: AppSize.getHeight(9, context),
                  horizontal: AppSize.getWidth(6, context)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(AppSize.getWidth(10, context))),
                color: Colors.white,
              ),
              child: ListTile(
                leading: Image.asset(imagePaths[imagePathIndex]),
                title: Text(
                  _documents[index]['classroom'],
                  style: Styles.headLineStyle2.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                // You can customize other properties of the ListTile as needed
                onTap: () {
                  // Handle the tap event

                  print(' ${_documents[index]['classroom']}');
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> isNetworkAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      return true;
    }
    return false;
  }
}

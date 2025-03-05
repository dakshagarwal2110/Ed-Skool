import 'package:connectivity/connectivity.dart';
import 'package:ed_skool/single_layouts/single_post_look_with_image.dart';
import 'package:ed_skool/utils/app_size.dart';
import 'package:ed_skool/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../principal_layouts/firestore_service.dart';
import '../single_layouts/single_text_layout_post.dart';

class AnnouncementsFetch extends StatefulWidget {
  const AnnouncementsFetch({super.key});

  @override
  State<AnnouncementsFetch> createState() => _AnnouncementsFetchState();
}

class _AnnouncementsFetchState extends State<AnnouncementsFetch> {
  final FirestoreService _firestoreService = FirestoreService();
  final int _batchSize = 3;
  List<DocumentSnapshot> _documents = [];
  DocumentSnapshot? _lastDocument;
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false; // Track loading state

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  String internetOrClass = "No announcements yet!";

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: Scaffold(
        backgroundColor: Color(0xfff8f3f3),
        body: _documents.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: AppSize.getWidth(100, context),
                height: AppSize.getHeight(100, context),
                child:
                Image.asset("assets/images/classroom_photo1.png"),
              ),
              Text(
                internetOrClass,
                style: TextStyle(
                  fontSize: AppSize.getWidth(22, context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
            : ListView.builder(
          controller: _scrollController,
          itemCount: _documents.length,
          itemBuilder: (context, index) {
            String imageUrl = _documents[index]['imageUrl'];
            if (imageUrl == 'nothing') {
              return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSize.getWidth(10, context)),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleTextLayoutPost(
                    caption: _documents[index]['caption'],
                    date: _documents[index]['timeInMillis'],
                    imageIdentifier: "assets/images/school_icon.png",
                  ));
            } else {
              return Container(
                margin: EdgeInsets.symmetric(
                  vertical: AppSize.getHeight(7, context),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: AppSize.getHeight(9, context),
                  horizontal: AppSize.getWidth(6, context),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppSize.getWidth(10, context)),
                  ),
                  color: Colors.white,
                ),
                child: InstagramPost(
                  urlString: imageUrl,
                  caption: _documents[index]['caption'],
                  date: _documents[index]['timeInMillis'],
                  imageIdentifier: "assets/images/school_icon.png",
                ),
              );
            }
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

  Future<void> _loadData() async {
    // Set loading state to true
    print("load data calledss");
    setState(() {
      _isLoading = true;
    });

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
        _isLoading = false; // Set loading state to false
      });
      return;
    }
    setState(() {
      internetOrClass = 'No announcements yet!';
    });

    List<DocumentSnapshot> newDocuments = await _firestoreService
        .getDocumentsOfAllAnnouncements(_batchSize, _lastDocument);

    newDocuments.removeWhere(
            (doc) => _documents.any((existingDoc) => existingDoc.id == doc.id));

    setState(() {
      _documents.addAll(newDocuments);
      if (newDocuments.isNotEmpty) {
        _lastDocument = newDocuments.last;
      } else {
        _lastDocument = null;
      }
      _isLoading = false; // Set loading state to false
    });
  }
}

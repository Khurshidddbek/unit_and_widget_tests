import 'package:flutter/material.dart';
import 'package:pattern_tests/model/post_model.dart';
import 'package:pattern_tests/services/http_service.dart';

class DetailPage extends StatefulWidget {
  static final String id = 'detail_page';

  int uid;
  DetailPage({this.uid, Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLoading = false;
  Post post = Post(title: 'Wait a second ...', body: 'Wait a second ...');

  _apiPost(int id) async {
    setState(() {
      isLoading = true;
    });

    var response = await Network.GET(Network.API_LIST + '/${widget.uid}', Network.paramsEmpty());

    setState(() {
      if (response != null) {
        post = Network.parsePost(response);
      }

      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _apiPost(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  post.title.toUpperCase(),
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 5,),

                // Body
                Text(post.body),
              ],
            ),
          ),

          isLoading ? Center(child: CircularProgressIndicator(),) : SizedBox.shrink(),
        ],
      ),
    );
  }
}

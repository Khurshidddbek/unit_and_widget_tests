import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pattern_tests/model/post_model.dart';
import 'package:pattern_tests/services/http_service.dart';

import 'home_page.dart';

class UpdatePage extends StatefulWidget {
  static final String id = 'update_page';

  String title, body;
  UpdatePage({this.title, this.body, Key key}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  bool isLoading = false;
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _bodyTextEditingController = TextEditingController();

  _apiPostUpdate() async {
    setState(() {
      isLoading = true;
    });

    Post post = Post(id: Random().nextInt(pow(2, 30) - 1),title: _titleTextEditingController.text, body: _bodyTextEditingController.text, userId: Random().nextInt(pow(2, 30) - 1));

    var response = await Network.PUT(Network.API_UPDATE + '1', Network.paramsUpdate(post));

    setState(() {
      if (response != null) {
        Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
      }

      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _titleTextEditingController.text = widget.title;
    _bodyTextEditingController.text = widget.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a new post'),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // Title
                Container(
                  height: 75,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: TextField(
                      controller: _titleTextEditingController,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                // Body
                Container(
                  height: 475,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: _bodyTextEditingController,
                    style: TextStyle(fontSize: 18),
                    maxLines: 30,
                    decoration: InputDecoration(
                      labelText: 'Body',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          isLoading ? Center(child: CircularProgressIndicator(),) : SizedBox.shrink(),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          _apiPostUpdate();
        },
        child: Icon(Icons.file_upload),
      ),
    );
  }
}

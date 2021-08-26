import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pattern_tests/model/post_model.dart';
import 'package:pattern_tests/pages/home_page.dart';
import 'package:pattern_tests/services/http_service.dart';

class CreatePage extends StatefulWidget {
  static final String id = 'create_page';

  const CreatePage({Key key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  bool isLoading = false;
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _bodyTextEditingController = TextEditingController();

  _apiPostCreate()  async {
    setState(() {
      isLoading = true;
    });

    Post post = Post(title: _titleTextEditingController.text, body: _bodyTextEditingController.text, userId: Random().nextInt(pow(2, 30) - 1));

    var response = await Network.GET(Network.API_CREATE, Network.paramsCreate(post));

    setState(() {
      if (response != null) {
        Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
      }

      isLoading = false;
    });
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
          _apiPostCreate();
        },
        child: Icon(Icons.file_upload),
      ),
    );
  }
}

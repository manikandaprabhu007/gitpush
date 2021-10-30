     import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class PostHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: PostScreen(),),);
  }
}

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  List<Post> _postList =new List<Post>();

  Future<List<Post> > fetchPost() async {
    final response =
    await http.get('http://alkadhum-col.edu.iq/wp-json/wp/v2/posts/');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values=new List<dynamic>();
      values = json.decode(response.body);
      if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            _postList .add(Post.fromJson(map));
            debugPrint('Id-------${map['id']}');
          }
        }
      }
      return _postList;

    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {

    fetchPost();

  }
}
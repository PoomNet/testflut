import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Addpost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new AddpostState();
}

class AddpostState extends State<Addpost> {
  var user;
  var post = [];
  var new_post=0;
  final cause = TextEditingController();
  final symptom = TextEditingController();
  final category = TextEditingController();
  final describe = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var a = 0;

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    FirebaseDatabase.instance.reference().once().then((DataSnapshot data) {
      print(data.value);
      print(data.value.length);
      print(data.value[3]['user']['name']);
      print(a);
      for (a; a < data.value.length; a++) {
        if (data.value[a] != null) {
          if (data.value[a]['user']['name'] == 33) {
            user=data.value[a]['user'];
            break;
          }
        }
        print(post);
      }
      new_post = data.value[a]['post'].length;
      print(data.value[2]['post']);
      if (data.value[a]['post']!=null) {
        for (var q = 0; q < data.value[a]['post'].length; q++) {
          print(data.value[a]['post'][q]);
          post.add(data.value[a]['post'][q]);
        }
      }

      print(post);
      print(a);
      // print(data.value['post'][0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Create post")),
        body: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: "Cause"),
                  controller: cause,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please fill subject";
                    }
                  },
                  onSaved: (value) => print(value),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Symptom"),
                  controller: symptom,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please fill subject";
                    }
                  },
                  onSaved: (value) => print(value),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Category"),
                  controller: category,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please fill subject";
                    }
                  },
                  onSaved: (value) => print(value),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Describe"),
                  controller: describe,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please fill subject";
                    }
                  },
                  onSaved: (value) => print(value),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                            child: Text("Save"),
                            onPressed: () async {
                              print(post);

                              post.add({
                                "cause": cause.text,
                                "symptom": symptom.text,
                                "category": category.text,
                                "describe": describe.text
                              });

                              print(post);

                              FirebaseDatabase.instance
                                  .reference()
                                  .child('3').child('post').child("0").set({
                                  "cause": "cause.text",
                                  "symptom": "symptom.text",
                                  "category": "category.text",
                                  "describe": "describe.text",
                                });

                              FirebaseDatabase.instance
                                  .reference()
                                  .child(a.toString()).child("post").child(new_post.toString())
                                  .set({
                                  "cause": cause.text,
                                  "symptom": symptom.text,
                                  "category": category.text,
                                  "describe": describe.text,
                                });
                              Firestore.instance.runTransaction(
                                  (Transaction transaction) async {
                                CollectionReference reference =
                                    Firestore.instance.collection('bandnames');
                                // Map map= Map(reference.id);
                                // print(1);
                                await reference.add({
                                  "cause": cause.text,
                                  "symptom": symptom.text,
                                  "category": category.text,
                                  "describe": describe.text,
                                });
                                cause.clear();
                                symptom.clear();
                                category.clear();
                                describe.clear();
                              });
                              // Navigator.pop(context);
                            }))
                  ],
                )
              ],
            )));
  }

  @override
  void dispose() {
    cause.dispose();
    symptom.dispose();
    category.dispose();
    describe.dispose();
    super.dispose();
  }
}

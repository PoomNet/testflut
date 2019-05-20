import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helllo/addtodo.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Addimage extends StatefulWidget {//หน้าใส่รูปเข้าfirebase
  @override
  State<StatefulWidget> createState() =>  new AddimageState();
    // TODO: implement createState

}
  File image;
  String filename;
class AddimageState extends State<Addimage> {

  



  int _counter = 0;

  Future _getImage() async{
    var selectedImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = selectedImage;
      filename=basename(image.path);
    });
  }

  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("flutter"),
      ),
      body: Center(
        child: image==null?Text("select image"): uploadArea(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'Increment',
        child: Icon(Icons.image),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget addim(){
  return Image.file(image, width: 100);
}

Widget uploadArea(){
    return Column(
      children: <Widget>[
        Image.file(image, width: 100),
      RaisedButton(
        color: Colors.yellowAccent,
        child: Text('Upload'),
        onPressed: (){
          uploadImage();
        },
      )
    ],
    );
}

Future<String> uploadImage() async{
  StorageReference ref = FirebaseStorage.instance.ref().child(filename);
  StorageUploadTask uploadTask = ref.putFile(image);

  var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
  var url = downUrl.toString();

  print("download URL : $url");
  Firestore.instance.runTransaction(
                                  (Transaction transaction) async {
                                CollectionReference reference =
                                    Firestore.instance.collection('bandnames');

                                await reference.add({
                                  "title": url,
                                  "done": false
                                });
                                  });

  return "";
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/authentication_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = "";

  saveTask() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection("Tasks").doc(title);
    Map<String, String> tasks = {"title": title};
    documentReference.set(tasks).whenComplete(() {
      print("Lembrete salvo");
    });
  }

  deleteTask(item) {
    DocumentReference documentReference = FirebaseFirestore.instance.collection("Tasks").doc(item);
    documentReference.delete().whenComplete(() {
      print("Lembrete deletado");
    });
  }

  /*
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text("TODO List"),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              onPressed: () {
                AuthenticationService().signOut();
              },
              child: Container(
                margin: EdgeInsets.only(right: 20.0),
                child: Text('Logout', style: TextStyle(fontSize: 14.0)),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: Text("Adicionar lembrete"),
                    content: TextField(
                      onChanged: (String value) {
                        title = value;
                      },
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          saveTask();
                          Navigator.of(context).pop();
                        },
                        child: Text("Adicionar"),
                      )
                    ],
                  );
                });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Tasks").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                    return Dismissible(
                      onDismissed: (direction) {
                        deleteTask(documentSnapshot['title']);
                      },
                      key: Key(documentSnapshot['title']),
                      child: Card(
                        elevation: 2,
                        margin: EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          title: Text(documentSnapshot['title']),
                          trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                deleteTask(documentSnapshot['title']);
                              }),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(padding: const EdgeInsets.all(5.0), child: Center(child: CircularProgressIndicator())),
                );
              }
            }),
      ),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text("TODO List"),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              onPressed: () {
                AuthenticationService().signOut();
              },
              child: Container(
                margin: EdgeInsets.only(right: 20.0),
                child: Text('Logout', style: TextStyle(fontSize: 14.0)),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: Text("Adicionar lembrete"),
                    content: TextField(
                      onChanged: (String value) {
                        title = value;
                      },
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          saveTask();
                          Navigator.of(context).pop();
                        },
                        child: Text("Adicionar"),
                      )
                    ],
                  );
                });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        /*
        body: Center(
          child: Text("Hello"),
        ),
        */
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Tasks").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                if (snapshot.data != null) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                        return Dismissible(
                          onDismissed: (direction) {
                            deleteTask(documentSnapshot['title']);
                          },
                          key: Key(documentSnapshot['title']),
                          child: Card(
                            elevation: 2,
                            margin: EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            child: ListTile(
                              title: Text(documentSnapshot['title']),
                              trailing: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    deleteTask(documentSnapshot['title']);
                                  }),
                            ),
                          ),
                        );
                      });
                }
              }
            }),
      ),
    );
  }
}

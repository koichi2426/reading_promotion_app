// DataTestComponent.dart

/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reading_promotion_app/models/character.dart';

class DataTestComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('Character').get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        List<DocumentSnapshot> documents = snapshot.data!.docs;
        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            DocumentSnapshot document = documents[index];
            Character character = Character(
              id: document['id'],
              description: document['description'],
              head: document['head'],
              body: document['body'],
              foot: document['foot'],
            );
            return Card(
              child: ListTile(
                title: Text(character.description),
                subtitle: Text(
                    "Head: ${character.head}\nBody: ${character.body}\nFoot: ${character.foot}"),
              ),
            );
          },
        );
      },
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Get_Information extends StatelessWidget{
  final String documentId;

  Get_Information({required this.documentId});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    CollectionReference info = FirebaseFirestore.instance.collection('info');

    return FutureBuilder<DocumentSnapshot>(
      future: info.doc(documentId).get(),
      builder: ((context,snapshot){
        if(snapshot.connectionState == ConnectionState.done)
          {
            Map<String,dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
             Text('Type of Animal: ${data['Type of animal']}' + '\n '+ 'Location: ${data['Country']}' + ' , ' + '${data['State']}' + ' , ' + '${data['city']}' );

          }
        return Text('loading...');

      }),
    );

  }}
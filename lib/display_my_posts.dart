import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'Update_animal_post.dart';
import 'my_posts.dart';


class display_my_posts extends StatelessWidget {

  CollectionReference info = FirebaseFirestore.instance.collection('info');

  @override
  Widget build(BuildContext context) {
    showImage(img) {
      if (img == ''){
        return Center (
          child: ProfilePicture(
            name: TypeOfAnimal_post,
            radius: 80,
            fontsize: 45,
          ),
        );
      }
      else{
        return Center (
          child: ProfilePicture(
            name: TypeOfAnimal_post,
            radius: 80,
            fontsize: 45,
            img: img,
          ),
        );
      }
    }


    return Scaffold(

        appBar: AppBar(
        leading: BackButton(
        onPressed: () => {},),
    backgroundColor: Color(0xFFF8AD9D),
    title: Text("About my post"),
    actions: <Widget>[

            IconButton(onPressed: (){

                     info.doc(id_post).delete();
                     }, icon: Icon(Icons.delete))

                    ]

        ),

        body: SingleChildScrollView (
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                const SizedBox(
                  height: 20,
                ),
                showImage(img_post),
                const SizedBox(
                  height: 50,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child:Text("Type of animal: " + TypeOfAnimal_post, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,
                    ),textAlign: TextAlign.start
                    )
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child:Text("Distinguishing features: " + features_post, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                    ),textAlign: TextAlign.start

                    )

                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child:Text("Country: " + Count_post, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                    ),textAlign: TextAlign.start

                    )

                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child:Text("City: " + cit_post, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                    ),textAlign: TextAlign.start

                    )

                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child:Text("State: " + Stat_post, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                    ),textAlign: TextAlign.start

                    )

                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child:
                    Text("Is the animal injured: " + injury_post, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                    ),textAlign: TextAlign.start

                    )

                ),
                const SizedBox(
                  height: 20,
                ),

                Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child:Text("Nearest address around where the animal was seen: " + addr_post, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                    ),textAlign: TextAlign.start

                    )

                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child:Text("Nearest landmark around where the animal was seen: " + land_post, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                    ),textAlign: TextAlign.start

                    )

                ),



                const SizedBox(
                  height: 20,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child:
                    Text("Has it been seen frequently in the locality: " + locality_post, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                    ),textAlign: TextAlign.start

                    )

                ),


              ]
          ),
        )

    );





  }
}



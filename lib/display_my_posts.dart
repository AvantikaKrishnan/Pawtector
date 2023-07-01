import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'my_posts.dart';


class display_my_posts extends StatelessWidget {

  CollectionReference info = FirebaseFirestore.instance.collection('info');

  @override
  Widget build(BuildContext context) {
    showImage(img) {
      if (img == ''){
        return Center (
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width*0.99,
           decoration: const BoxDecoration(
             image: DecorationImage(
               image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4MER9VKDn8hMXtWjWngnpWkb-3ssnT7jD6CQ-G4g&s'),
               fit: BoxFit.cover,
             )
           ),
          ),
        );
      }
      else{
        return Center (
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width*0.99,

            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(img),
                  fit: BoxFit.cover,
                )
            ),
          ),
        );
      }
    }


    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/display_my_post.png'),
          fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

          appBar: AppBar(
          leading: BackButton(
          onPressed: () => {},),
      backgroundColor: Colors.transparent,
      title: const Text("About my post"),
      actions: <Widget>[

              IconButton(onPressed: (){

                       info.doc(id_post).delete();
                       }, icon: const Icon(Icons.delete))

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
                  Row(
                    children:[

                  const Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child:Text("Type of animal: ", style: TextStyle( fontSize: 17, fontWeight: FontWeight.bold,
                      ),textAlign: TextAlign.start
                      )
                  ),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                          child:Text(TypeOfAnimal_post, style: const TextStyle( fontSize: 17,
                          ),softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.fade, textAlign: TextAlign.start
                          )
                      ),
        ]
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child:Text("Distinguishing features: ", style: TextStyle( fontSize: 17, fontWeight: FontWeight.bold,

                      ),softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.fade, textAlign: TextAlign.start

                      )

                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    child: Container (

                      width: (MediaQuery.of(context).size.width)*0.83,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white70
                      ),

                      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                          child:Text(features_post, style: const TextStyle( fontSize: 17,

                          ),softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.fade, textAlign: TextAlign.start
                          )
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 25,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
            Row(
                children: [
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child:Text("Country: ", style: TextStyle( fontSize: 17, fontWeight: FontWeight.bold,

                      ),softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.fade, textAlign: TextAlign.start

                      )

                  ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 0),
                      child:Text(Count_post, style: const TextStyle( fontSize: 15,

                      ),softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.fade, textAlign: TextAlign.start

                      )

                  ),
                  ]
            ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children:[
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child:Text("City: ", style: TextStyle( fontSize: 17, fontWeight: FontWeight.bold,

                      ),softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.fade, textAlign: TextAlign.start
                      )
                  ),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                          child:Text(cit_post, style: const TextStyle( fontSize: 17,
                          ),softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.fade, textAlign: TextAlign.start
                          )
                      ),
                  ]
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children:[
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child:Text("State: ", style: TextStyle( fontSize: 17, fontWeight: FontWeight.bold,

                      ),softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.fade, textAlign: TextAlign.start

                      )

                  ),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                          child:Text(Stat_post, style: const TextStyle( fontSize: 17,
                          ),softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.fade, textAlign: TextAlign.start
                          )
                      ),
                  ]
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child:Text("Nearest address around where the animal was seen: ", style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold,
                      ),softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.fade, textAlign: TextAlign.start
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    child: Container (
                      width: (MediaQuery.of(context).size.width)*0.78,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white70
                      ),
                      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                          child:Text(addr_post, style: const TextStyle( fontSize: 20,
                          ),softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.fade, textAlign: TextAlign.start
                          )
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child:Text("Nearest landmark around where the animal was seen: ", style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,
                      ),softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.fade, textAlign: TextAlign.start
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    child: Container (
                      width: (MediaQuery.of(context).size.width)*0.78,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white70
                      ),
                      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                          child:Text(land_post, style: const TextStyle( fontSize: 20,
                          ),softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.fade, textAlign: TextAlign.start
                          )
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 25,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child:
                      Text("Is the animal injured: " , style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,
                      ),softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.fade, textAlign: TextAlign.start
                      )
                  ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child:
                      Text(injury_post, style: const TextStyle( fontSize: 17,
                      ),softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.fade, textAlign: TextAlign.start
                      )
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child:
                      Text("Has it been seen frequently in the locality: ", style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,
                      ),softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.fade, textAlign: TextAlign.start
                      )
                  ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child:
                      Text(locality_post, style: const TextStyle( fontSize: 17,
                      ),softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.fade, textAlign: TextAlign.start
                      )
                  ),
                ]
            ),
          )
      ),
    );





  }
}



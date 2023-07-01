import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'Display.dart';
import 'other_user_profile.dart';

class displayEverything extends StatelessWidget {
 late String name_user = "";
 late String image = "";


  getData(){
    FirebaseFirestore.instance.collection('profile').doc(uid).get().then((snapshot) => name_user= snapshot.data()!['name']);
    FirebaseFirestore.instance.collection('profile').doc(uid).get().then((snapshot) => image= snapshot.data()!['img']);
  }

  @override
  Widget build(BuildContext context) {
    showimage(img) {
      if (img == '') {
        return Center(

            child: Container(
              height: 300,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(

                  image: NetworkImage(
                      'https://thumbs.dreamstime.com/b/no-image-icon-vector-available-picture-symbol-isolated-white-background-suitable-user-interface-element-205805243.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            )
        );
      }
      else {
        return Center(
            child: Container(
              height: 300,
                width: MediaQuery.of(context).size.width*0.99,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage(img),
                  fit: BoxFit.cover,
                ),
              ),
            )
        );
      }
    }
    displayImage(img) {
      if (img == ''){
        return Center (
          child: ProfilePicture(
            name: name_user,
            radius: 25,
            fontsize: 20,
          ),
        );
      }
      else{
                return Center (
          child: ProfilePicture(
            name: name_user,
            radius: 25,
            fontsize: 25,
            img: img,
          ),
        );
      }
    }
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://img.freepik.com/free-vector/watercolor-vintage-floral-background_79603-1683.jpg'),
          fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body: SingleChildScrollView (
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    future: FirebaseFirestore.instance.collection('profile').doc(uid).get(),
    builder: (BuildContext context, snapshot) {
      try {
        if (snapshot.hasData) {
          name_user = snapshot.data!['name'];
          image = snapshot.data!['image'];

          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => other_user_profile(uid: uid,)));
                  },
                  child: Row(
                    children: [
                      displayImage(image),
                      const SizedBox(width: 10,),
                      Text(name_user, style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),)

                    ],
                  ),
                ),

                showimage(img),
                const SizedBox(
                  height: 50,
                ),
                Row(
                    children: [
                      const Padding(padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 0),
                          child: Text("Type of animal:", style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold,
                          ), textAlign: TextAlign.start
                          )
                      ),
                      Text(TypeOfAnimal, style: const TextStyle(fontSize: 17,),)
                    ]
                ),

                const SizedBox(
                  height: 20,
                ),
                const Row(
                    children: [
                      Padding(padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 0),
                          child: Text("Distinguishing features: ",
                              style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold,

                              ), textAlign: TextAlign.start

                          )


                      ),

                    ]
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: Container(

                    width: (MediaQuery
                        .of(context)
                        .size
                        .width) * 0.83,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white70
                    ),

                    child: Padding(padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 0),
                        child: Text(
                            features, style: const TextStyle(fontSize: 20,

                        )
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
                Row(
                    children: [

                      const Padding(padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 0),
                          child: Text("Country: ", style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold,

                          ), textAlign: TextAlign.start

                          )

                      ),
                      Padding(padding: const EdgeInsets.symmetric(
                          horizontal: 17, vertical: 0),
                          child: Text(
                              Count, style: const TextStyle(fontSize: 20,

                          ), textAlign: TextAlign.start

                          )

                      ),
                    ]
                ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                    children: [

                      const Padding(padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 0),
                          child: Text("City: ", style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold,

                          ), textAlign: TextAlign.start

                          )

                      ),
                      Expanded(child:
                      Padding(padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 0),
                          child: Text(cit, style: const TextStyle(fontSize: 17,

                          ), textAlign: TextAlign.start

                          )

                      ),
                      ),
                    ]
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    children: [
                      const Padding(padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 0),
                          child: Text("State: ", style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold,

                          ),
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.start

                          )

                      ),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0),
                            child: Text(
                                Stat, style: const TextStyle(fontSize: 17,

                            ),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.start

                            )

                        ),
                      ),
                    ]
                ),
                const SizedBox(
                  height: 30,
                ),


                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Text(
                        "Nearest address around where the animal was seen: ",
                        style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold,

                        ), textAlign: TextAlign.start

                    )

                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: Container(

                    width: (MediaQuery
                        .of(context)
                        .size
                        .width) * 0.78,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white70
                    ),

                    child: Padding(padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 0),
                        child: Text(addr, style: const TextStyle(fontSize: 20,

                        )
                        )
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Text(
                        "Nearest landmark around where the animal was seen: ",
                        style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold,

                        ), textAlign: TextAlign.start

                    )

                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: Container(

                    width: (MediaQuery
                        .of(context)
                        .size
                        .width) * 0.78,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white70
                    ),

                    child: Padding(padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 0),
                        child: Text(land, style: const TextStyle(fontSize: 20,

                        )
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
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Text("Is the animal injured:", style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold,
                    ), textAlign: TextAlign.start
                    )
                ),


                Padding(padding: const EdgeInsets.symmetric(
                    horizontal: 27, vertical: 0),
                    child:
                    Text(injury, style: const TextStyle(fontSize: 17,

                    ),

                    )
                ),


                const SizedBox(
                  height: 20,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child:
                    Text("Has it been seen frequently in the locality: ",
                        style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold,

                        ), textAlign: TextAlign.start
                    )
                ),
                Padding(padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 0),
                    child:
                    Text(locality, style: const TextStyle(fontSize: 17,
                    ), textAlign: TextAlign.start
                    )
                ),


              ]
          );
        }
        else {
          return const Text('Data cannot be fetched!');
        }
      } catch (e) {
        print(e);
      }
      return Container();
    }
          )
      ),
      )
    );





  }
}



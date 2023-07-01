import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'display_my_posts.dart';



String name = '';
late String TypeOfAnimal_post  ='';
late String Count_post ='';
late String cit_post ='';
late String Stat_post ='';
late String addr_post ='';
late String land_post ='';
late String  locality_post ='';
late String features_post ='';
late String injury_post ='';
late String vet_post ='';
late String img_post = '';
late String id_post  = '';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const  My_posts());
}




// Define a custom Form widget.
class My_posts extends StatefulWidget {
  const  My_posts({super.key});

  @override
  State< My_posts> createState() => _My_postsState();
}
// final user = FirebaseAuth.instance.currentUser;
//  final uid = user?.uid;

// Define a corresponding State class.
// This class holds data related to the Form.
class _My_postsState extends State< My_posts> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  List allresults = [];
  List resultList = [];

  List<String> docIds = [];

  getInfoStream () async{
    var uid = (await FirebaseAuth.instance.currentUser!).uid;
   // var data = FirebaseFirestore.instance.collection('info').where('uid', isEqualTo: uid).orderBy('Type of animal').get();
    var data = await FirebaseFirestore.instance.collection('info').where('uid', isEqualTo: uid).orderBy('Type of animal').get();

    for (var ids in data.docs){
      docIds.add(ids.reference.id);
    }

    print(docIds);

    setState(() {
      allresults = data.docs;
    });
    searchResultList();
  }

  // Future getDocIds() async{
  //   await FirebaseFirestore.instance.collection('info').get().then((snapshot) => snapshot.docs.forEach((document) {
  //     print(document.reference);
  //     docIds.add(document.reference.id);
  //   }),
  //   );
  // }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies(){
    getInfoStream();
    super.didChangeDependencies();
  }

  void _printLatestValue() {
    print('Second text field: ${myController.text}');
    searchResultList();
  }

  display2(){
    var showResults = [] ;


  }

  searchResultList(){
    var showResults = [] ;
    if(myController.text != "")
    {
      for(var InfoSnapshot in allresults)
      {
        var name = InfoSnapshot['Type of animal'].toString().toLowerCase();
        var country = InfoSnapshot['Country'].toString().toLowerCase();
        var city = InfoSnapshot['city'].toString().toLowerCase();
        var state = InfoSnapshot['State'].toString().toLowerCase();
        if(name.contains(myController.text.toLowerCase()))
        {
          showResults.add(InfoSnapshot);

        }
        else if(country.contains(myController.text.toLowerCase()))
        {
          showResults.add(InfoSnapshot);


        }
        else if(city.contains(myController.text.toLowerCase()))
        {
          showResults.add(InfoSnapshot);


        }
        else if(state.contains(myController.text.toLowerCase()))
        {
          showResults.add(InfoSnapshot);


        }

      }
    }
    else
    {
      showResults = List.from(allresults);
    }
    setState(() {
      resultList = showResults;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/my_posts.png'),
          fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Colors.white70,
            title: CupertinoSearchTextField(
              controller: myController,
            )
        ),

        body:
        ListView.separated(


          itemCount: resultList.length,
          itemBuilder: (context,index) {
            return ListTile(

              shape: const RoundedRectangleBorder(borderRadius:  BorderRadius.only(topRight: Radius.circular(32), bottomRight: Radius.circular(32),topLeft: Radius.circular(32),bottomLeft:  Radius.circular(32))),
              visualDensity: const VisualDensity(horizontal: 0, vertical: 4),
                contentPadding: const EdgeInsets.only(left: 15, top: 20,right :5),

              tileColor: Colors.white38,
              onTap: (){
                TypeOfAnimal_post =resultList[index]['Type of animal'];
                Count_post =resultList[index]['Country'];
                cit_post =resultList[index]['city'];
                Stat_post =resultList[index]['State'];
                addr_post =resultList[index]['Nearest address'];
                land_post = resultList[index]['Nearest landmark'];
                locality_post =resultList[index]['Seen in locality'];
                features_post =resultList[index]['Distinguishing features'];
                injury_post = resultList[index]['Is the animal injured'];
                vet_post =resultList[index]['Contact with vet'];
                img_post = resultList[index]['Image'];
                id_post = resultList[index]['id'];

                Navigator.push(context, MaterialPageRoute(builder: (context) => display_my_posts()));
              },
              title: Text(resultList[index]['Type of animal']),
              subtitle: Text(resultList[index]['Country']),
             trailing:const Icon(Icons.arrow_circle_right)
//ht — material icon named "arrow circle right" (outlined).
// IconData(0xf05bd, fontFamily: 'MaterialIcons')
            );


          }, separatorBuilder: (BuildContext context, int index) => const SizedBox (height:10,),







        ),

      ),
    );


  }


}

// shape: RoundedRectangleBorder(borderRadius:  BorderRadius.only(topRight: Radius.circular(32), bottomRight: Radius.circular(32),topLeft: Radius.circular(32),bottomLeft:  Radius.circular(32))),
// visualDensity: VisualDensity(horizontal: 0, vertical: 4),
// final user = FirebaseAuth.instance.currentUser;
// final uid = user?.uid;
//var data = await FirebaseFirestore.instance.collection('info').where('uid', isEqualTo: uid).orderBy('Type of animal').get();
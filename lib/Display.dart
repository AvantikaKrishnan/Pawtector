import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epics5/DisplayEverything.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'information.dart';

bool showSpin = false;
String name = '';
late String TypeOfAnimal  ='';
late String Count ='';
late String cit ='';
late String Stat ='';
late String addr ='';
late String land ='';
late String  locality ='';
late String features ='';
late String injury ='';
late String vet ='';
late String img = '';
late String uid = '';


 Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   Firebase.initializeApp();
    runApp(const displayinfo());
    }




// Define a custom Form widget.
class displayinfo extends StatefulWidget {
  const displayinfo({super.key});

  @override
  State<displayinfo> createState() => _displayinfoState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _displayinfoState extends State<displayinfo> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  List allresults = [];
  List resultList = [];

  List<String> docIds = [];

  getInfoStream () async{
    var data = await FirebaseFirestore.instance.collection('info').orderBy('Type of animal').get();
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
  Future<String> _loadData() async {
    // Specifies the indicator's duration / delay
    await Future.delayed(const Duration(seconds: 3));
    return Future<String>.value('Loaded');
  }


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(

      inAsyncCall: showSpin,
      child: Container(
          decoration: const BoxDecoration(
          image: DecorationImage(
          image: NetworkImage('https://img.freepik.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148907306.jpg'),fit: BoxFit.cover
      ),

              ),

      child:Scaffold(
      backgroundColor : Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
            title: CupertinoSearchTextField(
              controller: myController,
            )
        ),

        body:
        ListView.separated(
                itemCount: resultList.length,
                itemBuilder: (context,index) {
                  return ListTile(
                    shape: const RoundedRectangleBorder(borderRadius:  BorderRadius.only(topRight: Radius.circular(22), bottomRight: Radius.circular(22),topLeft: Radius.circular(22),bottomLeft:  Radius.circular(22))),
                    tileColor: Colors.white60,

                    onTap: (){
                      TypeOfAnimal =resultList[index]['Type of animal'];
                      Count =resultList[index]['Country'];
                      cit =resultList[index]['city'];
                      Stat =resultList[index]['State'];
                      addr =resultList[index]['Nearest address'];
                      land = resultList[index]['Nearest landmark'];
                      locality =resultList[index]['Seen in locality'];
                      features =resultList[index]['Distinguishing features'];
                      injury = resultList[index]['Is the animal injured'];
                      vet =resultList[index]['Contact with vet'];
                      img = resultList[index]['Image'];
                      uid =  resultList[index]['uid'];
                      Navigator.push(context, MaterialPageRoute(builder: (context) => displayEverything()));
                    },
                    title: Text(resultList[index]['Type of animal']),
                    subtitle: Text(resultList[index]['Country']),
                    trailing: Text(resultList[index]['city']),

                  );


                }, separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),







        ),
      )
      ),
    );


  }


}
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'Display.dart';
import 'information.dart';

class displayEverything extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    showImage(img) {
      if (img == ''){
        return Center (
          child: ProfilePicture(
            name: TypeOfAnimal,
            radius: 80,
            fontsize: 45,
          ),
        );
      }
      else{
;        return Center (
          child: ProfilePicture(
            name: TypeOfAnimal,
            radius: 80,
            fontsize: 45,
            img: img,
          ),
        );
      }
    }


    return Scaffold(

        appBar: AppBar(

        ),

        body: SingleChildScrollView (
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              const SizedBox(
              height: 20,
              ),
            showImage(img),
              const SizedBox(
                height: 50,
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child:Text("Type of animal: " + TypeOfAnimal, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,
                  ),textAlign: TextAlign.start
                  )
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child:Text("Distinguishing features: " + features, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                  ),textAlign: TextAlign.start

                  )

              ),
              const SizedBox(
                height: 20,
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child:Text("Country: " + Count, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                  ),textAlign: TextAlign.start

                  )

              ),
              const SizedBox(
                height: 20,
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child:Text("City: " + cit, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                  ),textAlign: TextAlign.start

                  )

              ),
              const SizedBox(
                height: 20,
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child:Text("State: " + Stat, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                  ),textAlign: TextAlign.start

                  )

              ),
              const SizedBox(
                height: 20,
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child:
                  Text("Is the animal injured: " + injury, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                  ),textAlign: TextAlign.start

                  )

              ),
              const SizedBox(
                height: 20,
              ),

              Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child:Text("Nearest address around where the animal was seen: " + addr, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                  ),textAlign: TextAlign.start

                  )

              ),
              const SizedBox(
                height: 20,
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child:Text("Nearest landmark around where the animal was seen: " + land, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                  ),textAlign: TextAlign.start

                  )

              ),



              const SizedBox(
                height: 20,
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child:
                  Text("Has it been seen frequently in the locality: " + locality, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                  ),textAlign: TextAlign.start

                  )

              ),



    ]
    ),
        )

    );





  }
}



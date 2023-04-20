// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class community extends StatefulWidget {
//   const community({Key? key}) : super(key: key);
//
//   @override
//   State<community> createState() => _communityState();
// }
//
// class _communityState extends State<community> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        child: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Container(
//                         height: 40.0,
//                         width: 40.0,
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                                 fit: BoxFit.fill,
//                                 image: new NetworkImage(
//                                     "https://pbs.twimg.com/profile_images/877903823133704194/Mqp1PXU8_400x400.jpg"))),
//                       ),
//                       SizedBox(width: 10.0),
//                       Text(
//                         "The Verge",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.more_vert),
//                     onPressed: () {},
//                   )
//                 ]),
//           ),
//           Container(
//             child: Image.network(
//               "https://scontent-bom1-1.cdninstagram.com/vp/bbe7af06973ff08e40c46e78b6dbae1b/5CD2BC37/t51.2885-15/e35/49480120_356125811610205_2312703144893486280_n.jpg?_nc_ht=scontent-bom1-1.cdninstagram.com",
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     IconButton(
//                       icon: Icon(Icons.favorite_border), onPressed: () {  },
//                     ),
//                     SizedBox(width: 16.0),
//                     Icon(Icons.comment),
//                     SizedBox(width: 16.0),
//                     Icon(Icons.newspaper
//                     )
//                   ],
//                 ),
//                 Icon(Icons.bookmark)
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//

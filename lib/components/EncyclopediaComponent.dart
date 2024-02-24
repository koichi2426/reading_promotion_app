// import 'package:flutter/material.dart';
// import 'package:reading_promotion_app/relatedCharaData/characters.dart';
// import 'package:reading_promotion_app/relatedCharaData/chara_crud.dart';

// class EncyclopediaComponent extends StatefulWidget {
//   const EncyclopediaComponent({Key? key}) : super(key: key);

//   @override
//   _EncyclopediaComponentState createState() => _EncyclopediaComponentState();
// }

// class _EncyclopediaComponentState extends State<EncyclopediaComponent> {
  
//   List<Character> characters = [];
//   Firestore firestore = Firestore();

//   @override
//   void initState() {
//     super.initState();
//     _fetchCharacters();
//   }

//   Future<void> _fetchCharacters() async {
//     await firestore.read();
//     setState(() {
//       characters = firestore.characters;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       appBar: AppBar(
        
//         backgroundColor: Colors.grey.withOpacity(0.3),
        
//         title: Text(
//           'これまで育成したキャラクター',
//           style: TextStyle(
//             fontSize: 15,
//             fontWeight: FontWeight.bold,
//           ), 
//         ), 
        
//         centerTitle: true,      
      
//       ),
      
//       backgroundColor: Color(0xFFF5DEB3),
      
//       body: GridView.count(
        
//         crossAxisCount: 2,
        
//         // children: characters

//         children: [
//           Text(
//             'tmp',
//             style: TextStyle(fontSize: 119),
//           ),
//           Text(
//             'tmp',
//             style: TextStyle(fontSize: 119),
//           ),
//           Text(
//             'tmp',
//             style: TextStyle(fontSize: 119),
//           ),
//         ]

//       ),
    
//     );
//   }

// }
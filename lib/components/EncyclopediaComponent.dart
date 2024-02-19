import 'package:flutter/material.dart';

class EncyclopediaComponent extends StatelessWidget {
  const EncyclopediaComponent({super.key}) : super(key: key);

  @override
  _EncyclopediaComponentState createState() => _EncyclopediaComponentState();
}

class _EncyclopediaComponentState extends State<EncyclopediaComponent> {
  
  // List<Characters> characters = [];
  // Firestore firestore = Firestore();

  @override
  void initState() {
    super.initState();
    _fetchCharacters();
  }

  Future<void> _fetchCharacters() async {
    // get character info from firestore???
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // write code about UI???
    )
  }

}
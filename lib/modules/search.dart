import 'package:flutter/material.dart';

class Search_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: Text(
            'Search',
            style: TextStyle(color: Colors.white,fontFamily: 'Baloo5',fontSize: 20),
          )
      ),
      body: Text('Search Screen',),
    );
  }
}

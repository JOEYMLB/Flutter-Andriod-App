import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc315_term_project/main.dart';
import 'package:flutter/material.dart';
import 'poi_data.dart';






class SearchScreen extends StatefulWidget{
  SearchScreen({super.key});
  UncwPoiData data = UncwPoiData();

  @override 
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>{
  final TextEditingController _controller = TextEditingController();
  final poiRef = FirebaseFirestore.instance.collection('UncwPOIs');
  List<QueryDocumentSnapshot> searchResults=[];
  @override 
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: "Enter a name"),
              onChanged:(value) {
                // print(value);

                poiRef.where('name',isEqualTo:value).get().then(
                  (result){
                    searchResults = result.docs;
                    setState(() {
                      
                    });
                  }
                );
              },
            ),
            Expanded(child: _getBodyCotent()),
          ]),
      )
    );
  }
  Widget _getBodyCotent(){
    if (_controller.text.isEmpty){
      return const Text("Enter a poi name to see results");
    }
    if (searchResults.isEmpty){
      return const Text("No poi with that name is found");
    }
    
    return ListView.builder(
      
      itemCount: searchResults.length,
      itemBuilder: (context, index) => ListTile(
        leading: const  Icon(Icons.done_outline,size:32),
        title: Text("${searchResults[index].get('name') }"),
        subtitle: Image.asset("${searchResults[index].get('picture')}"),
        onTap:() {
          if (searchResults[index].get('name') == UncwPoiData())
          Navigator.of(context).push(
          MaterialPageRoute(builder: ((context) => POIDetails())
          ));
        },
        
      ),
    );
  }
}
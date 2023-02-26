
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class POIList extends StatelessWidget {
  POIList({super.key});

  // Reference to the Firestore "People" collection
  final poiRef = FirebaseFirestore.instance.collection('UncwPOIs');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: poiRef.snapshots(), //.snapshots() gives us a Stream
      builder: (context, AsyncSnapshot snapshot) {
        // Make sure that the snapshot has data with it.
        // There may be no data while the network connection is initializing.
        // And sometimes the data is empty, like and empty street.
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text("No data to show!");
        }

        // Here is the list of Documents from the People collection.
        var poiDocs = snapshot.data!.docs;
        // Use a ListView.builder to generate a ListView
        // to display the People collection
        return ListView.builder(
          itemCount: poiDocs.length,
          itemBuilder: ((context, index) => Card(
              child: ListTile(
                  title: Text(
                    "${poiDocs[index].get('name')}"),
                    subtitle: Image.asset('${poiDocs[index].get('picture')}'),
                    
                  
                  trailing: (poiDocs[index].get('favorite'))
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.green[700],
                        )
                      : const Icon(Icons.circle_outlined),
                  onLongPress: () {
                    // Get a reference to the Document you want to update.
                    QueryDocumentSnapshot poi = poiDocs[index];
                    poiRef
                        .doc(poi.id)
                        .update({"favorite": !poi.get("favorite")});
                  }))),
        );
      },
    );
  }
}

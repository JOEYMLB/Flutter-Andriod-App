
// ignore_for_file: prefer_const_constructors
import 'package:csc315_term_project/cloud_storage.dart';
import 'package:csc315_term_project/screens/signinScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'search.dart';
import 'poi_data.dart';





void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(MaterialApp(title: "TermProject", home: MyApp()));
  await Firebase.initializeApp(
    options:  DefaultFirebaseOptions.currentPlatform,
  );
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            ElevatedButton(
              onPressed: () {
                // signOut() doesn't return anything, so we don't need to await
                // for it to finish unless we really want to.
                FirebaseAuth.instance.signOut();

                // This navigator call clears the Navigation stack and takes
                // them to the login screen because we don't want users
                // "going back" in our app after they log out.
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false);
              },
              
              child: const Text("Logout"),
              
            ),
            
  ],
        ),
      ),
    );
  }
}

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About"),backgroundColor: Colors.teal),
      body: Center(
        child:
         Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text("This app was created by: Joey Mills"),
          ],
         ),)
    );
  }
}








class MyCard extends StatefulWidget{
  const MyCard({super.key});
  @override
  State<MyCard> createState() => _MyCard();
}
class _MyCard extends State<MyCard>{

  final poiRef = FirebaseFirestore.instance.collection('UncwPOIs');
  late UncwPOIDATAs poi;
  @override 
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: poiRef.snapshots(),
      builder: (context, AsyncSnapshot snapshot){
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty){
          return const Text("No data to show!");
        }

        var poiDocs = snapshot.data!.docs;
        
        return ListView.builder(
          itemCount: poiDocs.length,
          itemBuilder: (((context, index) => Card(
            child: ListTile(
              onTap: (){
                // QueryDocumentSnapshot poi = poiDocs[index];
                // poiRef.doc(poi.id);
                // var data = poiRef.doc(poi[index]);
                // print("${data}");
                
                Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => POIDetails()) 
                  ));
               
              
              
              },

              trailing: (poiDocs[index].get('visitors').contains(FirebaseAuth.instance.currentUser!.uid))
                  ?const Icon(
                    // Icons.check_circle,
                    Icons.check_box_outlined,
                    color: Colors.teal,
                  )
                  : const Icon(Icons.check_box_outline_blank),
              onLongPress: () {
                QueryDocumentSnapshot poi = poiDocs[index];
                List<dynamic> visitors = poi.get('visitors');
                if(!visitors.remove(FirebaseAuth.instance.currentUser!.uid)){
                  visitors.add(FirebaseAuth.instance.currentUser!.uid);
                }

                poiRef
                  .doc(poi.id)
                  .update({"visitors": visitors});
              },
              title: Center(
              
              
              child: Card(
                color:Colors.teal,
                child:Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(padding: EdgeInsets.all(8)),
                      Text("${poiDocs[index].get('name')}", 
                      style: const TextStyle(color:Colors.black,
                      fontSize: 20, fontWeight: FontWeight.bold),),
                      const Padding(padding: EdgeInsets.all(4)),
                      Text("Building ID: " "${poiDocs[index].get('buildingID')}",
                      style: const TextStyle(color:Colors.black,
                      fontSize: 12),),
                      const Padding(padding: EdgeInsets.all(8)),
                      Image.asset("${poiDocs[index].get('picture')}",width:250),
                      const Padding(padding: EdgeInsets.all(4)),
                      Text("${poiDocs[index].get('description')}"),
                      
                    ],
                    
                  
                  ),)
              ),
            )
            ))
        ))
        );
},
    );
  }
  
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override 
  Widget build(BuildContext context){
    return const DefaultTabController(length: 4, 
    child: MaterialApp(
      home: LoginScreen(),
    ));
  }
}


class ListScreen extends StatelessWidget{
  const ListScreen({super.key});

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(title: Text("Uncw POIs"),
      bottom: TabBar(
        onTap: (index){
          // ignore: avoid_print
          print("Selected tab is $index");
        },
        // ignore: prefer_const_literals_to_create_immutables
        tabs: [
          const Tab(icon: Icon(Icons.home)),
          const Tab(icon: Icon(Icons.search)),
          const Tab(icon: Icon(Icons.account_box)),
          const Tab(icon: Icon(Icons.logout))
        ],
      ),
      actions: [
        IconButton(icon:Icon(Icons.home),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ListScreen(),));
        },),
        IconButton(icon: Icon(Icons.search),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SearchScreen(),
      ));
        },
        ),
        IconButton(icon: Icon(Icons.account_box),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfileScreen(),//SearchScreen(),
      ));
        },),
        IconButton(icon: Icon(Icons.logout),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoginScreen(),//SearchScreen(),
      ));
        },),
        IconButton(icon: Icon(Icons.info),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => About(),
      ));
        },)
      ],
      ),
      body: MyCard(),
    );
  }
  
}
 



class POIDetails extends StatelessWidget{
  POIDetails({super.key, this.poi});
  final UncwPOIDATAs? poi;
  final poiRef = FirebaseFirestore.instance.collection('UncwPOIs').get();
  

  @override 
  Widget build(BuildContext context){
    Widget contentToShow;
    Widget contentToShow2;
    Widget contentToShow3;

    if(poi != null){
      contentToShow = Image.asset(poi!.picture);
      contentToShow2 = Text(poi!.name);
      contentToShow3 = Text(poi!.description); 
    }else{
      contentToShow =Text("Nothing to show!");
      contentToShow2 =Text("Nothing to show!");
      contentToShow3 =Text("Nothing to show!");
      
    }
    return Scaffold(
      appBar: AppBar(title:Text("Poi Details")),
      body: Center(
        child: Column(
          children: [
            contentToShow,
            contentToShow2,
            contentToShow3,
          ],
        )),
    );
  }
}
   





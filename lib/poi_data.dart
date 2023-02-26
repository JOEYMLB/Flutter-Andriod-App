// import 'dart:math';



class UncwPOIDATA{
   final List<String> poiNames = [
    "Randall Libary", 
    "Fisher Student Center", 
    "Warwick Center", 
    "Burney Center", 
    "Student Rec Center", 
    "Computer Information Systems Building"];


    final List<UncwPOIDATAs> poi = [
      UncwPOIDATAs(buildingID: "RL", name: "Randall Library", picture: "assets/images/Randall Library.jpg", description: "Named after William Madison Randall, the president of Wilmington College from 1958 to 1968. The library offeres over 2 million items in a varierty of formats, while also offering 300 online databases. To access the library resources or for more information visit http://library.uncw.edu"),
      UncwPOIDATAs(buildingID: "FSC", name: "Fisher Student Center", picture: "assets/images/fisher student center.jpg", description: "Fisher Student Center offers a few meeting rooms named after NC beaches, countless lounges for students. The UNCW bookstore is located in the back. FSC also offers the Sharky's Game room and Box office. If you get tired or hungry you can find a Starbucks and Einstein's Brothers Bagels inside."),
      UncwPOIDATAs(buildingID: "WC", name: "Warwick Center", picture: "assets/images/warwick center.jpg", description: "Warwick Center houses a ballroom which is used for countless events on campus. Warwick houses Auxiliary Services and Student Accounts as well as the Office of Scholarships and Financial Aid. If your hungry you will find the Dubs Cafe inside."),
      UncwPOIDATAs(buildingID: "BU", name: "Burney Center", picture: "assets/images/burney center.jpg", description: "UNCW's premiere location on campus holds a 9,306 square foot ballroom available with five different configurations. This ballroom features upscale finishes, an excellent sound and lighting system, two green rooms, and a large lobby area that can serve as a pre-function space."),
      UncwPOIDATAs(buildingID: "SRC", name: "Student Rec Center", picture: "assets/images/student rec center.jpg", description: "The SRC is a space for students to engage in open recreation. It holds a Aquatics Facility with a indoor and outdoor pool. The Harris Teether Function Training Area provides a space for functional training with various equipment. A traditional fitness center for cardio and strenght training"),
      UncwPOIDATAs(buildingID: "CI", name: "Computer Information Systems Building", picture: "assets/images/ci building.jpg", description: "CIS building offers hands-on laboratories equipped with the latest technologies, research space, high-speed network connectivity throughout the building. CIS offers countless labs, classrooms and lounges.")
    ];

}
class UncwPOIDATAs {
  UncwPOIDATAs(
    {required this.buildingID,
    required this.name,
    required this.picture,
    required this.description});
  
  final String buildingID;
  final String name;
  final String picture;
  final String description;
  // bool visited;
}
class UncwPoiData{

  final List<String> poiNames = [
    "Randall Libary", 
    "Fisher Student Center", 
    "Warwick Center", 
    "Burney Center", 
    "Student Rec Center", 
    "Computer Information Systems Building"];

  
}
class UncwPOIs {
  UncwPOIs(
    {required this.buildingID,
    required this.name,
    required this.picture,
    required this.description,
    required this.visitors});
  
  final String buildingID;
  final String name;
  final String picture;
  final String description;
  // bool visited;
  List<String> visitors;


Map<String, Object?> toMap(){
  return {'buildingID': buildingID, 'name' : name, 'picture' : picture, 'description': description, 'visitor': visitors};
  }
}

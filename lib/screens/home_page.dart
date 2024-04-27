import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:core';


class MyHome extends StatefulWidget{
  MyHome({super.key});
  final user = FirebaseAuth.instance.currentUser;

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome>{
  File? selectedIMage;
  String imageUrl = '';


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
      ),

      //Side Bar Menu
      drawer: Drawer(
        backgroundColor: const Color(0xffE7D8C9),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50), // Set the circular border radius
                    child: SizedBox(
                      width: 100, // Set the desired width
                      child: Image.asset('images/ayano.jpg'),
                    ),
                  ),

                  const Text('Ayanokoji Kiyotaka',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Container( //Profile
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              child: ListTile(
                title: const Text('Profile',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  // Navigate to Home screen
                },
              ),
            ),

            Container( //Privacy policy
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              child: ListTile(
                title: const Text('Privacy Policy',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  // Navigate to Home screen
                },
              ),
            ),

            Container( //Terms and Condition
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              child: ListTile(
                title: const Text('Terms & Condition',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  // Navigate to Home screen
                },
              ),
            ),

            Container( //Profile
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              child: ListTile(
                title: const Text('Profile',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  // Navigate to Home screen
                },
              ),
            ),

            Container( //About
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              child: ListTile(
                title: const Text('About MyCloset',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  // Navigate to Home screen
                },
              ),
            ),

            const SizedBox(height: 50,),

            TextButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  // Optionally, you can add code to navigate to a login screen or perform any other action after sign out.
                } catch (e) {
                  print("Error signing out: $e");
                  // Handle sign-out errors here.
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFB2967D)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      body: Container(
       decoration: BoxDecoration(
         border: Border.all(
             width: 1,
             color: Colors.black
         ),
       ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),
            Text(
              "My Closet",
              style: GoogleFonts.gluten(
                fontSize: 60,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    offset: const Offset(-3, -3),
                    blurRadius: 5,
                    color: Colors.white60.withOpacity(1.0),
                  ),
                  Shadow(
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Shadow(
                    offset: const Offset(2, 5),
                    blurRadius: 2,
                    color: Colors.black26.withOpacity(0.5),
                  ),
                  Shadow(
                    offset: const Offset(5, 12),
                    blurRadius: 3,
                    color: Colors.black12.withOpacity(0.1),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Text(
              "Clothes".toUpperCase(),style:
              GoogleFonts.outfit(
                fontSize: 35,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              ),
            ),
            //Gallery Clothes Containers
            Container(
              margin: const EdgeInsets.only( left: 50, right: 50, bottom: 20),
              height: 450.0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[

                    Container(
                      height: 400,
                      width: 300,
                      color: Colors.white,
                      child: Card(
                        elevation: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            '../image/shirt.jpg', // Corrected asset path
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Container(
                      height: 400,
                      width: 300,
                      color: Colors.white,
                      child: Card(
                        elevation: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            '../image/shirt.jpg', // Corrected asset path
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    // Card to add clothes
                    Container(
                      height: 400,
                      width: 300,
                      color: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 200,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MaterialButton(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        color: Colors.white60,
                                        padding: const EdgeInsets.symmetric(horizontal: 50),
                                        height: 50,
                                        child: const Text(
                                          "Pick Image form Gallery",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        onPressed: ()  {
                                          _pickImageFromGallery();
                                          },
                                        ),
                                      const SizedBox(height: 20),
                                      MaterialButton(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        color: Colors.white60,
                                        padding: const EdgeInsets.symmetric(horizontal: 90),
                                        height: 50,
                                        child: const Text(
                                          "Open Camera",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        onPressed: () {
                                          _pickImageFromCamera();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Card(
                          elevation: 10,
                          child: Icon(
                            Icons.add_circle,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  Future<void> _pickImageFromGallery() async {
    try {
      final pickedFile =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      final File file = File(pickedFile.path);

      final Reference reference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      await reference.putFile(file);

      final String downloadUrl = await reference.getDownloadURL();

      setState(() {
        imageUrl = downloadUrl;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image uploaded successfully')),
      );
    } catch (error) {
      print('Error uploading image: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error uploading image')),
      );
    }
  }
  Future<void> _pickImageFromCamera() async {
    try {
      final pickedFile =
      await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile == null) return;

      final File file = File(pickedFile.path);

      final Reference reference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      await reference.putFile(file);

      final String downloadUrl = await reference.getDownloadURL();

      setState(() {
        imageUrl = downloadUrl;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image uploaded successfully')),
      );
    } catch (error) {
      print('Error uploading image: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error uploading image')),
      );
    }
  }
}

//Camera



// Future _uploadFile(String  path0) async {
//   final ref = storage.FirebaseStorage.instance.ref()
//   .child('images')
//   .child('${DateTime.now().toIso8601String() + p.basename(path)}');
//
//   final result = await ref.putFile(File(path));
//
//   setState((){imageUrl = fileUrl; });
//
//   widget.onFileChange(fileUrl);
// }





import 'package:flutter/material.dart';
import 'package:my_rehab/pages/add_rehab_center.dart';
import 'package:my_rehab/pages/drawer.dart';
import 'package:my_rehab/pages/enroll_kid.dart';
import 'package:my_rehab/pages/manage_rehab_center.dart';
import 'package:my_rehab/pages/verify_enroll_kids.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imageList = [
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
    'assets/images/image4.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rehab'),
        centerTitle: true,
        backgroundColor: const Color(0XFF254C8F),
      ),
      drawer: const MyDrawer(),
      body: Column(children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EnrollStreetKidPage()));
          },
          child: ListTile(
            leading: Image.asset(
              'assets/images/add-friend.png',
              height: 24,
              width: 24,
            ),
            title: const Text('Enroll New Street Kid'),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddRehabPage()));
          },
          child: ListTile(
            leading: Image.asset(
              'assets/images/home.png',
              height: 24,
              width: 24,
            ),
            title: Text('Add new Rehab Center'),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const VerifyEnrollKids()));
          },
          child: ListTile(
            leading: Image.asset(
              'assets/images/user.png',
              height: 24,
              width: 24,
            ),
            title: Text('Verify Enrolled Kids'),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ManageRehabCenter()));
          },
          child: ListTile(
            leading: Image.asset(
              'assets/images/loan.png',
              height: 24,
              width: 24,
            ),
            title: Text('Manage Rehabs'),
          ),
        ),
        const SizedBox(height: 40,),
        Container(
          height: 300,
          child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 16 / 9, // Adjust the aspect ratio as per your needs
              viewportFraction:
                  0.8, // Adjust the fraction to control the visible area of each image
              autoPlay:
                  true, // Set it to false if you don't want the images to automatically slide
            ),
            items: imageList.map((item) {
              return Container(
                child: Center(
                  child: Image.asset(
                    item,
                    fit: BoxFit.cover,
                    width:
                        1000, // Adjust the width and height as per your needs
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ]),
    );
  }
}

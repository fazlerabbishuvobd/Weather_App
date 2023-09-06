import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/services/api_helper.dart';
import 'package:weather_app/view/screen/home_page.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({super.key});

  @override
  State<GetLocation> createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  bool isLoading = false;

  @override
  void initState() {
    isGetLocation();
    getCurrentLocation().then((value) {
      Future.delayed(const Duration(seconds: 2)).then((value) => Get.off(()=> const HomePage()));
    });
    super.initState();
  }

  // Store the previous position
  Future<void> getCurrentLocation() async {
    Position? previousPosition;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      setState(() {
        isLoading = true;
      });
      // Call the determinePosition function
      Position? position = await determinePosition();
      if (position != null) {
        // If position is obtained, store it as the previous position
        previousPosition = position;
        double lat = position.latitude;
        double lon = position.longitude;

        await prefs.remove('latitude');
        await prefs.remove('longitude');

        prefs.setDouble('latitude', lat);
        prefs.setDouble('longitude', lon);
        // Do something with the position
        print('New Latitude: ${position.latitude}, Longitude: ${position.longitude}');
      } else if (previousPosition != null) {

      } else {
        print('No Position Data Available.');
      }
    } catch (error) {
      print('Error: $error');
    }
    setState(() {
      isLoading = false;
    });
  }

  void isGetLocation() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('check', 'yes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/homepage/gps.json',
              width: MediaQuery.sizeOf(context).width * 0.5,
              height: MediaQuery.sizeOf(context).height * 0.3,
              fit: BoxFit.fill,
            ),
            const Text('Finding Location...'),
          ],
        ),
      ),
    );
  }
}

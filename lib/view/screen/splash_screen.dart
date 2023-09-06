import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/view/screen/getLocation.dart';
import 'package:weather_app/view/screen/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then(
        (value) async {
          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          if(sharedPreferences.getString('check')== 'yes')
            {
              Get.off(()=> const HomePage());
            }
          else{
            Get.off(()=> const GetLocation());
          }
        });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade300,
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child:  const Column(
          children: [
            Spacer(),
            Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/images/weatherIcon/rain.png'),
                ),
                Text('Weather App',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                SizedBox(height: 10,),
                CircularProgressIndicator(color: Colors.white,strokeWidth: 3),
              ],
            ),
            Spacer(),
            Text('Design & Developed By'),
            Text('Fazle Rabbi',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}

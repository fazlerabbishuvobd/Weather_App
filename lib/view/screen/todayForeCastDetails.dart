import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_app/view/widgets/weatherMeasurementContainer.dart';
class TodayForecastDetails extends StatefulWidget {
  const TodayForecastDetails({super.key});

  @override
  State<TodayForecastDetails> createState() => _TodayForecastDetailsState();
}

class _TodayForecastDetailsState extends State<TodayForecastDetails> {
var weatherData = Get.arguments[0];
var forecastData = Get.arguments[1];
int index = Get.arguments[2];
String icon = Get.arguments[3];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildTemp(height),

            SizedBox(height: height*0.03,),
            _buildMaxMinTemp(height, width),

            const Spacer(),
            SizedBox(height: height*0.05,),
            const Text('Others Information',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),

            SizedBox(height: height*0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WeatherMeasurement(iconLink: 'assets/images/homepage/wind.png', name: 'Wind', value: '${weatherData['wind']['speed']}',unit: 'KM/H',),
                WeatherMeasurement(iconLink: 'assets/images/homepage/humidity.png', name: 'Humidity', value: '${weatherData['main']['humidity']}',unit: '%',),
                WeatherMeasurement(iconLink: 'assets/images/homepage/pressure.png', name: 'Pressure', value: '${weatherData['main']['pressure']}',unit: 'Pa',),
              ],
            ),
            SizedBox(height: height*0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WeatherMeasurement(iconLink: 'assets/images/others/visibility.png', name: 'Visibility', value: '${(weatherData['visibility'])/1000}',unit: 'KM',),
                WeatherMeasurement(iconLink: 'assets/images/others/sealevel.png', name: 'Sea Level', value: '${weatherData['main']['sea_level']??0}',unit: 'KM',),
                WeatherMeasurement(iconLink: 'assets/images/others/ground.png', name: 'Ground Level', value: '${weatherData['main']['grnd_level']??0}',unit: 'KM',),
              ],
            ),
            SizedBox(height: height*0.05,),
          ],
        ),
      ),
    );
  }

  Row _buildMaxMinTemp(double height, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildMaxTemp(height, width),
        _buildMinTemp(height, width),

      ],
    );
  }

  Container _buildMinTemp(double height, double width) {
    return Container(
      alignment: Alignment.center,
      height: height*0.035,
      width: width*0.45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.deepPurple
      ),
      child: Text('Min Temp: ${(forecastData['list'][index]['main']['temp_min']-273.15).toStringAsFixed(2)}°C',
        style: const TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),
      )
  );
  }

  Container _buildMaxTemp(double height, double width) {
    return Container(
        alignment: Alignment.center,
        height: height*0.035,
          width: width*0.45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.amber
          ),
          child: Text('Max Temp: ${(forecastData['list'][index]['main']['temp_max']-273.15).toStringAsFixed(2)}°C',
            style: const TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold),
          )
      );
  }

  Row _buildTemp(double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: height*0.15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${(forecastData['list'][index]['main']['temp']-273.15).toStringAsFixed(2)}°C',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 50),),
              Text('Feels Like ${(weatherData['main']['feels_like'] - 273.15).toStringAsFixed(2)}°C',style: const TextStyle(fontSize: 14),),
            ],
          ),
        ),
        SizedBox(
          height: height*0.15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icon),
              Text('${weatherData['weather'][0]['main']}'),
            ],
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(Jiffy.parse('${DateTime.fromMillisecondsSinceEpoch(int.parse('${forecastData['list'][index]['dt']}')*1000)}').format(pattern: 'h mm a'),
        style: const TextStyle(fontWeight: FontWeight.bold),),
      centerTitle: true,
      backgroundColor: Colors.amber,
    );
  }
}

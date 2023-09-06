import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/view/screen/forecastHourly10day.dart';
import 'package:weather_app/view/widgets/forecastContainer.dart';
import 'package:weather_app/view/widgets/sunriseSunsetsContainer.dart';
import 'package:weather_app/view/widgets/weatherMeasurementContainer.dart';

class Forecast10daysDetails extends StatefulWidget {
  const Forecast10daysDetails({super.key});

  @override
  State<Forecast10daysDetails> createState() => _Forecast10daysDetailsState();
}

class _Forecast10daysDetailsState extends State<Forecast10daysDetails> {
  var forecast10DaysData = Get.arguments[0];
  var preIndex = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    //<--------------- Data Store In Variable -------------------->
    var data = forecast10DaysData['forecast']['forecastday'][preIndex + 2];

    return Scaffold(
      appBar: AppBar(
        title: Text(data['date'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),

      body: Container(
        padding: const EdgeInsets.all(10),
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              //<------------------- Temperature / Icon / Condition ------------------>
              _buildTemperature(data),
              SizedBox(
                height: height * 0.04,
              ),

              //<------------------ Max & Min Temperature ----------------->
              _buildMaxMinTemp(height, width, data),
              SizedBox(
                height: height * 0.02,
              ),

              //<-------------------- Sunrise & Sunset -------------------->
              _buildSunriseSunset(data),
              SizedBox(
                height: height * 0.02,
              ),

              //<-------------------- Hourly Forecast -------------------->
              _buildHourlyForecastText(height, width),
              _buildHourlyForecastList(height, data),

              //<-------------------- Other Information -------------------->
              _buildOtherInfoText(height, width),

              //<------------------- Wind/Humidity/Visibility ------------------->
              _buildWindHumidityVisibility(data),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildTemperature(data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('${data['day']['avgtemp_c']}°C',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https:${data['day']['condition']['icon']}',
              scale: 1,
            ),
            Text('${data['day']['condition']['text']}'),
          ],
        ),
      ],
    );
  }

  Container _buildHourlyForecastList(double height, data) {
    return Container(
      height: height * 0.35,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Get.to(() => const ForecastHourly10dayDetails(),
                arguments: [forecast10DaysData, index, preIndex]);
          },
          child: ForeCastParameter(
            timeNeed: 1,
            dateNeed: 1,
            netIcon: 1,
            date: data['hour'][index]['time'].toString().split(' ')[0],
            time: data['hour'][index]['time'].toString().split(' ')[1],
            iconUrl: data['day']['condition']['icon'],
            temperature: '${data['hour'][index]['temp_c']}',
            maxTemp: '${data['day']['maxtemp_c']}',
            minTemp: '${data['day']['mintemp_c']}',
          ),
        ),
        itemCount: 24,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Container _buildWindHumidityVisibility(data) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WeatherMeasurement(
              unit: 'km/h',
              iconLink: 'assets/images/homepage/wind.png',
              name: 'Wind',
              value: '${data['day']['maxwind_kph']}'),
          WeatherMeasurement(
              unit: '%',
              iconLink: 'assets/images/homepage/humidity.png',
              name: 'Humidity',
              value: '${data['day']['avghumidity']}'),
          WeatherMeasurement(
              unit: 'km',
              iconLink: 'assets/images/others/visibility.png',
              name: 'Visibility',
              value: '${data['day']['avgvis_km']}'),
        ],
      ),
    );
  }

  Container _buildOtherInfoText(double height, double width) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: height * 0.04,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.amber),
      child: const Text('Others Information',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      )
  );
  }

  Container _buildHourlyForecastText(double height, double width) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: height * 0.04,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.amber),
      child: const Text('Hourly Forecast',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      )
  );
  }

  Row _buildSunriseSunset(data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SunriseSunsetContainer(
          name: 'SunRise',
          time: '${data['astro']['sunrise']}',
          iconUrl: 'assets/images/homepage/sunrise.png',
        ),
        SunriseSunsetContainer(
          name: 'Sunset',
          time: '${data['astro']['sunset']}',
          iconUrl: 'assets/images/homepage/sunsets.png',
          colors: Colors.blueGrey.shade200,
        ),
      ],
    );
  }

  Row _buildMaxMinTemp(double height, double width, data) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMaxTemp(height, width, data),
                _buildMinTemp(height, width, data),
              ],
            );
  }

  Container _buildMinTemp(double height, double width, data) {
    return Container(
        alignment: Alignment.center,
        height: height * 0.035,
        width: width * 0.45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.deepPurple),
        child: Text('Min Temp: ${data['day']['mintemp_c']}°C',
          style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
          ),
        )
    );
  }

  Container _buildMaxTemp(double height, double width, data) {
    return Container(
      alignment: Alignment.center,
      height: height * 0.035,
      width: width * 0.45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.amber,
      ),
      child: Text('Max Temp: ${data['day']['maxtemp_c']}°C',
        style: const TextStyle(
            fontSize: 18,
            color: Colors.red,
            fontWeight: FontWeight.bold,
        ),
      )
  );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/view/widgets/weatherMeasurementContainer.dart';

class ForecastHourly10dayDetails extends StatefulWidget {
  const ForecastHourly10dayDetails({super.key});

  @override
  State<ForecastHourly10dayDetails> createState() =>
      _ForecastHourly10dayDetailsState();
}

class _ForecastHourly10dayDetailsState
    extends State<ForecastHourly10dayDetails> {
  var forecastHourData = Get.arguments[0];
  int index = Get.arguments[1];
  var preIndex = Get.arguments[2];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    //<--------------- Data Store in Variable  -------------->
    var data = forecastHourData['forecast']['forecastday'][preIndex + 2]['hour'][index];

    return Scaffold(
      appBar: _buildAppBar(data),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //<--------------- Temp/Icon -------------->
            _buildTemp(data),
            SizedBox(
              height: height * 0.02,
            ),

            //<--------------- Maximum/Minimum Temperature -------------->
            _buildMaxMinTemp(height, width),
            SizedBox(
              height: height * 0.08,
            ),


            //<--------------- Other Information -------------->
            const Text('Others Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(
              height: height * 0.02,
            ),

            //<--------------- Wind/Pressure/Humidity -------------->
            _buildWindPressureHumidity(data),
            SizedBox(
              height: height * 0.02,
            ),

            //<--------------- Visibility / UV / Chance of Rain -------------->
            _buildVisibilityUvRain(data),
            SizedBox(
              height: height * 0.04,
            ),
          ],
        ),
      ),
    );
  }

  Row _buildVisibilityUvRain(data) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WeatherMeasurement(
                iconLink: 'assets/images/others/visibility.png',
                name: 'Visibility',
                value: '${data['vis_km']}',
                unit: 'KM',
              ),
              WeatherMeasurement(
                iconLink: 'assets/images/others/uv.png',
                name: 'UV',
                value: '${data['uv']}',
                unit: '',
              ),
              WeatherMeasurement(
                iconLink: 'assets/images/others/rain.png',
                name: 'Rain',
                value: '${data['chance_of_rain']}',
                unit: '%',
              ),
            ],
          );
  }

  Row _buildWindPressureHumidity(data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        WeatherMeasurement(
          iconLink: 'assets/images/homepage/wind.png',
          name: 'Wind',
          value: '${data['wind_mph']}',
          unit: 'KM',
        ),
        WeatherMeasurement(
          iconLink: 'assets/images/homepage/pressure.png',
          name: 'Pressure',
          value: '${data['pressure_mb']}',
          unit: 'MB',
        ),
        WeatherMeasurement(
          iconLink: 'assets/images/homepage/humidity.png',
          name: 'Humidity',
          value: '${data['humidity']}',
          unit: '%',
        ),
      ],
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
      height: height * 0.035,
      width: width * 0.45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.deepPurple),
      child: Text('Min Temp: ${forecastHourData['forecast']['forecastday'][preIndex + 2]['day']['mintemp_c']}°C',
        style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold),
      )
  );
  }

  Container _buildMaxTemp(double height, double width) {
    return Container(
      alignment: Alignment.center,
      height: height * 0.035,
      width: width * 0.45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.amber),
      child: Text(
        'Max Temp: ${forecastHourData['forecast']['forecastday'][preIndex + 2]['day']['maxtemp_c']}°C',
        style: const TextStyle(
            fontSize: 18,
            color: Colors.red,
            fontWeight: FontWeight.bold),
      )
    );
  }

  Row _buildTemp(data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildTempInfo(data),
        _buildTempIcon(data),
      ],
    );
  }

  Column _buildTempIcon(data) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 40,
              child: Image.network('https:${data['condition']['icon']}',
                scale: 0.9,)
          ),
          Text('${data['condition']['text']}',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      );
  }

  Column _buildTempInfo(data) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${data['temp_c']}°C',
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Text(
            'Feels: ${data['feelslike_c']}°C',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      );
  }

  AppBar _buildAppBar(data) {
    return AppBar(
      title: Text('${data['time'].toString().split(' ')[0]}  -  ${forecastHourData['forecast']['forecastday'][1]['hour'][index]['time'].toString().split(' ')[1]}',
        style: const TextStyle(fontWeight: FontWeight.bold),),
      centerTitle: true,
      backgroundColor: Colors.amber,
    );
  }
}

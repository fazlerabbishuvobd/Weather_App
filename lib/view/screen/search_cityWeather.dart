import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_app/services/api_helper.dart';
import 'package:weather_app/view/screen/forecast10daysDetails.dart';
import 'package:weather_app/view/screen/forecastHourlyDetails.dart';
import 'package:weather_app/view/screen/getLocation.dart';
import 'package:weather_app/view/screen/home_page.dart';
import 'package:weather_app/view/screen/todayForeCastDetails.dart';
import 'package:weather_app/view/utils/constant.dart';
import 'package:weather_app/view/widgets/forecastContainer.dart';
import 'package:weather_app/view/widgets/shimmer_loading.dart';
import 'package:weather_app/view/widgets/sunriseSunsetsContainer.dart';
import 'package:weather_app/view/widgets/weatherMeasurementContainer.dart';

class SearchCityWeather extends StatefulWidget {
  final double latitude, longitude;
  const SearchCityWeather({super.key, required this.latitude, required this.longitude});

  @override
  State<SearchCityWeather> createState() => _SearchCityWeatherState();
}

class _SearchCityWeatherState extends State<SearchCityWeather> with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: Future.wait([
            ApiHelper().openApiWeather( lats: widget.latitude, lon: widget.longitude),
            ApiHelper().forecastTodayInfo(lats: widget.latitude, lon: widget.latitude),
            ApiHelper().forecastTomorrowInfo(lats: widget.latitude, lon: widget.latitude),
            ApiHelper().forecast10DayInfo(lats: widget.latitude, lon: widget.latitude),
          ]),
          builder: (context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: ShimmerLoading(),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.hasError.toString());
            } else if (snapshot.hasData) {

              //<---------------- Fetch Api Variable ------------------------>
              var weatherData = snapshot.data![0];
              var forecastTodayData = snapshot.data![1];
              var forecastTomorrowData = snapshot.data![2];
              var forecast10DayData = snapshot.data![3];

              String iconName1 = '${weatherData['weather'][0]['main']}';
              String weatherIconsToday = weatherIcon(iconName1);

              //<---------------- Main Structure ------------------------>
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      //<---------------- Location & Time ------------------------>
                      _buildLocationTime(weatherData),

                      //<---------------- Temperature ------------------------>
                      const SizedBox(height: 10,),
                      _buildTemp(weatherData, context, weatherIconsToday),
                      SizedBox(
                        height: height * 0.02,
                      ),

                      //<---------------- Wind/Humidity/Pressure ------------------------>
                      _buildWindHumidityPressure(weatherData),
                      SizedBox(
                        height: height * 0.02,
                      ),

                      //<---------------- Today/Tomorrow/10 Days ------------------------>
                      _buildTabBarTodayTomorrow10Days(height),

                      SizedBox(
                        height: height * 0.35,
                        width: width,
                        child: TabBarView(
                          controller: tabController,
                          children: [

                            //Today
                            _buildTabBarToday(forecastTodayData, weatherData),

                            //Tomorrow
                            _buildTabBarTomorrow(forecastTomorrowData),

                            //10 Days
                            _buildTabBar10Days(forecast10DayData),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02,),

                      //<---------------- Sunrise & Sunset ------------------------>
                      _buildSunriseSunset(weatherData),
                      SizedBox(
                        height: height * 0.02,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text('No Data Found'));
            }
          },
        ),
      ),
    );
  }

  Row _buildSunriseSunset(Map<String, dynamic> weatherData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SunriseSunsetContainer(
          name: 'Sunrise',
          time: Jiffy.parse('${DateTime.fromMicrosecondsSinceEpoch(int.parse('${weatherData['sys']['sunrise']}'))}').format(pattern: 'h:mm a'),
          iconUrl: 'assets/images/others/sunrise.png',
          colors: Colors.amber.shade300,
        ),
        SunriseSunsetContainer(
          name: 'Sunset',
          time: Jiffy.parse('${DateTime.fromMillisecondsSinceEpoch(int.parse('${weatherData['sys']['sunset']}'))}').format(pattern: 'h:mm a'),
          iconUrl: 'assets/images/homepage/sunsets.png',
          colors: Colors.deepPurple,
        ),
      ],
    );
  }

  Container _buildTabBar10Days(Map<String, dynamic> forecast10DayData) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => GestureDetector(
            onTap: (){
              Get.to(()=>const Forecast10daysDetails(),arguments: [forecast10DayData,index]);
            },
            child: ForeCastParameter(
              timeNeed: 0,
              dateNeed: 1,
              netIcon: 1,
              date: '${forecast10DayData['forecast']['forecastday'][index+2]['date']}',
              iconUrl: forecast10DayData['forecast']['forecastday'][index+2]['day']['condition']['icon'],
              temperature: '${forecast10DayData['forecast']['forecastday'][index+2]['day']['avgtemp_c']}',
              maxTemp: '${forecast10DayData['forecast']['forecastday'][index+2]['day']['maxtemp_c']}',
              minTemp: '${forecast10DayData['forecast']['forecastday'][index+2]['day']['mintemp_c']}',
            ),
          ),
          itemCount: 10,
          scrollDirection: Axis.horizontal,
        ),
      );
  }

  Container _buildTabBarTomorrow(Map<String, dynamic> forecastTomorrowData) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => GestureDetector(
          onTap: (){
            Get.to(()=> const ForecastHourlyDetails(),arguments: [forecastTomorrowData,index]);
          },
          child: ForeCastParameter(
            timeNeed: 1,
            dateNeed: 1,
            netIcon: 1,
            date: forecastTomorrowData['forecast']['forecastday'][1]['hour'][index]['time'].toString().split(' ')[0],
            time: forecastTomorrowData['forecast']['forecastday'][1]['hour'][index]['time'].toString().split(' ')[1],
            iconUrl: forecastTomorrowData['forecast']['forecastday'][1]['day']['condition']['icon'],
            temperature: '${forecastTomorrowData['forecast']['forecastday'][1]['hour'][index]['temp_c']}',
            maxTemp: '${forecastTomorrowData['forecast']['forecastday'][1]['day']['maxtemp_c']}',
            minTemp: '${forecastTomorrowData['forecast']['forecastday'][1]['day']['mintemp_c']}',
          ),
        ),
        itemCount: 24,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Container _buildTabBarToday(Map<String, dynamic> forecastTodayData, Map<String, dynamic> weatherData) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.builder(
        itemBuilder: (context, index) {
          String iconName2 = '${forecastTodayData['list'][index]['weather'][0]['main']}';
          String forecastIconsToday = weatherIcon(iconName2);

          return GestureDetector(
            onTap: (){

              Get.to(()=> const TodayForecastDetails(),arguments: [weatherData,forecastTodayData,index,forecastIconsToday]);

            },
            child: ForeCastParameter(
              dateNeed: 0,
              timeNeed: 1,
              netIcon: 0,
              time: Jiffy.parse('${DateTime.fromMillisecondsSinceEpoch(int.parse('${forecastTodayData['list'][index]['dt']}')*1000)}').format(pattern: 'h mm a'),
              iconUrl: forecastIconsToday,
              temperature: '${(forecastTodayData['list'][index]['main']['temp']-273.15).toStringAsFixed(2)}',
              maxTemp: '${(forecastTodayData['list'][index]['main']['temp_max']-273.15).toStringAsFixed(2)}',
              minTemp: '${(forecastTodayData['list'][index]['main']['temp_min']-273.15).toStringAsFixed(2)}',
            ),
          );
        },
        itemCount: forecastTodayData.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  TabBar _buildTabBarTodayTomorrow10Days(double height) {
    return TabBar(
      controller: tabController,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.amber,
      ),
      indicatorSize: TabBarIndicatorSize.label,
      tabs: [
        Container(
            height: height * 0.04,
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text('Today', style: TextStyle(fontSize: 18,color: Colors.deepPurple,fontWeight: FontWeight.bold),
            )
        ),
        Container(
            height: height * 0.04,
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text(
              'Tomorrow',
              style: TextStyle(fontSize: 18,color: Colors.deepPurple,fontWeight: FontWeight.bold),
            )),
        Container(
            height: height * 0.04,
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text('10 Days', style: TextStyle(fontSize: 16,color: Colors.deepPurple,fontWeight: FontWeight.bold),)),
      ],
      physics: const BouncingScrollPhysics(),
    );
  }

  Container _buildWindHumidityPressure(Map<String, dynamic> weatherData) {
    return Container(
      padding: const EdgeInsets.all(5),
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
              value: '${weatherData['wind']['speed']}'),
          WeatherMeasurement(
              unit: '%',
              iconLink: 'assets/images/homepage/humidity.png',
              name: 'Humidity',
              value: '${weatherData['main']['humidity']}'),
          WeatherMeasurement(
              unit: 'pa',
              iconLink: 'assets/images/homepage/pressure.png',
              name: 'Pressure',
              value: '${weatherData['main']['pressure']}'),
        ],
      ),
    );
  }

  Row _buildTemp(Map<String, dynamic> weatherData, BuildContext context, String weatherIconsToday) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text('${(weatherData['main']['temp'] - 273.15).toStringAsFixed(2)}°C',
                  style: const TextStyle(fontSize: 50),
                ),
                IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Refreshed Weather Info...'),
                        action: SnackBarAction(label: 'Dismiss', onPressed: () {}),
                      ));
                      Get.offAll(const GetLocation());
                    },
                    icon: const Icon(Icons.refresh))
              ],
            ),
            Text('Feels Like ${(weatherData['main']['feels_like'] - 273.15).toStringAsFixed(2)}°C',
              style: const TextStyle(fontSize: 16),),

          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(weatherIconsToday, scale: 1.5,),
            Text('${weatherData['weather'][0]['main']}',
                style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
          ],
        )
      ],
    );
  }

  Row _buildLocationTime(Map<String, dynamic> weatherData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('${weatherData['name']}',
                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.location_on),
              ],
            ),
            Text(Jiffy.parse(DateTime.now().toString()).format(pattern: "EEEE , MMMM do yyyy"),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        IconButton(
            onPressed: () {
              Get.to(()=> const HomePage());
            },
            icon: const Icon(Icons.home)),
      ],
    );
  }
}

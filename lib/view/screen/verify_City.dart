import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/services/api_helper.dart';
import 'package:weather_app/view/screen/search_cityWeather.dart';

class VerifyCity extends StatefulWidget {
  final String cityName;

  const VerifyCity({super.key, required this.cityName});

  @override
  State<VerifyCity> createState() => _VerifyCityState();
}

class _VerifyCityState extends State<VerifyCity> {
  double? lat, lon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('City Information'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder(
        future: ApiHelper().geoCodingFind(cityName: widget.cityName),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No City Found, Please Check Your Spelling !'),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.hasError.toString());
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {

                var data = snapshot.data![index];
                lat = data['lat'];
                lon = data['lon'];

                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: Column(
                    children: [
                      const Spacer(),
                      const Text('City Found',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green),),
                      const SizedBox(height: 20,),

                      //<-------- City Info ( City/State/Country/Latitude/Longitude)------>
                      _buildCityName(context, data),
                      _buildStateName(context, data),
                      _buildCountryName(context, data),
                      _buildLatitude(context, data),
                      _buildLongitude(context, data),


                      const Spacer(),
                      //<------------------------ Show Weather Update Button -------------------->
                      _buildShowWeatherUpdateButton(context),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No Data Found'));
          }
        },
      ),
    );
  }

  Padding _buildShowWeatherUpdateButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MaterialButton(
        onPressed: () {
          Get.to(()=> SearchCityWeather(latitude: lat!, longitude: lon!));
        },
        color: Colors.amber,
        minWidth: MediaQuery.sizeOf(context).width,
        height: 48,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Text('Show Weather Update',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
      ),
    );
  }

  Padding _buildLongitude(BuildContext context, data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Card(
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.sizeOf(context).height*0.05,
            width:MediaQuery.sizeOf(context).width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('Longitude',style: TextStyle(fontSize: 16)),
                Text('${data['lon']}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              ],
            ),
          ),
        ),
      );
  }

  Padding _buildLatitude(BuildContext context, data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: MediaQuery.sizeOf(context).height*0.05,
          width:MediaQuery.sizeOf(context).width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Latitude',style: TextStyle(fontSize: 16)),
              Text('${data['lat']}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildCountryName(BuildContext context, data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: MediaQuery.sizeOf(context).height*0.05,
          width:MediaQuery.sizeOf(context).width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Country Name',style: TextStyle(fontSize: 16)),
              Text(data['country'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildStateName(BuildContext context, data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: MediaQuery.sizeOf(context).height*0.05,
          width:MediaQuery.sizeOf(context).width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('State Name',style: TextStyle(fontSize: 16)),
              Text(data['state'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildCityName(BuildContext context, data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: MediaQuery.sizeOf(context).height*0.05,
          width:MediaQuery.sizeOf(context).width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('City Name',style: TextStyle(fontSize: 16)),
              Text(data['name'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ],
          ),
        ),
      ),
    );
  }
}

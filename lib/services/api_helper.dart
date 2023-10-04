import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/view/utils/constant.dart';

class ApiHelper {
  Future<Map<String, dynamic>> openApiWeather(
      {required double lats, required double lon}) async {
    String uri = '${weatherBaseUrl}lat=$lats&lon=$lon&appid=$openWeatherApiKey';
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return jsonDecode(response.body.toString());
    } else {
      throw Exception('Unable to Handle');
    }
  }

  Future<Map<String, dynamic>> forecastTodayInfo(
      {required double lats, required double lon}) async {
    String uri =
        '${forecastTodayBaseUrl}lat=$lats&lon=$lon&appid=$openWeatherApiKey';
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return jsonDecode(response.body.toString());
    } else {
      throw Exception('Unable to Handle');
    }
  }

  Future<Map<String, dynamic>> forecastTomorrowInfo(
      {required double lats, required double lon}) async {
    String uri = '$forecastTomorrowBaseURL$foreCastApiKey&q=$lats,$lon&days=3&aqi=no&alerts=yes';
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return jsonDecode(response.body.toString());
    } else {
      throw Exception('Unable to Handle');
    }
  }

  Future<Map<String, dynamic>> forecast10DayInfo({required double lats, required double lon}) async {
    String uri = '$forecastTomorrowBaseURL$foreCastApiKey&q=$lats,$lon&days=14&aqi=no&alerts=yes';
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return jsonDecode(response.body.toString());
    } else {
      throw Exception('Unable to Handle');
    }
  }

  Future<List<dynamic>> geoCodingFind({required String cityName}) async {
    String uri =
        '${geoCodingBaseURL}q=$cityName&limit=1&appid=$openWeatherApiKey';
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return jsonDecode(response.body.toString());
    } else {
      throw Exception('Unable to Handle');
    }
  }
}

Future<Position?> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }

  // If permissions are granted, get the current position
  try {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    return position;
  } catch (e) {
    return null;
  }
}

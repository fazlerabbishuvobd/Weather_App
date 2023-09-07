//<---------------- API Key -------------->
String openWeatherApiKey = 'f9678ccabbae652649786c54fc792c25';
String foreCastApiKey = 'key=33c00d4d79764b938c3112843230709';
//6e933d7fa2ab4def9bc120450232307

//<---------------- Hourly Update API Based URL-------------->
String weatherBaseUrl = "https://api.openweathermap.org/data/2.5/weather?";

//<---------------- Forecast 3 Hourly API Based URL-------------->
String forecastTodayBaseUrl = "https://api.openweathermap.org/data/2.5/forecast?";

//<---------------- Forecast Tomorrow and 10 Day API Based URL-------------->
String forecastTomorrowBaseURL = "http://api.weatherapi.com/v1/forecast.json?";

String geoCodingBaseURL = "http://api.openweathermap.org/geo/1.0/direct?";





//<---------------- Weather Icon Changer --------------->
String weatherIcon(String iconLocation) {
  switch (iconLocation) {
    case 'Clear':
      return "assets/images/weatherIcon/clear_sky.png";
    case 'Clouds':
      return "assets/images/weatherIcon/fewCloud.png";
    case 'Rain':
      return "assets/images/weatherIcon/rain.png";
    case 'Thunderstorm':
      return "assets/images/weatherIcon/storm.png";
    case 'Snow':
      return "assets/images/weatherIcon/snow.png";
    case 'Atmosphere':
      return "assets/images/weatherIcon/mist.png";
    case 'Drizzle':
      return "assets/images/weatherIcon/train.png";
    default:
      return "assets/images/homepage/wind.png";
  }
}
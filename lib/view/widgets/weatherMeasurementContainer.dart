import 'package:flutter/material.dart';

class WeatherMeasurement extends StatelessWidget {
  final String iconLink;
  final String name;
  final String value;
  final String? unit;

  const WeatherMeasurement(
      {super.key,
        required this.iconLink,
        required this.name,
        required this.value,
        this.unit,
      });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Card(
      elevation: 10,
      color: const Color(0xff4A148C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Colors.amber,width: 1),
      ),
      child: Container(
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        width: width * 0.27,
        height: height * 0.22,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.amber,
              child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.amber.shade100,
                  backgroundImage: AssetImage(iconLink),
              ),
            ),
            const SizedBox(height: 10,),
            Text('$value $unit', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.amber),),
            Text(name, style: const TextStyle(fontSize: 14,color: Colors.amber),
            ),
          ],
        ),
      ),
    );
  }
}
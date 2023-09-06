import 'package:flutter/material.dart';

class SunriseSunsetContainer extends StatelessWidget {
  final String iconUrl;
  final String name;
  final String time;
  final Color? colors;

  const SunriseSunsetContainer(
      {super.key,
        required this.name,
        required this.time,
        required this.iconUrl,
        this.colors,

      });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
      side: const BorderSide(color: Colors.amber,width: 2)
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: MediaQuery.sizeOf(context).height * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: colors,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name,style: const TextStyle(fontSize: 16),),
            Text(time,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            const SizedBox(height: 10,),

            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white70,
              backgroundImage: AssetImage(iconUrl),
            )
          ],
        ),
      ),
    );
  }
}
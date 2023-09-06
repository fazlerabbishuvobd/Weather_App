import 'package:flutter/material.dart';

class ForeCastParameter extends StatelessWidget {
  final String? time;
  final String? date;
  final String? iconUrl;
  final String? temperature;
  final String? maxTemp, minTemp;
  final int timeNeed;
  final int dateNeed;
  final int netIcon;



  const ForeCastParameter({
    super.key,
    this.time,
    this.date,
    required this.netIcon,
    required this.timeNeed,
    required this.dateNeed,
    this.iconUrl,
    this.temperature,
    this.maxTemp,
    this.minTemp,

  });

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.sizeOf(context).width;
    return Card(
      elevation: 10,
      color: const Color(0xff4A148C),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.amber, width: 2)
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
        ),
        width: width * 0.32,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(visible: dateNeed==1?true:false, child: Text('$date',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.amber)),),
            Visibility(visible: timeNeed==1?true:false, child: Text('$time',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white))),
            const SizedBox(height: 10,),

            _buildCircleAvatar(),
            const SizedBox(height: 10,),
            Text('$temperature°C',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.amber),),
            _buildMinMaxTemp(),
           const Text('Tap Here',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.amber))
          ],
        ),
      ),
    );
  }

  Column _buildMinMaxTemp() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Max: $maxTemp°C',style: const TextStyle(fontSize: 14,color: Colors.white)),
        Text('Min: $minTemp°C',style: const TextStyle(fontSize: 14,color: Colors.white)),
      ],
    );
  }

  CircleAvatar _buildCircleAvatar() {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.amber,
      child: CircleAvatar(
        radius: 45,
        child: netIcon == 0?
        Image.asset('$iconUrl', fit: BoxFit.cover, scale: 1.5,):
        Image.network('https:$iconUrl',fit: BoxFit.cover,scale: 1,),
      ),
    );
  }
}
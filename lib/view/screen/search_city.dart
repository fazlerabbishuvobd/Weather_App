import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/view/screen/verify_City.dart';

class SearchCity extends StatefulWidget {
  const SearchCity({super.key});

  @override
  State<SearchCity> createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {
  String? city, country, state;
  double? latitude, longitude;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Update'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: height*0.02,
            ),

            const Text('Choose Your Desire City',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: height*0.02,
            ),

            //City Picker
            _buildCityPicker(),
            SizedBox(
              height: height*0.07,
            ),

            const Text('Or Manually Type Your Desire City',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: height*0.02,
            ),
            _buildTextFieldCityName(),
            const Spacer(),

            //<---------------- Button -------------->
            _buildMaterialButtonSubmit(context),
            const SizedBox(
              height:10,
            ),
          ],
        ),
      ),
    );
  }

  MaterialButton _buildMaterialButtonSubmit(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (city != null) {
          Get.to(()=>VerifyCity(cityName: '$city'));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No City Selected',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),))
          );
        }
      },
      color: Colors.amber,
      minWidth: MediaQuery.sizeOf(context).width,
      height: 48,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Text('Submit',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
    );
  }

  TextField _buildTextFieldCityName() {
    return TextField(
      controller: _textEditingController,
      decoration: const InputDecoration(hintText: 'Enter Your City Name'),
      onChanged: (value) {
        setState(() {
          if (value.isNotEmpty) {
            city = value;
            country = '';
            state = '';
          } else {
            city = city;
          }
        });
      },
    );
  }

  CSCPicker _buildCityPicker() {
    return CSCPicker(
      onCountryChanged: (value) {
        setState(() {
          country = value;
        });
      },
      onStateChanged: (value) {
        setState(() {
          state = value;
        });
      },
      onCityChanged: (value) {
        setState(() {
          city = value;
        });
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/view/screen/home_page.dart';
import 'package:weather_app/view/widgets/settingPageWidgets.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Setting',
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(
                height: 30,
              ),

              SingleChildScrollView(
                child: Column(
                  children: [
                    _buildListTileOptionsChangeTheme(context),
                    const Divider(),

                    _buildListTileOptionsPrivacyPolicy(),
                    const Divider(),

                    _buildListTileOptionsAboutMe(context),
                    const Divider(),

                    _buildListTileOptionsContactUs(context),
                    const Divider(),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.offAll(() => const HomePage());
                },
                child: const ListTileOptions(
                  iconData1: Icons.home,
                  title: 'Back To Home',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTileOptions _buildListTileOptionsContactUs(BuildContext context) {
    return ListTileOptions(
      iconData1: Icons.contact_page,
      title: 'Contact Us',
      onPressed: () {
        Get.bottomSheet(
            isDismissible: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            backgroundColor: Colors.white,
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                height:
                    MediaQuery.sizeOf(context).height * 0.45,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      height: 10,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.amber,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: AssetImage('assets/images/fazlerabbi.jpg'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildName(),
                    _buildPosition(),
                    _buildLocation(),
                  ],
                )
            )
        );
      },
    );
  }

  Padding _buildLocation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: Card(
        elevation: 10,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          width: double.infinity,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.location_on),
              SizedBox(
                width: 20,
              ),
              Text('Dhaka, Bangladesh',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildPosition() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: Card(
        elevation: 10,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          width: double.infinity,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.work),
              SizedBox(width: 20,),
              Text('Flutter Developer',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: Card(
        elevation: 10,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          width: double.infinity,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.person),
              SizedBox(
                width: 20,
              ),
              Text('Fazle Rabbi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  ListTileOptions _buildListTileOptionsAboutMe(BuildContext context) {
    return ListTileOptions(
      iconData1: Icons.person,
      title: 'About Me',
      onPressed: () {
        Get.bottomSheet(
            isDismissible: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            backgroundColor: Colors.white,
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                height: MediaQuery.sizeOf(context).height * 0.45,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      height: 10,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.amber,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: AssetImage('assets/images/fazlerabbi.jpg'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildName(),
                    _buildPosition(),
                    _buildLocation(),
                  ],
                )
            )
        );
      },
    );
  }

  ListTileOptions _buildListTileOptionsPrivacyPolicy() {
    return ListTileOptions(
      iconData1: Icons.privacy_tip_outlined,
      title: 'Privacy Policy',
      onPressed: () {},
    );
  }

  ListTileOptions _buildListTileOptionsChangeTheme(BuildContext context) {
    return ListTileOptions(
      iconData1: Icons.light_mode,
      title: 'Change Theme',
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return const BottomModalSheetDemo();
          },
        );
      },
    );
  }
}


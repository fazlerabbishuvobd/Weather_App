import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTileOptions extends StatelessWidget {
  final IconData iconData1;
  final String title;
  final VoidCallback? onPressed;

  const ListTileOptions(
      {super.key,
        required this.iconData1,
        required this.title,
        this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 20,
        child: ListTile(
          leading: Icon(iconData1),
          title: Text(title),
          trailing: const Icon(Icons.arrow_circle_right_outlined),
        ),
      ),
    );
  }
}

class BottomModalSheetDemo extends StatefulWidget {
  const BottomModalSheetDemo({super.key});

  @override
  State<BottomModalSheetDemo> createState() => _BottomModalSheetDemoState();
}

class _BottomModalSheetDemoState extends State<BottomModalSheetDemo> {
  bool isSelected1 = false;
  bool isSelected2 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            height: 10,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.amber,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Choose Your Device Mode',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 16),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLightMode(),
              _buildDarkMode(),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  InkWell _buildDarkMode() {
    return InkWell(
      onTap: () async {
        setState(() {
          isSelected2 = true;
          isSelected1 = false;
          debugPrint('Dark Mode');
          Get.changeTheme(ThemeData.dark());
        });
      },
      child: ThemeMode(
        icon: Icons.dark_mode,
        iconColor: isSelected2 ? Colors.amber : Colors.white,
        mode: 'Dark Mode',
        fontColor: isSelected2 ? Colors.amber : Colors.white,
        containerColor:
        isSelected2 ? Colors.black : Colors.blueGrey,
      )
    );
  }

  InkWell _buildLightMode() {
    return InkWell(
      onTap: () async {
        setState(() {
          isSelected1 = true;
          isSelected2 = false;
          debugPrint('Light Mode');
          Get.changeTheme(ThemeData.light());
        });
      },
      child: ThemeMode(
        icon: Icons.light_mode,
        iconColor: isSelected1 ? Colors.black : Colors.white,
        mode: 'Light Mode',
        fontColor: isSelected1 ? Colors.black : Colors.white,
        containerColor:
        isSelected1 ? Colors.amber : Colors.blueGrey,
      )
    );
  }
}





class ThemeMode extends StatelessWidget {
  const ThemeMode({
    super.key,
    required this.icon,
    required this.mode,
    required this.containerColor,
    required this.iconColor,
    required this.fontColor,
  });

  final IconData icon;
  final String mode;
  final Color containerColor, iconColor, fontColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: containerColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor,),
          Text(mode, style: TextStyle(color: fontColor, fontSize: 16, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
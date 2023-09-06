import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({super.key});

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: height,
          width: width,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ShimmerContainer(h: height*0.06,w: width*0.5,),
                          SizedBox(height: height*0.01,),
                          ShimmerContainer(h: height*0.04,w: width*0.5,),
                        ],
                      ),
                      CircleAvatar(
                        radius: height*0.03,
                      ),
                  ],
                  ),
                  SizedBox(
                    height: height*0.045,
                  ),

                  //Temp
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerContainer(h: height*0.07,w:width*0.5,),
                          SizedBox(height: height*0.01,),
                          ShimmerContainer(h: height*0.04,w: width*0.2,),
                        ],
                      ),
                      ShimmerContainer(h: height*0.10,w: width*0.2,),
                    ],
                  ),
                  SizedBox(height: height*0.02,),

                  //humidity
                  ShimmerContainer(h: height*0.17,w: width,),
                  SizedBox(height: height*0.02,),

                  //tab bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ShimmerContainer(h: height*0.05,w: width*0.3,),
                      ShimmerContainer(h: height*0.05,w: width*0.3,),
                      ShimmerContainer(h: height*0.05,w: width*0.3,),
                    ],
                  ),
                  SizedBox(height: height*0.02,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ShimmerContainer(h: height*0.17,w: width*0.3,),
                      ShimmerContainer(h: height*0.17,w: width*0.3,),
                      ShimmerContainer(h: height*0.17,w: width*0.3,),

                    ],
                  ),
                  SizedBox(height: height*0.02,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerContainer(h: height*0.17,w: width*0.45,),
                      ShimmerContainer(h: height*0.17,w: width*0.45,),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerContainer extends StatelessWidget {
  final double h,w;
  const ShimmerContainer({
    super.key,
    required this.h,required this.w
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      height: h,
      width: w,
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InformationController extends StatelessWidget {
  const InformationController({super.key});

  void _showInformation(context){
    showCupertinoModalPopup<void>(context: context,
     builder: (BuildContext context) => Container(
        height: 150,
        padding: const EdgeInsets.only(top: 2.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.top,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: CarouselSlider(items: ['Glass', 'Metal', 'Paper','Plastic', 'Animal'].map((e) => Image.asset('assets/images/cards/$e.png')).toList(), 
          options: CarouselOptions(
          height: 400,
          aspectRatio: 16/9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
          )),
        ),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(child: Icon(Icons.info, color: Colors.white,) , onPressed: ()=>_showInformation(context));
  }
}
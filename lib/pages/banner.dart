import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(home: BannerDemo());
}

class BannerDemo extends StatelessWidget {
  final List<String> imgList = [
    'https://via.placeholder.com/600x300?text=图片1',
    'https://via.placeholder.com/600x300?text=图片2',
    'https://via.placeholder.com/600x300?text=图片3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('轮播图示例')),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 16 / 9,
              autoPlayInterval: Duration(seconds: 3),
            ),
            items: imgList.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(url, fit: BoxFit.cover, width: double.infinity),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

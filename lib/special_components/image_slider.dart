import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://vlebazaar.in/image/cache/catalog/Smartphone-M111-1800x900.jpg',
  'https://i0.wp.com/5.imimg.com/data5/YR/GV/UG/SELLER-9561275/interactive-graphic-design-service-500x500.jpg'
 ];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              child: Image.network(item, fit: BoxFit.fitWidth,width: double.infinity,)),
        ))
    .toList();



class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 130,
      width: double.infinity,

      child: Stack(children: [
          CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,

                height: 130,
                viewportFraction: 1.0,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white

                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ]),
    );
  }
}
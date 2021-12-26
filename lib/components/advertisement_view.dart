import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/models/advertisement_model.dart';
import 'package:oogie/models/advertisement_model.dart';

class AdvertisementView extends StatefulWidget {
  List<AdvertisementModel> advertisementModels;

  AdvertisementView({this.advertisementModels});

  @override
  State<AdvertisementView> createState() => _AdvertisementViewState();
}

class _AdvertisementViewState extends State<AdvertisementView> {
  int _current = 0;

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: double.infinity,
      child: Stack(children: [
        CarouselSlider(
          items: widget.advertisementModels.map((advertisementModel) {
            return InkWell(
              onTap: (){
                Navigator.pushNamed(
                    context, '/productFilter', arguments: {
                  'parentPage': 'advertisement',
                  'parentAdvertisementId': advertisementModel.id,
                });
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: Stack(
                    children: [
                      Text(advertisementModel.title,style: TextStyles.smallRegularSubdued,),

                      advertisementModel.imageUrl!=null?Image.network(
                        advertisementModel.imageUrl,
                        fit: BoxFit.fitWidth,
                        width: double.infinity,
                      ):Column(
                        children: [
                          Icon(Icons.photo,size: 32,),
                          // Text('No photo')

                        ],
                      ),
                    ],
                  )),
            );
          }).toList(),
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
              children: widget.advertisementModels.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
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

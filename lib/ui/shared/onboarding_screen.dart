import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicare/ui/route/route_names.dart';
import 'package:medicare/utils/constant_string.dart';
import 'package:medicare/utils/locator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  CarouselController _carouselController;

  List<SliderItem> page = [
    SliderItem(
        image: Constant.onBoardingOne,
        description:
            "Create appointment easily and meet skilled specialist"),
    SliderItem(
        image: Constant.onBoardingTwo,

        description:
            "Get Notifications regarding your medication when needed"),
    SliderItem(
        image: Constant.onBoardingThree,
        description:
            "Live a happy life, live a healthy life"),

  ];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    setupScreenUtil(context);
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h),
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: page.length,
              itemBuilder: (c, i, o) {
                return _sliderWidget(index: i, context: context);
              },
              options: CarouselOptions(
                  height: 432.h,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  scrollPhysics: BouncingScrollPhysics()),
            ),
          ),
          SizedBox(
            height: 41.h,
          ),
          Visibility(
            visible: currentIndex != page.length - 1,
            child: AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: page.length,
              effect: WormEffect(
                  dotWidth: 8,
                  dotHeight: 8,
                  activeDotColor: Color(0xff6EEB67),
                  dotColor: Theme.of(context).primaryColorLight),
            ),
          ),
          SizedBox(
            height: 71.h,
          ),
          InkWell(
            onTap: () {
              if (currentIndex == page.length - 1) {
                Get.offAndToNamed(RouteName.register);
                return;
              }

              currentIndex++;
              _carouselController.animateToPage(currentIndex++);
            },
            child: Container(
              height: 55.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xff5584DF)),
              child: Center(
                child: Text(
                  currentIndex != page.length - 1 ? "Next" : "Register".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          ScreenUtil().setSp(15, allowFontScalingSelf: true)),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 20.h,
          ),

          currentIndex == page.length - 1 ?  InkWell(
            onTap: () {
              if (currentIndex == page.length - 1) {
                Get.offAndToNamed(RouteName.login);
                return;
              }

              currentIndex++;
              _carouselController.animateToPage(currentIndex++);
            },
            child: Container(
              height: 55.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Color(0xff6EEB67),
                  ),
                   ),
              child: Center(
                child: Text(
                  "Login".toUpperCase(),
                  style: TextStyle(
                      color: Color(0xff6EEB67),
                      fontSize:
                      ScreenUtil().setSp(15, allowFontScalingSelf: true)),
                ),
              ),
            ),
          ) : SizedBox(height: 5,),

          SizedBox(
            height: 11.h,
          ),
          Center(
              child: FlatButton(
            onPressed: currentIndex != page.length - 1
                ? () {
                    if (currentIndex == page.length - 1) return;

                    currentIndex = page.length - 1;
                    _carouselController.animateToPage(page.length - 1);
                  }
                : null,
            child: Text(currentIndex != page.length - 1 ? "Skip" : "",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16, allowFontScalingSelf: true),
                )),
          ))
        ],
      ),
    )));
  }

  Widget _sliderWidget({int index, BuildContext context}) {
    SliderItem sliderItem = page[index];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10, right: 10
            ),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(sliderItem.image))),
            ),
          ),
        ),

        SizedBox(
          height: 20.h,
        ),
        Text(
          sliderItem.description,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(14, allowFontScalingSelf: true),
              color: Theme.of(context).primaryColorLight),
        ),
      ],
    );
  }
}

class SliderItem {
  String image;
  String description;

  SliderItem({this.image,  this.description});
}

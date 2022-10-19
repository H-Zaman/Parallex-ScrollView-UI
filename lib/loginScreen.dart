import 'package:flutter/material.dart';
import 'package:parallexscrollviewui/model.dart';
import 'package:parallexscrollviewui/resources/parallax_images.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final parallaxWidgetHeight = 450.0;
  double slideDelta = 0;

  List<ParallaxItemModel> parallaxItem =
  [
    ParallaxItemModel(asset: ParallaxImages.mountain1, deltaFactor: 1),
    ParallaxItemModel(asset: ParallaxImages.mountain2, deltaFactor: 1),
    ParallaxItemModel(asset: ParallaxImages.mountain3, deltaFactor: 1),
    ParallaxItemModel(asset: ParallaxImages.mountain4, deltaFactor: 1),
    ParallaxItemModel(asset: ParallaxImages.mountain5, deltaFactor: 1),
  ];
  // [
  //   ParallaxItemModel(asset: ParallaxImages.garden1, deltaFactor: 1),
  //   ParallaxItemModel(asset: ParallaxImages.garden2, deltaFactor: 1.2),
  //   ParallaxItemModel(asset: ParallaxImages.garden3, deltaFactor: 1.2),
  //   ParallaxItemModel(asset: ParallaxImages.garden4, deltaFactor: 1.3),
  //   ParallaxItemModel(asset: ParallaxImages.garden5, deltaFactor: 1.4),
  //   ParallaxItemModel(asset: ParallaxImages.garden6, deltaFactor: 1.5),
  //   ParallaxItemModel(asset: ParallaxImages.garden7, deltaFactor: 1.6),
  //   ParallaxItemModel(asset: ParallaxImages.garden8, deltaFactor: 1.7),
  //   ParallaxItemModel(asset: ParallaxImages.garden9, deltaFactor: 1.8),
  //   ParallaxItemModel(asset: ParallaxImages.garden10, deltaFactor: 1.4),
  //   ParallaxItemModel(asset: ParallaxImages.garden11, deltaFactor: 2.0),
  // ];

  late ScrollController _screenScrollController;
  Color _color = Color(0xff372D3B);

  @override
  void initState() {
    super.initState();
    _screenScrollController = ScrollController();
  }

  @override
  void dispose() {
    _screenScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color,
      body: NotificationListener(
        onNotification: (event){

          if(event is ScrollUpdateNotification){
            for (int i = 0; i<parallaxItem.length;i++){
              parallaxItem[i].topDelta -= event.scrollDelta! / parallaxItem[i].deltaFactor;
            }
            setState(() {});
          }

          return true;
        },
        child: Stack(
          children: [
            ParallaxWidget(
              height: parallaxWidgetHeight,
              assets: parallaxItem.reversed.toList(),
            ),

            Positioned(
              left: 0,
              right: 0,
              top: -2,
              bottom: 0,
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                controller: _screenScrollController,
                child: Column(
                  children: [
                    SizedBox(height: parallaxWidgetHeight),
                    Container(
                      height: MediaQuery.of(context).size.height - (parallaxWidgetHeight/2),
                      color: _color,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: (){
                            _screenScrollController.animateTo(
                              _screenScrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.easeIn
                            );
                          },
                          child: Text(
                            'Show Content'
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}

class ParallaxWidget extends StatelessWidget {

  final double height;
  final List<ParallaxItemModel> assets;

  const ParallaxWidget({
    Key? key,
    required this.height,
    required this.assets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: assets.map((item) => Positioned(
        top: item.topDelta,
        left: 0,
        right: 0,
        child: Image.asset(
          item.asset,
          fit: BoxFit.cover,
          height: height,
        ),
      )).toList()
    );
  }
}

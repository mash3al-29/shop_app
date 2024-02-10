
import 'package:flutter/material.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Shop_Login_Screen.dart';

  class BoardingModel{
    final String image;
    final String title;
    final String Body;

  BoardingModel(this.image, this.title, this.Body);
  }
class On_Boarding_Screen extends StatefulWidget {

  @override
  _On_Boarding_ScreenState createState() => _On_Boarding_ScreenState();
}

class _On_Boarding_ScreenState extends State<On_Boarding_Screen> {
  List<BoardingModel> Boarding = [
    BoardingModel('assets/images/OnBoard_1.png', 'On Board 1 Title', 'On Board 1 Body'),
    BoardingModel('assets/images/OnBoard_2.png', 'On Board 2 Title', 'On Board 2 Body'),
    BoardingModel('assets/images/OnBoard_3.png', 'On Board 3 Title', 'On Board 3 Body'),
  ];

  var boardPageContoller = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: (){
                CacheHelper.PutData(key: 'OnBoarding',value: true,).then((value) {
                Navigator.pushAndRemoveUntil
                (context, MaterialPageRoute(builder: (context) => Shop_Login_Screen()),(Route<dynamic> route) => false);
                });
              },
              child: Text('Skip',style: TextStyle(color: Colors.purple[400]),),

          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index == 2){
                    isLast = true;
                    print('last');
                    print(isLast);
                  }else{
                    isLast = false;
                    print('not last');
                    print(isLast);
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardPageContoller,
                itemBuilder: (context,index) => BuildPageViewItem(Boarding[index]),
                itemCount: 3,
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardPageContoller, count: 3,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.purple[400],
                  ),
                ),
                Spacer(),
                FloatingActionButton
                  (
                  foregroundColor: Colors.white,
                    onPressed: (){
                    if(isLast == true){
                      CacheHelper.PutData(key: 'OnBoarding',value: true,).then((value) {
                      Navigator.pushAndRemoveUntil
                      (context, MaterialPageRoute(builder: (context) => Shop_Login_Screen()),(Route<dynamic> route) => false);
                      });
                    }else{
                      boardPageContoller.nextPage(duration: Duration(
                        milliseconds: 750,
                      ), curve: Curves.fastLinearToSlowEaseIn);
                    }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                    backgroundColor: Colors.purple[400],

                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildPageViewItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          width: 400,
          height: 300,
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
      ),
      Text(
        model.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,

        ),
      ),
      SizedBox(height: 20,),
      Text(
       model.Body,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,

        ),
      ),
      SizedBox(height: 35,),
    ],
  );
}

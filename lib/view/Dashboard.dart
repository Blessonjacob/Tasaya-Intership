// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tasaya_partner_application/constants/AppColors.dart';
import 'package:tasaya_partner_application/models/Dashboard_model.dart';
import 'package:tasaya_partner_application/view/DeliveryScreen.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  List<Dashboard_model> dashboardmodel = [];

  void _getInitialInfo() {
    dashboardmodel = Dashboard_model.getContent();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      backgroundColor: AppColors.semiblue,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Dashboard", style: TextStyle(fontWeight: FontWeight.bold),),
      actions: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.notification_important_rounded),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.person),
        ),
      ],),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35.0),
                    bottomRight: Radius.circular(35.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: AppColors.secondaryColor
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(text: const TextSpan(children: [
                            TextSpan(
                                text: "Today "
                                    ""
                                    "orders\n",
                                style: TextStyle(color: AppColors.lightgrey)
                            ),
                            TextSpan(
                                text: "Completed",//Claim order now
                                style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,)
                            )
                          ])),
                          const SizedBox(width: 20,),
                          Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.primaryColor, spreadRadius: 5)],
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text("05", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              )
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          children: [
                            Text("Current Status",style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),),
                            Spacer(),
                            SwitchExample(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    SizedBox(
                      height: 150,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: dashboardmodel.length,
                        itemBuilder: (BuildContext context, int index) {
                          // Your item builder logic here
                          return Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            color: Colors.white,
                            ),
                            width: 150.0,// Adjust the width as needed
                            child: Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "${(dashboardmodel[index].count)}\n",
                                    style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)
                                ),
                                TextSpan(
                                    text: (dashboardmodel[index].text),
                                    style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.normal,)
                                )
                              ])),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          // Your separator builder logic here
                          return const SizedBox(width: 10.0); // Adjust the width as needed
                        },
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 180,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0,right: 10,top:10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Today you earned",
                                          style: TextStyle(fontSize: 16,color: AppColors.lightgrey)),
                                      Text("Rs. 700",
                                          style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold,)),
                                      Text("25 Orders\n",
                                          style: TextStyle(fontSize:16,color: AppColors.lightgrey)
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Week so far",
                                          style: TextStyle(fontSize: 16,color: AppColors.lightgrey)),
                                      Text("Rs. 1400",
                                          style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold,)),
                                      Text("35 Orders",
                                          style: TextStyle(fontSize:16,color: AppColors.lightgrey)
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: ElevatedButton(onPressed: (){},style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor)
                              ), child:const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Withdraw money",style: TextStyle(color: Colors.black),),

                                  Icon(Icons.send,color: Colors.black,),
                                ],
                              ),),
                            ),
                          ],
                        ),

                      ),
                    ),
                    const SizedBox(height: 30,),
                    const SizedBox(height: 30,),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light0 = true;



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Transform.scale(
          scaleY: 0.9,
          child: Switch(
            value: light0,
            activeTrackColor: AppColors.primaryColor,
            onChanged: (bool value) {
              setState(() {
                light0 = value;
              });
            },
          ),
        ),
      ],
    );
  }
}

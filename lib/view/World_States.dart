import 'package:covidapp/Model/World_State_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:covidapp/Services/States_services.dart';
import 'package:covidapp/view/countries.dart';
class WorldState extends StatefulWidget {
  const WorldState({Key? key}) : super(key: key);

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState>with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }


  final colorList= <Color>[
  const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices State= StatesServices();
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height:MediaQuery.of(context).size.height *.01),
              FutureBuilder(
                  future: State.fetchWorkedStatesRecords(),
                  builder:(context,AsyncSnapshot<WorldStatesModel>snspshot){
                if(!snspshot.hasData){
return Expanded(
              flex:1,
              child:
              SpinKitFadingCircle(
              color: Colors.white,
                size: 50,
                controller: _controller,
           ),
               );
                }else{
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total": double.parse(snspshot.data!.cases!.toString()),
                          "Recovered": double.parse(snspshot.data!.recovered.toString()),
                          "Deaths": double.parse(snspshot.data!.deaths.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        colorList: colorList,
                        initialAngleInDegree: 0,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 25,
                        legendOptions: const LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.left,
                          showLegends: true,
                          legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
                        child: Card(
                          child: Column(
                            children: [
                              ReusableRow(title:'Total', value: snspshot.data!.cases.toString()),
                              ReusableRow(title:'Total', value:snspshot.data!.deaths.toString() ),
                              ReusableRow(title:'Total', value: snspshot.data!.recovered.toString() ),
                              ReusableRow(title: 'Active', value: snspshot.data!.active.toString()),
                              ReusableRow(title: 'Critical', value: snspshot.data!.critical.toString()),
                              ReusableRow(title: 'Today Deaths', value: snspshot.data!.todayDeaths.toString()),
                              ReusableRow(title: 'Today Recovered', value:snspshot.data!.todayRecovered.toString()),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>  CountriesListScreen()));
                    },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color:Color(0xff1aa260),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'Track Contrious',
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),

            ],
          ),
        ),
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {
  String title,value;
  ReusableRow({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 10),
      child: Column(
children: [
  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
  ),
  SizedBox(height: 5,),
  Divider(),
],


      ),
    );
  }
}


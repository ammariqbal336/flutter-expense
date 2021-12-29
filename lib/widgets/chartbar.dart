import 'package:flutter/material.dart';
class ChartBar extends StatelessWidget {
  final String title;
  final double amount;
  final double amountPer;
  
  const ChartBar( {
    required this.title,
    required this.amount,
    required this.amountPer,
     Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constraints){
        return Column(
          children: [
        Container(
          height: constraints.maxHeight * 0.15,
          child: FittedBox(
            child: Text('\$$amount')),
        ),
        SizedBox(height: constraints.maxHeight * 0.05,),
        Container(
          height: constraints.maxHeight * 0.6,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  
                  heightFactor: amountPer,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),  
        Container(height: constraints.maxHeight * 0.15, child: FittedBox(child: Text(title)))
      ],
    );
  
    },);
    
    }
}
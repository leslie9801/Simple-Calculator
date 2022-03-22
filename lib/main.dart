import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget{

  homeState createState()=> homeState();
}



class homeState extends State<home>{


  late String buttonText = "";
  String equation = '0';
  String result = '0';
  String expression = "";
  late Color color;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == 'AC'){
        equation = "0";
        result = "0";
      }
      else if(buttonText == "BS"){
        equation = equation.substring(0,equation.length-1);
        if(buttonText == ""){
          equation ='0';
        }
      }
      else if(buttonText == '='){
        expression = equation;
        expression = expression.replaceAll('x', '*');
        try{
          Parser p =new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          equation = result;
        }catch(e){
          result = "Error";
        }
      }
      else{
        if(equation == "0"){
          equation = buttonText;
        }
        else{
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.grey.shade400,
                    alignment: Alignment.centerRight,
                    child: Text('$equation', style: TextStyle(
                      fontSize: 70,
                    )),
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  color: Colors.grey.shade400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('$result', style: TextStyle(
                          fontSize: 45,
                          color: Colors.black.withOpacity(0.5),
                      )),
                      Divider(color: Colors.grey.shade400,)
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:[
                      Container(
                          width: 170,
                          child: buildButton('AC',Colors.green.shade100)
                      ),
                      buildButton('%', Colors.blue.shade100),
                    buildButton("BS", Colors.blue.shade100)
                    ]
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                    buildButton('7', Colors.grey.shade200),
                    buildButton('8', Colors.grey.shade200),
                    buildButton('9', Colors.grey.shade200),
                    buildButton('x', Colors.blue.shade100)
                  ]
                ),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:[
                      buildButton('4', Colors.grey.shade200),
                      buildButton('5', Colors.grey.shade200),
                      buildButton('6', Colors.grey.shade200),
                      buildButton('/', Colors.blue.shade100)
                    ]
                ),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:[
                      buildButton('1', Colors.grey.shade200),
                      buildButton('2', Colors.grey.shade200),
                      buildButton('3', Colors.grey.shade200),
                      buildButton('-', Colors.blue.shade100)
                    ]
                ),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:[
                     Container(
                       width: 170,
                         child: buildButton('=',Colors.grey.shade400,)
                     ),
                      buildButton('00', Colors.grey.shade200),
                      buildButton('+', Colors.blue.shade100)
                    ]
                ),
                SizedBox(height: 10)
              ],
            ),
          )
        ),
      ),
    );
  }


  Widget buildButton(String buttonText, Color color,){
    return Container(
      child: ElevatedButton(
          onPressed: (){
            buttonPressed(buttonText);
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
              ),
              fixedSize: Size(80, 80),
              primary: color,
              elevation: 0
          ),
          child: Text(
            '$buttonText',
            style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w300,
                color: Colors.black
            ),
          )),
    );
  }


}

void main(){
  runApp(home());
}




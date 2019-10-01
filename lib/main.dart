import 'package:flutter/material.dart';

void main() => runApp(MyApp());
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

  final TextEditingController _acontroller = TextEditingController();
  final TextEditingController _bcontroller = TextEditingController();
  final TextEditingController _ccontroller = TextEditingController();
  double a = 0.0, b = 0.0, c = 0.0, result = 0.0;
  String bmr, eqn1, gdr1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[200],
        accentColor: Colors.yellowAccent[200],
        fontFamily: 'Gochi Hand',
      ),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('BMR Calculator'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("BMR Equation:", style: TextStyle(
              fontSize: 25, color: Theme.of(context).accentColor
            ),),
            DropdownButton<String>(
                  isExpanded: true,
                  items: [
                    DropdownMenuItem<String>(
                      child: Text('Mifflin-St Jeor'),
                      value: 'Mifflin-St Jeor',
                    ),
                    DropdownMenuItem<String>(
                      child: Text('Harris-Benedict'),
                      value: 'Harris-Benedict',
                    ),
                  ],
                  onChanged: (String value) {
                    setState(() {
                      eqn1 = value;
                    });
                  },
                  value: eqn1,
                  style: TextStyle(fontSize: 25),
                ),
            Text("Gender:", style: TextStyle(
              fontSize: 25, fontFamily: 'Gochi Hand', color: Theme.of(context).accentColor
            ),),
            DropdownButton<String>(
                  isExpanded: true,
                  items: [
                    DropdownMenuItem<String>(
                      child: Text('Female'),
                      value: 'Female',
                    ),
                    DropdownMenuItem<String>(
                      child: Text('Male'),
                      value: 'Male',
                    ),
                  ],
                  onChanged: (String value) {
                    setState(() {
                      gdr1 = value;
                    });
                  },
                  value: gdr1,
                  style: TextStyle(fontSize: 25),
                ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Age",
                ),
                keyboardType: TextInputType.numberWithOptions(),
                controller: _ccontroller,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Height(cm)",
                ),
                keyboardType: TextInputType.numberWithOptions(),
                controller: _acontroller,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Weight(kg)",
                ),
                keyboardType: TextInputType.numberWithOptions(),
                controller: _bcontroller,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: RaisedButton(
                child: Text("Calculate BMR"),
                onPressed: _onPress,
              ),
            ),
            Text("BMR: $bmr"),
          ],
        ),
      ),
    );
  }
  void _onPress() {
    setState(() {
      a = double.parse(_acontroller.text);
      b = double.parse(_bcontroller.text);
      c = double.parse(_ccontroller.text);
      if (eqn1 == 'Mifflin-St Jeor') {
        if (gdr1 == 'Female') {
          result = (10 * b) + (6.25 * a) - (5 * c) - 161;
        } else if (gdr1 == 'Male') {
          result = (10 * b) + (6.25 * a) - (5 * c) + 5;
        }
      } else if (eqn1 == 'Harris-Benedict') {
        if (gdr1 == 'Male') {
          result = ((13.75 * b) + (5.003 * a) - (6.755 * c) + 66.47);
        } else if (gdr1 == 'Female') {
          result = ((9.563 * b) + (1.85 * a) - (4.676 * c) + 655.1);
        }
      }
      bmr = format(result);
    });
  }
  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }
}

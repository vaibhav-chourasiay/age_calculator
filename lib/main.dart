import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Age CalCulator",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
// we use SingleTickerProvideStateMixin for single animation

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation? animation;
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  var dk;
  num mon = 0;
  double age = 0.0;
  num? selectedage;
  // this function for counting age and month
  //value is year and value2 is month

  countage(value, value2) {
    // print(value.runtimeType);

    var currentmouth = int.parse("${DateTime.now().month}");
    age = 2021.0 - value;
    print(value2.runtimeType);
    var checkmin = currentmouth - value2;
    if (checkmin < 0) {
      age--;
      mon = 12 - checkmin;
    } else {
      mon = currentmouth - value2;
    }

    animation = Tween(begin: 0, end: age).animate(animationController!);

    animationController!.addListener(() {
      setState(() {});
    });
    // I don't why we use 0.0 value but it works
    animationController!.forward(from: 0.0);

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    mon = 0;
    age = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Age Calculator"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              // use async for delay
              // because user can delay on chosing his/her date of birth
              onPressed: () async {
                dk = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2025));
                print(dk.year);
                print(dk.month);
                countage(dk.year, dk.month);
              },
              child: (age == 0.0)
                  ? Text("PicK Your Age Here !")
                  : Text("${animation!.value.toStringAsFixed(0)}"),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "YOUR AGE IS ${age.toStringAsFixed(0)} YEAR AND ${mon.toString()} MONTH"
                  .toLowerCase(),
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

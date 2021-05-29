import 'package:flutter/material.dart';
import './src/people.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Fetch Data'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            for (var person in people)
              ListTile(
                leading: Image.network(person.picture),
                title: Text(person.name),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        Scaffold(body: PersonDetail(person)))),
              ),
          ],
        ),
      ),
    );
  }
}

class PersonDetail extends StatelessWidget {
  final Person person;
  const PersonDetail(this.person);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(person.name),
        Text(person.phone),
      ],
    );
  }
}

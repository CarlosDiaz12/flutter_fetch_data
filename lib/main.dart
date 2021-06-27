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
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          if (constraints.maxWidth > 600) {
            return WideLayout();
          } else {
            return NarrowLayout();
          }
        },
      ),
    );
  }
}

class PeopleList extends StatelessWidget {
  final void Function(Person) onPersonTapped;

  const PeopleList({required this.onPersonTapped});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        for (var person in people)
          ListTile(
            // leading: Image.network(person.picture),
            title: Text(person.name),
            onTap: () => onPersonTapped(person),
          ),
      ],
    );
  }
}

class NarrowLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PeopleList(
        onPersonTapped: (person) => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(),
              body: PersonDetail(person),
            ),
          ),
        ),
      ),
    );
  }
}

class WideLayout extends StatefulWidget {
  @override
  _WideLayoutState createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  Person? _person;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            child: PeopleList(
                onPersonTapped: (person) => setState(() => _person = person)),
            width: 250,
          ),
        ),
        Expanded(
          child: _person == null ? Placeholder() : PersonDetail(_person!),
          flex: 3,
        ),
      ],
    );
  }
}

class PersonDetail extends StatelessWidget {
  final Person person;
  const PersonDetail(this.person);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxHeight > 200) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MouseRegion(
                  child: Text(person.name),
                  onHover: (event) {
                    // print('Button hovered');
                  },
                  onEnter: (event) {
                    print('Enter event');
                  },
                ),
                Text(person.phone),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Contact Me'),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered))
                        return Colors.green;
                      return Theme.of(context)
                          .primaryColor; // Defer to the widget's default.
                    }),
                  ),
                )
              ],
            ),
          );
        } else {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(person.name),
                Text(person.phone),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Contact Me'),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered))
                        return Colors.green;
                      return Theme.of(context)
                          .primaryColor; // Defer to the widget's default.
                    }),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}

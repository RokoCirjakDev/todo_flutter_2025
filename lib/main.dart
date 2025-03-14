import 'package:flutter/material.dart';
import 'novi.dart';
void main() {
  runApp(const MainApp());
}

class Zadatak {
  String tekst;
  String prioritet;
  bool zavrseno;

  Zadatak(this.tekst, this.prioritet) : zavrseno = false {

    if (prioritet != "Visoki" && prioritet != "Srednji" && prioritet != "Niski") {
      throw ArgumentError("Prioritet mora biti Visoki, Srednji ili Niski");
    }
  }

  String getTekst() {
    return tekst;
  }

  String getPr() {
    return prioritet;
  }

  bool getEnd() {
    return zavrseno;
  }

  void end() {
    zavrseno = true;
  }

  void unend() {
    zavrseno = false;
  }
}

void izbrisiZavrsene(List<Zadatak> zadatci) {
  for (int i = 0; i < zadatci.length; i++) {
    bool end = zadatci[i].getEnd();
    if (end) {
      zadatci.removeAt(i);
      i--; // Adjust index after removal
      // UpdateList(); // Uncomment and define this function if needed
    }
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _darkmode = true;
  int _broj = 500;
  List<Zadatak> zadatci = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _darkmode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Task Aplikacija'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
              child:
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 2),
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: zadatci.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      color: zadatci[index].getPr() == "Visoki" ? Colors.red[_broj] : zadatci[index].getPr() == "Srednji" ? Colors.yellow[_broj] : Colors.green[_broj],
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Zadatak ${index+1}: ${zadatci[index].getTekst()}'),
                          ),
                          ElevatedButton(
                          onPressed: () {
                          zadatci.removeAt(index);
                          setState(() {});
                          },
                          child: const Icon(Icons.delete),
                          ),
                          Checkbox(
                            value: zadatci[index].getEnd(),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  zadatci[index].end();
                                } else {
                                  zadatci[index].unend();
                                }
                              });
                            },
                          ),


                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                ),
              ),
              ),
              Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Builder(
    builder: (context) =>
    ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddTaskScreen(addTaskCallback: (text, prioritet) {
            setState(() {
              zadatci.add(Zadatak(text, prioritet));
            });
          })),
        );
      },
      child: const Text('Novi zadatak'),
    ),
    ),
    ElevatedButton(
      onPressed: () {
        setState(() {
          _darkmode = !_darkmode;
          _broj = _darkmode ? 500 : 200;
        });
      },
      child: Text(_darkmode ? 'Light mode' : 'Dark mode'),
    ),
    ElevatedButton(
      onPressed: () {
        izbrisiZavrsene(zadatci);
        setState(() {});
      },
      child: const Icon(Icons.delete),
    ),
  ],
),

            ],
          ),
        ),
      ),
    );
  }
}

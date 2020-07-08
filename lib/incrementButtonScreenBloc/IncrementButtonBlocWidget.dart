import 'package:flutter/material.dart';
import 'package:weather_app/incrementButtonScreenBloc/IncrementButtonBlocBloc.dart';
import 'package:weather_app/incrementButtonScreenBloc/IncrementButtonBlocViewState.dart';

class IncrementButtonBlocWidget extends StatelessWidget {
  final IncrementButtonBlocBloc bloc = IncrementButtonBlocBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("BloC architecture"),
          backgroundColor: Colors.amberAccent,
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<IncrementButtonBlocViewState>(
                stream: bloc.counterStream,
                builder: (context, snapshot) => Text("You have pushed the button ${snapshot.data?.counterValue} times",
                    style: TextStyle(color: Colors.black, fontSize: snapshot.data?.counterSize ?? 20.0)),
              )
            ],
          ),
        ),
        floatingActionButton: StreamBuilder(
            builder: (context, snapshot) => new FloatingActionButton(
                  onPressed: () => bloc.incrementClicked.sink.add(Null),
                  backgroundColor: Colors.greenAccent,
                  tooltip: 'Increment',
                  child: new Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                )));
  }
}

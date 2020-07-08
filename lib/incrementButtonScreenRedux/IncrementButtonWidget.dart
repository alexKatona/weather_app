import 'package:flutter/material.dart';
import 'package:weather_app/incrementButtonScreenRedux/IncrementButtonActions.dart';
import 'package:weather_app/incrementButtonScreenRedux/IncrementButtonReducer.dart';
import 'package:weather_app/incrementButtonScreenRedux/IncrementButtonState.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ButtonIncrementWidget extends StatelessWidget {
  final Store store = createIncrementButtonStore();
  final String title;

  ButtonIncrementWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<IncrementButtonState>(
      store: store,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Redux architecture"),
          backgroundColor: Colors.greenAccent,
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Text(
                'You have pushed the button this many times:',
                style: TextStyle(color: Colors.black),
              ),
              new StoreConnector<IncrementButtonState, IncrementButtonState>(
                converter: (store) => store.state,
                builder: (context, widgetState) {
                  return new Text(
                    widgetState.counter.toString(),
                    style: TextStyle(color: Colors.black, fontSize: widgetState.counterSize),
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: new StoreConnector<IncrementButtonState, VoidCallback>(
          converter: (store) {
            return () => store.dispatch(Increment());
          },
          builder: (context, callback) {
            return new FloatingActionButton(
              onPressed: callback,
              backgroundColor: Colors.greenAccent,
              tooltip: 'Increment',
              child: new Icon(
                Icons.add,
                color: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }
}

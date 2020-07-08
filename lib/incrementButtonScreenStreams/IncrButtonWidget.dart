import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_stream_friends/flutter_stream_friends.dart';
import 'package:rxdart/rxdart.dart';

class MyApp extends StatelessWidget {
  static String appTitle = "Stream architecture";

  @override
  Widget build(BuildContext context) {
     return StreamBuilder<CounterScreenModel>(
        stream: CounterScreenStream(appTitle),
        initialData: CounterScreenModel(0, () {}, appTitle),
        builder: (context, snapshot) => buildHome(context, snapshot.data),
    );
  }

  Widget buildHome(BuildContext context, CounterScreenModel model) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.title),
      ),
      body: Center(
        child: Text(
          'Button tapped ${ model.count } time${ model.count == 1
              ? ''
              : 's' }.',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Use the `StreamCallback` here to wire up the events to the Stream.
        onPressed: model.onFabPressed,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CounterScreenStream extends StreamView<CounterScreenModel> {
  CounterScreenStream(
    String title, [
    VoidStreamCallback onFabPressed,
    int initialValue = 0,
  ]) : super(createStream(
          title,
          onFabPressed ?? VoidStreamCallback(),
          initialValue,
        ));

  // The method we use to create the stream that will continually deliver data
  // to the `buildHome` method.
  static Stream<CounterScreenModel> createStream(
    String title,
    VoidStreamCallback onFabPressed,
    int initialValue,
  ) {
    return Observable(onFabPressed) // Every time the FAB is clicked
        .map((_) => 1) // Emit the value of 1
        .scan(
            (int a, int b, int i) => a + b, // Add that 1 to the total
            initialValue)
        // Before the button is clicked, kick everything off by emitting 0
        .startWith(initialValue)
        // Convert the latest count and the event handler into the Widget Model
        .map((int count) => CounterScreenModel(count, onFabPressed, title));
  }
}

class CounterScreenModel {
  final String title;
  final int count;
  final VoidCallback onFabPressed;

  CounterScreenModel(this.count, this.onFabPressed, this.title);

  // If you've got a custom data model for your widget, it's best to implement
  // the == method in order to take advantage the performance optimizations
  // offered by the `Streams#distinct()` method. This will ensure the Widget is
  // repainted only when the Model has truly changed.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounterScreenModel && runtimeType == other.runtimeType && title == other.title && count == other.count;

  @override
  int get hashCode => title.hashCode ^ count.hashCode;

  @override
  String toString() => 'CounterScreenModel{title: $title, count: $count, onFabPressed: $onFabPressed}';
}

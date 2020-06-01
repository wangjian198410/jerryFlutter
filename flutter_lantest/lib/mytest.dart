import 'dart:async';

Future<void> mytest() async {
//  print('jerry test');
////  printOrderMessage();
////  print('jerry test111');

  print('Fetching user order...');
  //print(createOrderMessage());
  // new Future(() => print('object'));
  //print(await complete());
  //printOrderMessage();
//
//  scheduleMicrotask(() => print('scheduleMicrotask1'));
//  new Future(() => print('object1'));
//  new Future(() => print('object2'));
//  new Future(() => print('object3'));
//  new Future(() => print('object4'));
//  scheduleMicrotask(() => print('scheduleMicrotask2'));
//  scheduleMicrotask(() => print('scheduleMicrotask3'));
//  scheduleMicrotask(() => print('scheduleMicrotask4'));

//  streamString().listen((event) {
//    print(event);
//  });
//  var futures = await streamString().toList();
//  print('wewewe:$futures');
//  streamByBuild().stream.pipe(streamConsumer)
//
  print('Fetching user order done...');
}

Future<String> complete() {
  String name = "Jerry";
  print('22222222');

  Completer<String> c = new Completer();
  c.complete(name);

  return c.future;
}

StreamController<String> streamByBuild() {
  StreamController<String> sc = StreamController();
  return sc;
}

Stream<String> streamString() async* {
  yield* Stream.periodic(Duration(seconds: 2), (int a) {
    return 'stream$a';
  });
}

Future printOrderMessage() {
  //var order = await fetchUserOrder();
  print('22222222');

  return Future(() => print("dsdsds"));
}

Future<String> createOrderMessage() {
  //var order = await fetchUserOrder();
  print('22222222');

  return Future.value("dfsdfsdfsd");
}

Future<String> fetchUserOrder() =>
    // Imagine that this function is
// more complex and slow.
    Future.delayed(
      Duration(seconds: 2),
      () {
        print('ddddddddddddd');
        return 'Large Latte';
      },
    );

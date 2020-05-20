Future<void> mytest() {
//  print('jerry test');
////  printOrderMessage();
////  print('jerry test111');

  print('Fetching user order...');
  print(createOrderMessage());
  print('Fetching user order done...');
}

Future<String> createOrderMessage() async {
  var order = await fetchUserOrder();
  return 'Your order is: $order';
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

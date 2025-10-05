import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/provider/counter_controller.dart';

class ProviderEx extends StatelessWidget {
  const ProviderEx({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.read<CounterController>().increment();
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('Provider')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Enter something'),
            ),
          ),
          const SizedBox(height: 20),

          Selector<CounterController, int>(
            selector: (context, controller) => controller.counter,
            builder: (BuildContext context, int value, Widget? child) {
              print('Counter Value rebuilt');
              return Text(value.toString());
            },
          ),
          const SizedBox(height: 20),

          Selector<CounterController, String?>(
            selector: (BuildContext context, controller) => controller.userName,
            builder: (BuildContext context, String? userName, Widget? child) {
              print('userName Value rebuilt');
              return Text(userName ?? 'No name');
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<CounterController>().setUserName(controller.text);
            },
            child: const Text('submit'),
          ),
        ],
      ),
    );
  }
}

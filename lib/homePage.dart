import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController nameController;
  String name = '';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("pop_up"),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "name:",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(width: 12),
                Text(name),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text("Open Dialogue"),
              onPressed: () async {
                final enteredName = await opendialogue();
                if (enteredName == null || enteredName.isEmpty) return;
                setState(() => name = enteredName);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> opendialogue() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Your Name"),
          content: TextField(
            autofocus: true,
            controller: nameController,
            decoration: const InputDecoration(hintText: "Your Name"),
            onSubmitted: (_) => submit(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                submit();
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      );

  void submit() {
    Navigator.of(context).pop(nameController.text);
    nameController.clear();
  }
}

import 'package:blitz_feed/model/snip.dart';
import 'package:flutter/material.dart';

// Removed the import as it's not used anymore
// import '../widgets/SnipItem.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Removed the direct initialization here
  late Future<List<Snip>> _snipsFuture;
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _snipsFuture = Snip.fetchSnips(); // Fetching the snips here
  }

  void _addTodo() async {
    if (_textController.text.isNotEmpty) {
      final newSnips = await Snip.addSnip('Saurabh', _textController.text);
      // Since _snips is now a Future, this logic would need to be updated,
      // possibly by maintaining a local list or updating the data source.
      // For the sake of this example, we'll just clear the text.
      setState(() {
        _snipsFuture = Snip.fetchSnips(); // Fetching the snips here
      });
      _textController.clear();
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blitz Feed'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Snip>>(
                future: _snipsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final snips = snapshot.data!;
                    return ListView.builder(
                      itemCount: snips.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              '${snips[index].snipSender}: ${snips[index].snipText}'),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: 'Enter a todo',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.amber,
                      backgroundColor: Colors.black),
                  child: Text('Add'),
                  onPressed: _addTodo,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

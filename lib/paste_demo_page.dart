import 'package:flutter/material.dart';
import 'package:super_clipboard/super_clipboard.dart';

class PasteDemoPage extends StatefulWidget {
  const PasteDemoPage({
    super.key,
  });

  @override
  State<PasteDemoPage> createState() => _PasteDemoPageState();
}

class _PasteDemoPageState extends State<PasteDemoPage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextField Paste Demo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(_focusNode);
              },
              onLongPressEnd: _showMenu,
              child: IgnorePointer(
                child: TextFormField(
                  focusNode: _focusNode,
                  decoration: const InputDecoration(
                    labelText: 'Paste text here',
                  ),
                  controller: _controller,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMenu(LongPressEndDetails details) {
    final offset = details.globalPosition;
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy,
        MediaQuery.of(context).size.width - offset.dx,
        MediaQuery.of(context).size.height - offset.dy,
      ),
      items: [
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              PopupMenuItem(
                onTap: _paste,
                child: const Text('Paste'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _paste() async {
    final reader = await ClipboardReader.readClipboard();
    final plain = await reader.readValue(Formats.plainText);

    _controller.text = plain ?? '';
  }
}

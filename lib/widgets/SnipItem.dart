import 'package:blitz_feed/model/snip.dart';
import 'package:flutter/material.dart';

class SnipItem extends StatelessWidget {
  SnipItem({Key? key, required Snip snip})
      : _snip = snip,
        super(key: key);

  final Snip _snip;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Wrap(
        spacing: 10, // space between the widgets
        crossAxisAlignment:
            WrapCrossAlignment.start, // aligns the widgets vertically at center
        children: [
          Text(
            "${_snip.snipSender}!:",
          ),
          Text(
            _snip.snipText!,
          ),
        ],
      ),
    );
  }
}

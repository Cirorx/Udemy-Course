import 'package:flutter/material.dart';

import 'generic_dialog.dart';

Future<void> showMissingFieldsDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: "Missing fields",
    content: text,
    optionsBuilder: () => {
      "Ok": null,
    },
  );
}

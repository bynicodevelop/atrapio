import 'package:atrap_io/config/constants.dart';
import 'package:atrap_io/helpers/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClipBoardHelper {
  static Future<void> copy(BuildContext context, String linkId) async {
    await Clipboard.setData(
      ClipboardData(
        text: "$kDomain/l/$linkId",
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t(context)!.notificationLinkCopied),
      ),
    );
  }
}

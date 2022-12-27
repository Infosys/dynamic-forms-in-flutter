// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/widgets/edit_options/edit_widgets.dart';
import 'package:flutter/material.dart';

class TextHeadings extends StatelessWidget {
  const TextHeadings({Key? key, required this.map, this.ispreview = false})
      : super(key: key);

  final dynamic map;
  final bool ispreview;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Row(
              mainAxisAlignment: map['position'] == "Left Aligned"
                  ? MainAxisAlignment.start
                  : map['position'] == "Center Aligned"
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.end,
              children: [
                Text(
                  map['text'],
                  style: map['size'] == 'titleLarge'
                      ? Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.blue)
                      : map['size'] == 'titleMedium'
                          ? Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.blue)
                          : Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
        !ispreview
            ? Expanded(
                flex: 4,
                child: EditWidget(
                  map: map,
                  type: "textHeading",
                ))
            : Container()
      ],
    );
  }
}

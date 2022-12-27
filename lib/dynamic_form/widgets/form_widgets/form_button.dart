// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/widgets/edit_options/edit_widgets.dart';
import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  const FormButton({required this.map, this.ispreview = false, Key? key})
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
            padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
            child: Row(
              mainAxisAlignment: map['position'] == "Left Aligned"
                  ? MainAxisAlignment.start
                  : map['position'] == "Center Aligned"
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff008080))),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          map['title'],
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                        ),
                      )),
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
                  type: "button",
                ))
            : Container()
      ],
    );
  }
}

// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'package:dynamic_forms/dynamic_form/dynamic_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DropDownOptionsModel extends DynamicFormModel {
  late List<String> _options = [""];
  GlobalKey<FormBuilderState> _formKey = new GlobalKey<FormBuilderState>();
  get formKey => _formKey;

  get options => _options;
  void addOptions(value) {
    _options.add(value);
    notifyListeners();
  }

  void removeOptions(index) {
    _options.removeAt(index);
    notifyListeners();
  }

  void resetOptions() {
    _options = [""];
    notifyListeners();
  }

  DropDownOptionsModel();

  DropDownOptionsModel.fromJson(Map<String, dynamic> json) {
    _options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['options'] = options;
    return data;
  }
}

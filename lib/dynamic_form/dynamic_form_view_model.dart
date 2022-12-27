// “Copyright 2022 Infosys Ltd.
// Use of this source code is governed by Apache License 2.0 that can be found in the LICENSE file or at
// http://www.apache.org/licenses/LICENSE-2.0 .”

import 'dart:async';

import 'package:flutter/material.dart';

class DynamicFormModel with ChangeNotifier {
  bool _goToNextPage = true;
  bool _showerror = false;
  List<Map> _organList = [];
  List<Map> get organList => _organList;

  List<String> formList = ['Harvesting', 'Pledge', 'Request'];

  List<Map> _organDefaultFormList = [];
  List<Map> get organDefaultFormList => _organDefaultFormList;

  List<Map> _tenantForms = [];
  List<Map> get tenantForm => _tenantForms;

  int? _tenantActiveFormId;
  get tenantActiveFormId => _tenantActiveFormId;
  void setCurrentTenantActiveFormId(int val) {
    _tenantActiveFormId = val;
    notifyListeners();
  }

  String _selectedorgan = "";

  bool _isoragnelected = false;
  String _selectedform = "";

  bool get getgoToNextPage => _goToNextPage;
  bool get getshowerror => _showerror;
  bool get getisorganselected => _isoragnelected;
  String get getselectedform => _selectedform;
  String get getselectedorgan => _selectedorgan;

  List _form = [];

  void setgoToNextPage(value) {
    _goToNextPage = value;
    notifyListeners();
  }

  void setshowerror(value) {
    _showerror = value;
    notifyListeners();
  }

  void setform(value) {
    _form = value;
    notifyListeners();
  }

  String? _fieldType;
  String? get fieldType => _fieldType;
  List? get getForm => _form;

  void setFieldType(value) {
    (value);
    ("Checkpoint");
    _fieldType = value;
    (_fieldType);
    notifyListeners();
  }

  void setisorganselected(value) {
    _isoragnelected = value;
    notifyListeners();
  }

  void setselectedorgan(value) {
    _selectedorgan = value;
    notifyListeners();
  }

  void setselectedform(value) {
    _selectedform = value;
    notifyListeners();
  }

  void addinForm(value) {
    _form.add(value);
    (_form);
    notifyListeners();
  }

  void removefromform(value) {
    _form.remove(value);

    notifyListeners();
  }

  void moveup(map) {
    int ind = _form.indexOf(map);
    if (ind > 0) {
      _form.remove(map);
      _form.insert(ind - 1, map);
    }

    notifyListeners();
  }

  void movedown(map) {
    int ind = _form.indexOf(map);
    if (ind < (_form.length - 1)) {
      _form.remove(map);
      _form.insert(ind + 1, map);
    }

    notifyListeners();
  }

  //edit Testing

  bool _edit = false;
  Map _editmap = {};
  bool get getedit => _edit;
  Map get geteditmap => _editmap;

  void setedit(value, map) {
    _adding = false;
    _edit = value;
    _editmap = map;
    notifyListeners();
  }

  void editinform(int value, dynamic map) {
    _form[value] = map;
    notifyListeners();
  }

  //add testing
  bool _adding = false;
  int? _addindex;
  bool get getadding => _adding;

  void setadding(bool value, int index) {
    _edit = false;
    _adding = value;
    _addindex = index;
    notifyListeners();
  }

  void addinFormusingplus(dynamic map) {
    _form.insert(_addindex! + 1, map);
    _adding = false;
    notifyListeners();
  }

  String _getSelectedTenantForm = "";
  String get getSelectedTenantForm => _getSelectedTenantForm;

  void setSelectedTenantForm(String val) {
    _getSelectedTenantForm = val;
    (_getSelectedTenantForm.toString());
    notifyListeners();
  }

//******************* New Form Model ***********************\\

  bool _newFormSelected = false;
  get newFormSelected => _newFormSelected;
  void setNewFormSelected(val) {
    _newFormSelected = val;
    notifyListeners();
  }

  // Submit Button Logic

  bool _isSuccess = false;
  bool _showAlert = false;

  bool get getIsSuccess => _isSuccess;
  bool get getshowAlert => _showAlert;

  void setIsSuccess(val) {
    _isSuccess = val;
    notifyListeners();
  }

  void setshowAlert(val) {
    _showAlert = val;
    notifyListeners();
  }

  // Loader  Logic

  bool _isloading = false;

  bool get getisloading => _isloading;
  void setisloading(val) {
    _isloading = val;
    notifyListeners();
  }

  //******************* Stepper Contoller***********************\\

  int _currentStep = 0;
  int totalSteps = 0;

  int get getcurrentStep => _currentStep;
  int get gettotalSteps => totalSteps;

  void settotalSteps(steps) {
    totalSteps = steps;
    notifyListeners();
  }

  void continued() {
    if (_currentStep < totalSteps) {
      _currentStep += 1;
    }

    notifyListeners();
  }

  void cancel() {
    if (_currentStep > 0) {
      _currentStep -= 1;
    }
    notifyListeners();
  }

  String getFormString() {
    var temp = "";

    String formstring = _form.toString();
    int forlen = formstring.length;
    for (int i = 0; i < forlen; i++) {
      if ([",", "{", "["].contains(formstring[i])) {
        temp = "$temp${formstring[i]}\n   ";
      } else if (["}", "]"].contains(formstring[i])) {
        temp = "$temp\n   ${formstring[i]}";
      } else {
        temp = temp + formstring[i];
      }
    }

    return temp;
  }
}

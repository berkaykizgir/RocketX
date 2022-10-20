import 'package:rocketx/models/generic_model.dart';

class ErrorsModel extends GenericModel {
  List<ErrorModel>? _error;

  List<ErrorModel>? get error => _error;

  ErrorsModel(Map<String, dynamic> json) {
    if (json['error'] != null) {
      _error = <ErrorModel>[];
      json['error'].forEach((errorJSON) {
        _error!.add(ErrorModel(errorJSON));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_error != null) {
      data['error'] = _error!.map((error) => error.toJson()).toList();
    }
    return data;
  }
}

class ErrorModel {
  String? _code;
  String? _message;
  String? _field;

  ErrorModel(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _field = json['field'];
  }

  String? get code => _code;
  String? get message => _message;
  String? get field => _field;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = _code;
    data['message'] = _message;
    data['field'] = _field;
    return data;
  }
}

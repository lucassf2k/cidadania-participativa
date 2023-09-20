class Report{
  late String? _id;
  late String? _desc;
  late var _date;
  late var _photo;
  late var _geolocal;

  Report({String? id, String? desc, var date, var photo, var geolocal}) {
    if (id != null) {
      this._id = id;
    }
    if (desc != null) {
      this._desc = desc;
    }
    if (date != null) {
      this._date = date;
    }
    if (photo != null) {
      this._photo = photo;
    }
    if (geolocal != null) {
      this._geolocal = geolocal;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get desc => _desc;
  set desc(var desc) => _desc = desc;
  dynamic get date => _date;
  set date(var date) => _date = date;
  dynamic get geolocal => _geolocal;
  set geolocal(var geolocal) => _geolocal = geolocal;
  dynamic get photo => _photo;
  set photo(var photo) => _photo = photo;

  Report.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _desc = json['desc'];
    _date = json['date'];
    _photo = json['photo'];
    _geolocal = json['geolocal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['desc'] = this._desc;
    data['date'] = this._date;
    data['photo'] = this._photo;
    data['geolocal'] = this._geolocal;
    return data;
  }

  @override
  String toString() {
    return 'Report{ id: $_id, Descrição: $_desc, Date: $_date, Foto: $_photo, Localização: $_geolocal}';
  }
}
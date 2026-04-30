class Promoter {
  num? id;
  String? aadharNumber;
  int? dob;
  String? email;
  String? gender;
  String? mobile;
  String? name;
  String? pan;
  String? residence;
  Address? address;
  Address? permanentAddress;
  bool? isSameAsCurrentAddress;
  bool? editPromoter;

  Promoter({
    this.id,
    this.aadharNumber,
    this.dob,
    this.email,
    this.gender,
    this.mobile,
    this.name,
    this.pan,
    this.residence,
    this.address,
    this.permanentAddress,
    this.isSameAsCurrentAddress,
    this.editPromoter,
  });

  Promoter copyWith({
    num? id,
    String? aadharNumber,
    int? dob,
    String? email,
    String? gender,
    String? mobile,
    String? name,
    String? pan,
    String? residence,
    Address? address,
    Address? permanentAddress,
    bool? isSameAsCurrentAddress,
    bool? editPromoter,
  }) {
    return Promoter(
      id: id ?? this.id,
      aadharNumber: aadharNumber ?? this.aadharNumber,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      mobile: mobile ?? this.mobile,
      name: name ?? this.name,
      pan: pan ?? this.pan,
      residence: residence ?? this.residence,
      address: address ?? this.address,
      permanentAddress: permanentAddress ?? this.permanentAddress,
      isSameAsCurrentAddress:
          isSameAsCurrentAddress ?? this.isSameAsCurrentAddress,
      editPromoter: editPromoter ?? this.editPromoter,
    );
  }

  Promoter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aadharNumber = json['aadharNumber'];
    dob = json['dob'];
    email = json['email'];
    gender = json['gender'];
    mobile = json['mobile'];
    name = json['name'];
    pan = json['pan'];
    residence = json['residence'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    permanentAddress = json['permanentAddress'] != null
        ? Address.fromJson(json['permanentAddress'])
        : null;
    isSameAsCurrentAddress = json['isSameAsCurrentAddress'];
    editPromoter = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['aadharNumber'] = aadharNumber;
    data['dob'] = dob;
    data['email'] = email;
    data['gender'] = gender;
    data['mobile'] = mobile;
    data['name'] = name;
    data['pan'] = pan;
    data['residence'] = residence;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (permanentAddress != null) {
      data['permanentAddress'] = permanentAddress!.toJson();
    }
    data['isSameAsCurrentAddress'] = isSameAsCurrentAddress;
    return data;
  }
}

class Address {
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? city;
  String? state;
  String? pincode;

  Address({
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.city,
    this.state,
    this.pincode,
  });

  Address copyWith({
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? city,
    String? state,
    String? pincode,
  }) {
    return Address(
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      addressLine3: addressLine3 ?? this.addressLine3,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
    );
  }

  Address.fromJson(Map<String, dynamic> json) {
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    addressLine3 = json['addressLine3'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addressLine1'] = addressLine1;
    data['addressLine2'] = addressLine2;
    data['addressLine3'] = addressLine3;
    data['city'] = city;
    data['state'] = state;
    data['pincode'] = pincode;
    return data;
  }
}

import 'package:wizard/app/modules/auth/domain/vos/address/city.dart';
import 'package:wizard/app/modules/auth/domain/vos/address/district.dart';
import 'package:wizard/app/modules/auth/domain/vos/address/number.dart';
import 'package:wizard/app/modules/auth/domain/vos/address/state.dart';
import 'package:wizard/app/modules/auth/domain/vos/address/street.dart';
import 'package:wizard/app/modules/auth/domain/vos/address/zip_code.dart';

class Address {
  ZipCode _zipCode;
  State _state;
  City _city;
  Street _street;
  Number _number;
  District _district;

  ZipCode get zipCode => _zipCode;
  void setZipCode(String value) => _zipCode = ZipCode(value);

  State get state => _state;
  void setState(String value) => _state = State(value);

  City get city => _city;
  void setCity(String value) => _city = City(value);

  Street get street => _street;
  void setStreet(String value) => _street = Street(value);

  Number get number => _number;
  void setNumber(String value) => _number = Number(value);

  District get district => _district;
  void setDistrict(String value) => _district = District(value);

  Address({
    required zipCode,
    required state,
    required city,
    required street,
    required number,
    required district,
  })  : _zipCode = ZipCode(zipCode),
        _state = State(state),
        _city = City(city),
        _street = Street(street),
        _number = Number(number),
        _district = District(district);

  factory Address.empty() => Address(
      zipCode: '', state: '', city: '', street: '', number: '', district: '');
}

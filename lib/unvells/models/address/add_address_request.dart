/*
 *
  

 *
 * /
 */

class AddAddressRequest {
  String? prefix;
  String? firstName;
  String? middleName;
  String? lastName;
  String? suffix;
  String? email;
  String? telephone;
  String? company;
  String? fax;
  List<String>? street;
  String? city;
  String? postcode;
  String? city_id;
  String? region_id;
  String? regionName;
  String? country_id;
  String? countryName;
  int? default_billing;
  int? default_shipping;
  int? save_address;

  String? address_title;
  String? apt_number;
  String? building_name;
  String? floor;
  String? avenue;
  List? custom_attributes;


  AddAddressRequest(
      {this.prefix,
      this.firstName,
      this.middleName,
      this.lastName,
      this.suffix,
      this.email,
      this.telephone,
      this.company,
      this.fax,
      this.street,
      this.city,
      this.postcode,
      this.region_id,
      this.regionName,
      this.country_id,
        this.city_id,
      this.countryName,
      this.default_billing,
      this.default_shipping,
      this.save_address,
        this.address_title,
          this.apt_number,
          this.building_name,
          this.floor,
          this.avenue,
        this.custom_attributes
      });
}

/*
 *


 *
 * /
 */

class BillingDataRequest {
  String? addressId;
  NewAddress? newAddress;
  int? sameAsShipping;

  BillingDataRequest({
    this.addressId, this.newAddress, this.sameAsShipping});

}

class NewAddress {
  int? saveInAddressBook;
  String? fax;
  String? city;
  String? region;
  String? prefix;
  String? suffix;
  List<String>? street;
  String? company;
  String? lastName;
  String? postcode;
  String? region_id;
  String? firstName;
  String? telephone;
  String? middleName;
  String? country_id;
  String? address_title;


  NewAddress(
      {this.saveInAddressBook,
      this.fax,
      this.city,
      this.region,
      this.prefix,
      this.suffix,
      this.street,
      this.company,
      this.lastName,
      this.postcode,
      this.region_id,
      this.firstName,
      this.telephone,
      this.middleName,
      this.country_id,
      this.address_title});
}
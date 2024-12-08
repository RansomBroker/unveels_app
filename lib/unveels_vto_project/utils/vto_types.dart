import 'package:test_new/unveels_vto_project/utils/vto_constants.dart';

enum MenuVto { makeup, accesories }

enum VtoType {
  lips,
  eyes,
  face,
  nails,
  hair,
  headAcc,
  neckAcc,
  handAcc,
  nailsAcc
}

class VtoSubTypes {
  static List<String> lipsType = [
    VtoConstants.lipColor,
    VtoConstants.lipLiner,
    VtoConstants.lipPlumper
  ];

  static List<String> eyesType = [
    VtoConstants.eyebrows,
    VtoConstants.eyeShadow,
    VtoConstants.eyeLiner,
    VtoConstants.lenses,
    VtoConstants.eyeLashes
  ];

  static List<String> faceType = [
    VtoConstants.foundation,
    VtoConstants.concealer,
    VtoConstants.contour,
    VtoConstants.blusher,
    VtoConstants.bronzer,
    VtoConstants.highlighter
  ];

  static List<String> nailsType = [
    VtoConstants.nailPolish,
    VtoConstants.pressOnNails,
  ];

  static List<String> hairType = [
    VtoConstants.hairColor,
  ];

  static List<String> headAccType = [
    VtoConstants.sunglasses,
    VtoConstants.glasses,
    VtoConstants.earrings,
    VtoConstants.headband,
    VtoConstants.hats,
    VtoConstants.tiaras
  ];

  static List<String> neckAccType = [
    VtoConstants.pendants,
    VtoConstants.necklaces,
    VtoConstants.chokers,
    VtoConstants.scarves,
  ];

  static List<String> handAccType = [
    VtoConstants.watches,
    VtoConstants.rings,
    VtoConstants.bracelets,
    VtoConstants.bangles,
  ];

  static List<String> nailsAccType = [
    VtoConstants.nailPolish,
    VtoConstants.pressOnNails,
  ];

  static List<String> getSubTypes(VtoType? type, MenuVto parent) {
    if (parent == MenuVto.makeup) {
      return switch (type) {
        VtoType.lips => VtoSubTypes.lipsType,
        VtoType.eyes => VtoSubTypes.eyesType,
        VtoType.face => VtoSubTypes.faceType,
        VtoType.nails => VtoSubTypes.nailsType,
        VtoType.hair => VtoSubTypes.hairType,
        _ => [],
      };
    } else if (parent == MenuVto.accesories) {
      return switch (type) {
        VtoType.headAcc => VtoSubTypes.headAccType,
        VtoType.neckAcc => VtoSubTypes.neckAccType,
        VtoType.handAcc => VtoSubTypes.handAccType,
        VtoType.nailsAcc => VtoSubTypes.nailsAccType,
        _ => [],
      };
    }
    return [];
  }
}

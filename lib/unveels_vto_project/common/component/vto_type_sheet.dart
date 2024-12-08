import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:test_new/unveels_vto_project/src/camera2/accessories/hand/bangles_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/accessories/hand/bracelets_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/accessories/hand/rings_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/accessories/hand/watches_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/accessories/head/head_earrings_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/accessories/head/head_hats_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/accessories/head/head_headband_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/accessories/head/head_sunglasses_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/accessories/head/head_tiaras_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/accessories/nails/presonnails_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/accessories/neck/chokers_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/accessories/neck/necklaces_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/accessories/neck/pendant_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/accessories/neck/scarves_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/makeup/eyes/eyebrows_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/makeup/eyes/eyeliner_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/makeup/eyes/eyeshadow_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/makeup/eyes/lashes_mascara_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/makeup/eyes/lenses_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/makeup/face/blusher_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/makeup/face/bronzer_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/makeup/face/concealer_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/makeup/face/contour_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/makeup/face/foundation_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/makeup/face/highlighter_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/makeup/hair/hair_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/makeup/lips/lip_color_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/makeup/lips/lip_liner_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/makeup/lips/lip_plumber_view.dart';
import 'package:test_new/unveels_vto_project/src/camera2/makeup/nails/nail_polish_view.dart';
import 'package:test_new/unveels_vto_project/utils/vto_constants.dart';

class VtoTypeSheet extends StatelessWidget {
  final String subType;
  final InAppWebViewController? webViewController;

  const VtoTypeSheet({
    super.key,
    required this.subType,
    this.webViewController,
  });

  @override
  Widget build(BuildContext context) {
    return switch (subType) {
      // Lips
      VtoConstants.lipColor => LipColorView(webViewController: webViewController),
      VtoConstants.lipLiner => LipLinerView(webViewController: webViewController),
      VtoConstants.lipPlumper => LipPlumberView(webViewController: webViewController),

      // Eyes
      VtoConstants.eyebrows => EyebrowsView(webViewController: webViewController),
      VtoConstants.eyeShadow => EyeshadowView(webViewController: webViewController),
      VtoConstants.eyeLiner => EyelinerView(webViewController: webViewController),
      VtoConstants.lenses => LensesView(webViewController: webViewController),
      VtoConstants.eyeLashes => LashesMascaraView(webViewController: webViewController),

      // Face
      VtoConstants.foundation => FoundationView(webViewController: webViewController),
      VtoConstants.concealer => ConcealerView(webViewController: webViewController),
      VtoConstants.contour => ContourView(webViewController: webViewController),
      VtoConstants.blusher => BlusherView(webViewController: webViewController),
      VtoConstants.bronzer => BronzerView(webViewController: webViewController),
      VtoConstants.highlighter => HighlighterView(webViewController: webViewController),

      // Nails
      VtoConstants.nailPolish => NailPolishView(webViewController: webViewController),
      VtoConstants.pressOnNails => PresOnNailsAccView(webViewController: webViewController),

      // Hair
      VtoConstants.hairColor => HairView(webViewController: webViewController),

      // Head Accessories
      VtoConstants.sunglasses => HeadSunglassesView(webViewController: webViewController),
      VtoConstants.glasses => HeadSunglassesView(webViewController: webViewController),
      VtoConstants.earrings => HeadEarringsView(webViewController: webViewController),
      VtoConstants.headband => HeadHeadbandView(webViewController: webViewController),
      VtoConstants.hats => HeadHatsView(webViewController: webViewController),
      VtoConstants.tiaras => HeadTiarasView(webViewController: webViewController),

      // Neck Accessories
      VtoConstants.pendants => PendantsView(webViewController: webViewController),
      VtoConstants.necklaces => NecklacesView(webViewController: webViewController),
      VtoConstants.chokers => ChokersView(webViewController: webViewController),
      VtoConstants.scarves => ScarvesView(webViewController: webViewController),

      // Hand Accessories
      VtoConstants.watches => WatchesView(webViewController: webViewController),
      VtoConstants.rings => RingsView(webViewController: webViewController),
      VtoConstants.bracelets => BraceletsView(webViewController: webViewController),
      VtoConstants.bangles => BanglesView(webViewController: webViewController),

      _ => Text(subType)
    };
  }
}

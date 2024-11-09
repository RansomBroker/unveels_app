import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../unvells/models/productDetail/product_new_model.dart';
import '../../unvells/screens/product_detail/bloc/product_detail_screen_repository.dart';
import 'get_product_details_state.dart';

class GetProductDetailsNewBloc extends Cubit<GetProductDetailsState> {
  GetProductDetailsNewBloc({required this.getProductDetailsRepoImp})
      : super(const GetProductDetailsState.initial());

  static GetProductDetailsNewBloc of(BuildContext context) =>
      BlocProvider.of<GetProductDetailsNewBloc>(context);

  final ProductDetailScreenRepositoryImp getProductDetailsRepoImp;

  ProductsNewModel? model;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailOfAddresseeController =
      TextEditingController();
  final TextEditingController nameOfAddresseeController =
      TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  get({required String sku}) async {
    try {
      emit(const GetProductDetailsState.loading());

      final result =
          await getProductDetailsRepoImp.getProductDetailTryOnData(sku);
      model = result;

      emit(GetProductDetailsState.success(model: result));
    } catch (e) {
      emit(const GetProductDetailsState.error(error: ''));
    }
  }

  Amount? selectedAMount;

  void selectAmount(Amount amount) {
    selectedAMount = amount;
  }

  void selectTimeZone(BssGetListTimezone time) {
    selectedTimeZone = time;
  }

  Template? selectedTemplate;
  BssGetListTimezone? selectedTimeZone;
  List<bool> isSelectedImage = [];
  TemplateImages? selectedImage;

  void selectTemplate({
    required Template template,
    // required int imagesCount,imagesCount
  }) {
    // debugPrint("selectTemplate$imagesCount");
    selectedTemplate = template;
  }

  void selectTemplateImage({
    required TemplateImages image,
    // required int imagesCount,imagesCount
  }) {
    // debugPrint("selectTemplate$imagesCount");
    selectedImage = image;
  }
}

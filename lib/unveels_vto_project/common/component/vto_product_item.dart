import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_vto_project/common/helper/constant.dart';
import 'package:test_new/unvells/screens/home/widgets/item_card_bloc/item_card_bloc.dart';
import 'package:test_new/unvells/screens/home/widgets/item_card_bloc/item_card_event.dart';

class VtoProductItem extends StatefulWidget {
  const VtoProductItem({
    super.key,
    required this.product,
  });

  final ProductData product;

  @override
  State<VtoProductItem> createState() => _VtoProductItemState();
}

class _VtoProductItemState extends State<VtoProductItem> {
  ItemCardBloc? itemCardBloc;

  @override
  Widget build(BuildContext context) {
    itemCardBloc = context.read<ItemCardBloc>();
    return InkWell(
        onTap: () async {},
        child: SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 15, 10),
                color: Colors.white,
                width: 150,
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 9,
                        child: Image.network(
                          widget.product.imageUrl,
                          width: double.infinity,
                        )),
                    const Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                          size: 18,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.product.name,
                style: Constant.whiteBold16.copyWith(fontSize: 11),
              ),
              Text(
                widget.product.brand,
                style: Constant.whiteRegular12
                    .copyWith(fontWeight: FontWeight.w300, fontSize: 10),
              ),
              Row(
                children: [
                  Text("KWD ${widget.product.price.toString()}",
                      style: Constant.whiteRegular12.copyWith(fontSize: 10)),
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      itemCardBloc?.add(AddtoCartEvent(
                          widget.product.id.toString(), 1, const {}));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      color: const Color(0xFFC89A44),
                      child: const Center(
                          child: Text(
                        "Add to cart",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      )),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

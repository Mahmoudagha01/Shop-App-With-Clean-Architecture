// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shopack_user/core/colors/colors.dart';
// import 'package:shopack_user/core/utilities/mediaquery.dart';
// import '../../../../core/utilities/strings.dart';
// import '../../../login/presentation/widgets/alert_snackbar.dart';
// import '../../../shop/domain/entities/products_entity.dart';
// import '../bloc/cart_bloc.dart';

// class CartItem extends StatefulWidget {
//   final ProductEntity product;
//   const CartItem({super.key, required this.product});

//   @override
//   State<CartItem> createState() => _CartItemState();
// }

// class _CartItemState extends State<CartItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//       child: Container(
//         clipBehavior: Clip.antiAlias,
//         width: kWidth(context),
//         height: kHeight(context) / 6,
//         decoration: BoxDecoration(
//             color: ColorManager.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: kElevationToShadow[3]),
//         child: Row(
//           children: [
//             SizedBox(
//               width: kWidth(context) * 0.25,
//               child: Image.network(
//                 widget.product.images[0].url,
//               ),
//             ),
//             Expanded(
//                 child: Column(
//               children: [
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   child: Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: kWidth(context) * 0.5,
//                             child: Text(
//                               widget.product.name,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                             ),
//                           ),
//                           Text(
//                             widget.product.category,
//                             style: Theme.of(context).textTheme.bodySmall,
//                           )
//                         ],
//                       ),

//                        IconButton(
//                           onPressed: () async {
//                              context
//                                       .read<CartBloc>()
//                                       .add(ItemRemoved(state.items[index]));
//                           },
//                           icon: const Icon(
//                             Icons.clear,
//                             color: ColorManager.grey,
//                           ),
//                         ),

//                     ],
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     SizedBox(
//                       width: kWidth(context) * .4,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Container(
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   boxShadow: kElevationToShadow[4]),
//                               child: CircleAvatar(
//                                 backgroundColor: ColorManager.white,
//                                 radius: 20.0,
//                                 child: Material(
//                                   color: Colors.transparent,
//                                   child: InkWell(
//                                     onTap: () {
//                                       setState(() {
//                                         BlocProvider.of<CartBloc>(context).add(
//                                           ChangeQuantity(
//                                               isAdd: false,
//                                               product: widget.product),
//                                         );

//                                       });
//                                     },
//                                     child: const Icon(
//                                       Icons.remove,
//                                       size: 20.0,
//                                       color: ColorManager.grey,
//                                     ),
//                                   ),
//                                 ),
//                               )),
//                           Text(
//                             '${widget.product.quantity}',
//                             style: Theme.of(context).textTheme.headline6,
//                           ),
//                           Container(
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   boxShadow: kElevationToShadow[4]),
//                               child: CircleAvatar(
//                                 backgroundColor: ColorManager.white,
//                                 radius: 20.0,
//                                 child: Material(
//                                   color: Colors.transparent,
//                                   child: InkWell(
//                                     onTap: () {
//                                       setState(() {
//                                         BlocProvider.of<CartBloc>(context).add(
//                                           ChangeQuantity(
//                                               isAdd: true,
//                                               product: widget.product),
//                                         );

//                                       });
//                                     },
//                                     child: const Icon(
//                                       Icons.add,
//                                       size: 20.0,
//                                       color: ColorManager.grey,
//                                     ),
//                                   ),
//                                 ),
//                               )),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ))
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopack_user/features/shop/domain/entities/products_entity.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../core/utilities/strings.dart';
import '../../../login/presentation/widgets/alert_snackbar.dart';
import '../bloc/cart_bloc.dart';

class CatItem extends StatelessWidget {
  final ProductEntity item;
  const CatItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: kWidth(context),
        height: kHeight(context) / 6,
        decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: kElevationToShadow[3]),
        child: Row(
          children: [
            SizedBox(
              width: kWidth(context) * 0.25,
              child: Image.network(
                item.images[0].url,
              ),
            ),
            Expanded(
                child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: kWidth(context) * 0.5,
                            child: Text(
                              
                              item.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Text(
                            item.category,
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                      BlocListener<CartBloc, CartState>(
                        listener: (context, state) {
                          if (state is CartLoaded && state.isRemoved) {
                            showSnackbar(AppStrings.removeFromCart, context,
                                Colors.green);
                          }
                        },
                        child: IconButton(
                          onPressed: () async {
                            item.quantity--;

                            context
                                .read<CartBloc>()
                                .add(ItemRemoved(item));
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: ColorManager.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: kWidth(context) * .4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: kElevationToShadow[4]),
                              child: CircleAvatar(
                                backgroundColor: ColorManager.white,
                                radius: 20.0,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                            
                                        if (item.quantity > 1) {
                                          item.quantity--;
                                          context.read<CartBloc>().add(
                                              ItemRemoved(item));
                                        }
                                   
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      size: 20.0,
                                      color: ColorManager.grey,
                                    ),
                                  ),
                                ),
                              )),
                          Text(
                            '${item.quantity}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: kElevationToShadow[4]),
                              child: CircleAvatar(
                                backgroundColor: ColorManager.white,
                                radius: 20.0,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                   
                                        item.quantity++;
                                        context
                                            .read<CartBloc>()
                                            .add(ItemAdded(item));
                                  
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      size: 20.0,
                                      color: ColorManager.grey,
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Text(
                      '${item.price} \$',
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

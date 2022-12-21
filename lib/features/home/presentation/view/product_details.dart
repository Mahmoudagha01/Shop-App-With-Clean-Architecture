import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopack_user/features/shop/presentation/widgets/review_card.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../core/utilities/routes.dart';
import '../../../../core/utilities/strings.dart';
import '../../../favorite/presentation/bloc/favourite_bloc.dart';
import '../../../login/presentation/widgets/alert_snackbar.dart';
import '../../../shop/domain/entities/products_entity.dart';
import '../../widgets/carousel.dart';
import '../../widgets/product_item.dart';

class ProductDetails extends StatelessWidget {
  final ProductEntity product;
  final List<ProductEntity> products;
  final int index;
  const ProductDetails(
      {super.key,
      required this.product,
      required this.products,
      required this.index});

  @override
  Widget build(BuildContext context) {
    List<ProductEntity> newProductsList = products.reversed.toList();
    newProductsList.shuffle();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          product.name,
          style: const TextStyle(color: ColorManager.dark),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: ColorManager.grey,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: BlocConsumer<FavouriteBloc, FavouriteState>(
                listener: (context, state) {
                    if(state is AddToFavouriteState){
                       showSnackbar(AppStrings.addfav,context, Colors.green);
                }else if(state is RemoveFromFavouriteState){
                    showSnackbar(AppStrings.deletefav, context, Colors.green);
                }
                },
                builder: (context, state) {
                  return CircleAvatar(
                    backgroundColor: ColorManager.white,
                    radius: 20.0,
                    child: InkWell(
                      onTap: () {
                         BlocProvider.of<FavouriteBloc>(context).add(
                                AddToFavorite(
                                    product: product,
                                    isFavourite: product.isFavourite,
                                    ));
                      },
                      child: product.isFavourite
                              ? const Icon(
                                  Icons.favorite,
                                  size: 20.0,
                                  color: ColorManager.orangeLight,
                                )
                              : const Icon(
                                  Icons.favorite_outline,
                                  size: 20.0,
                                  color: ColorManager.grey,
                                ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: kWidth(context) / 1.12,
        height: kHeight(context) / 14,
        child: FloatingActionButton.extended(
            backgroundColor: ColorManager.orangeLight,
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {},
            label: Text(
              AppStrings.addToCart.toUpperCase(),
            )),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(tag: '$index', child: Carousel(images: product.images)),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: kWidth(context) - 90,
                          child: Text(
                            product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          product.category,
                          style: const TextStyle(
                            color: ColorManager.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              itemSize: 25.0,
                              rating: product.ratings.toDouble(),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              direction: Axis.horizontal,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              '(${product.numOfReviews})',
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        color: Colors.grey,
                                      ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "${product.price}\$",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: ColorManager.orangeLight),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Text(
                  AppStrings.description,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: ColorManager.orangeLight),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Text(
                  product.description,
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppStrings.rateandreview,
                        style: Theme.of(context).textTheme.headline6),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.productreviews,
                              arguments: product);
                        },
                        child: const Text(AppStrings.seeMore))
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                child: Row(
                  children: [
                    RatingBarIndicator(
                      itemSize: 25.0,
                      rating: product.ratings.toDouble(),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      direction: Axis.horizontal,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '${product.ratings}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '(${product.numOfReviews} reviews)',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: ReviewCard(product: product, index: index),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Text(AppStrings.mayLike,
                    style: Theme.of(context).textTheme.headline6),
              ),
              SizedBox(
                height: 330,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                product: products[index],
                                products: products,
                                index: index,
                              ),
                            ));
                      },
                      child: SizedBox(
                          width: kWidth(context) / 2,
                          height: 330,
                          child: ProductItem(product: newProductsList[index])),
                    );
                  },
                ),
              ),
              SizedBox(
                height: kHeight(context) / 11,
              )
            ],
          ),
        ),
      ),
    );
  }
}

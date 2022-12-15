import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/colors/colors.dart';
import 'package:shop_app/features/cart/presentation/views/cart.dart';
import 'package:shop_app/features/favorite/presentation/views/favorite.dart';
import 'package:shop_app/features/home/presentation/bloc/BottomNavigationBar_bloc.dart';
import 'package:shop_app/features/home/presentation/view/home.dart';
import 'package:shop_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:shop_app/features/profile/presentation/views/profile.dart';
import 'package:shop_app/features/shop/presentation/bloc/products_bloc.dart';
import 'package:shop_app/features/shop/presentation/views/shop.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  @override
  void initState() {
    BlocProvider.of<ProductsBloc>(context).add(GetAllProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBarBloc, BottomNavigationBarState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: ColorManager.white,
            selectedItemColor: ColorManager.orangeLight,
            unselectedItemColor: ColorManager.grey,
            currentIndex: state.index,
            onTap: (index) {
              switch (index) {
                case 0:
                  BlocProvider.of<BottomNavigationBarBloc>(context)
                      .add(LoadHome());
                  BlocProvider.of<ProductsBloc>(context).add(GetAllProducts());
                  break;
                case 1:
                  BlocProvider.of<BottomNavigationBarBloc>(context)
                      .add(LoadShop());
                  BlocProvider.of<ProductsBloc>(context).add(
                      const GetSpecificProduct(
                          "Clothes", '0', '100000', '0', ''));
                  break;
                case 2:
                  BlocProvider.of<BottomNavigationBarBloc>(context)
                      .add(LoadBag());
                  break;
                case 3:
                  BlocProvider.of<BottomNavigationBarBloc>(context)
                      .add(LoadFavorite());
                  break;
                case 4:
                  BlocProvider.of<BottomNavigationBarBloc>(context)
                      .add(LoadProfile());
                  BlocProvider.of<ProfileBloc>(context).add(GetProfile());
                  break;
                default:
                  BlocProvider.of<BottomNavigationBarBloc>(context)
                      .add(LoadHome());
              }
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                  activeIcon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined),
                  label: 'Shop',
                  activeIcon: Icon(Icons.shopping_cart)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined),
                  label: 'Bag',
                  activeIcon: Icon(Icons.shopping_bag)),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined),
                label: 'Favorite',
                activeIcon: Icon(Icons.favorite),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Profile',
                  activeIcon: Icon(Icons.person)),
            ],
          ),
          body: BlocBuilder<BottomNavigationBarBloc, BottomNavigationBarState>(
            builder: (context, state) {
              if (state is HomeState) {
                return const HomeView();
              } else if (state is ShopState) {
                return const ShopView();
              } else if (state is BagState) {
                return const CartView();
              } else if (state is FavoriteState) {
                return const FavoriteView();
              } else if (state is ProfilePageState) {
                return const ProfileView();
              } else {
                return const SizedBox();
              }
            },
          ),
        );
      },
    );
  }
}

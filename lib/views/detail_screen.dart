import 'package:e_commerce/models/products_model.dart';
import 'package:e_commerce/viewmodels/cart_viewmodel.dart';
import 'package:e_commerce/viewmodels/home_viewmodel.dart';
import 'package:e_commerce/views/widgets/custom_appbar.dart';
import 'package:e_commerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: product.name!, back: true, bottom: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.network(
                product.imageUrl!,
                height: 400.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    product.name!,
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    product.description!,
                    style: TextStyle(fontSize: 14.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    product.discount != null && product.discount! > 0
                        ? "\$${(product.price! - product.discount!).toStringAsFixed(2)}"
                        : "Price: \$${product.price!.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 20.sp),
                    textAlign: TextAlign.center,
                  ),
                  if (product.discount != null && product.discount! > 0) ...[
                    SizedBox(height: 10.h),
                    Text(
                      'was',
                      style: TextStyle(fontSize: 14.sp),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "\$${product.price!.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  SizedBox(height: 40.h),
                  SafeArea(
                    child: MainButton(
                      name: 'Add to Cart',
                      onPressed: () => _showAddToCartModal(context, product),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showAddToCartModal(BuildContext context, Product product) {
    int quantity = 1;
    final price = product.discount == null
        ? product.price!
        : product.price! - product.discount!;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 14.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 48.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    product.name!,
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Total Price',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "\$${(price * quantity).toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (quantity > 1) {
                                setState(() => quantity--);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(0.r),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  border: Border.all(width: 2)),
                              child: Icon(
                                Icons.remove,
                                size: 16.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40.w,
                            child: Text(
                              quantity.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() => quantity++);
                            },
                            child: Container(
                              padding: EdgeInsets.all(0.r),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  border: Border.all(width: 2),
                                  color: Theme.of(context).primaryColor),
                              child: Icon(
                                Icons.add,
                                size: 16.sp,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  SafeArea(
                    child: MainButton(
                      name: 'Add to Cart',
                      onPressed: () {
                        context
                            .read<CartViewModel>()
                            .addToCart(product, quantity);

                        final homeVM =
                            Provider.of<HomeViewModel>(context, listen: false);
                        homeVM.updateSelectedTab(2);
                        context.go('/cart');
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

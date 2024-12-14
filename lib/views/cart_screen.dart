import 'package:e_commerce/viewmodels/cart_viewmodel.dart';
import 'package:e_commerce/views/widgets/custom_appbar.dart';
import 'package:e_commerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.watch<CartViewModel>();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'CART',
        back: false,
        bottom: false,
      ),
      body: cartViewModel.cartItems.isEmpty
          ? Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 120.sp,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Your cart is empty!',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Items will show up here once you started adding items to your cart from product detail page.',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartViewModel.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartViewModel.cartItems[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 20.h),
                        child: Row(
                          children: [
                            Checkbox(
                              value: cartViewModel.selectedItems
                                  .contains(cartItem),
                              onChanged: (value) {
                                cartViewModel.toggleItemSelection(cartItem);
                              },
                            ),
                            SizedBox(width: 10.w),
                            Container(
                              height: 72.r,
                              width: 72.r,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Image.network(
                                cartItem.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(cartItem.productName, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600,),),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$${cartItem.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300,),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              cartViewModel
                                                  .decrementItemQuantity(
                                                      cartItem);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(0.r),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.r),
                                                  border: Border.all(width: 2)),
                                              child: Icon(
                                                Icons.remove,
                                                size: 16.sp,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 32.w,
                                            child: Text(
                                              cartItem.quantity.toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              cartViewModel
                                                  .incrementItemQuantity(
                                                      cartItem);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(0.r),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.r),
                                                  border: Border.all(width: 2),
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              child: Icon(
                                                Icons.add,
                                                size: 16.sp,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Total: \$${cartViewModel.calculateTotalPrice().toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 10.h),
                      TextButton(
                        onPressed: cartViewModel.selectedItems.isEmpty
                            ? null
                            : () {
                                cartViewModel.removeSelectedItems();
                              },
                        child: Text(
                          'Remove Selected',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: cartViewModel.selectedItems.isEmpty
                                ? Colors.grey
                                : Theme.of(context).colorScheme.error,
                            decoration: TextDecoration.underline,
                            decorationColor: cartViewModel.selectedItems.isEmpty
                                ? Colors.grey
                                : Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                      MainButton(
                        name: 'Place Order',
                        onPressed: cartViewModel.selectedItems.isEmpty
                            ? null
                            : () {
                                context.push('/place-order');
                              },
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

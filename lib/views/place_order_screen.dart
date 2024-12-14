import 'package:e_commerce/viewmodels/cart_viewmodel.dart';
import 'package:e_commerce/viewmodels/home_viewmodel.dart';
import 'package:e_commerce/views/widgets/custom_appbar.dart';
import 'package:e_commerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  String selectedPaymentMethod = "credit_card";
  String deliveryAddress = "Addis Ababa, Ethiopia";

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    final totalPrice = cartViewModel.calculateTotalPrice();

    return Scaffold(
      appBar:
          const CustomAppBar(title: 'PLACE ORDER', back: true, bottom: false),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20.h),
            ListTile(
              tileColor: selectedPaymentMethod == "credit_card"
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
              leading: Icon(
                Icons.credit_card,
                size: 32.sp,
                color: selectedPaymentMethod == "credit_card"
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSecondary,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)),
              title: Text(
                "Credit Card",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: selectedPaymentMethod == "credit_card"
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              subtitle: Text(
                '1234 **** **** **12',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  color: selectedPaymentMethod == "credit_card"
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              trailing: Radio<String>(
                value: "credit_card",
                activeColor: selectedPaymentMethod == "credit_card"
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSecondary,
                groupValue: selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
            SizedBox(height: 20.h),
            ListTile(
              tileColor: selectedPaymentMethod == "debit_card"
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
              leading: Icon(
                Icons.paypal,
                size: 32.sp,
                color: selectedPaymentMethod == "debit_card"
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSecondary,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)),
              title: Text(
                "Debit Card",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: selectedPaymentMethod == "debit_card"
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              subtitle: Text(
                '9876 **** **** **98',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  color: selectedPaymentMethod == "debit_card"
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              trailing: Radio<String>(
                value: "debit_card",
                activeColor: selectedPaymentMethod == "debit_card"
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSecondary,
                groupValue: selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
            SizedBox(height: 40.h),
            Text(
              'Delivery adress',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.border_all_outlined,
                    size: 16.sp,
                  ),
                ),
                SizedBox(width: 20.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deliveryAddress,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '123 Street',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                SizedBox(width: 20.w),
                const Spacer(),
                Icon(Icons.edit_outlined)
              ],
            ),
            SizedBox(height: 40.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estimated delivery time:',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
                ),
                Text(
                  '1-2 days',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            const Spacer(),
            Text(
              'Total Price',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300),
            ),
            Text(
              "\$${totalPrice.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20.h),
            SafeArea(
              child: MainButton(
                name: cartViewModel.isLoading ? '...' : 'Place Order',
                onPressed: cartViewModel.isLoading ? null : () async {
                  final goRouter = GoRouter.of(context);
                  final homeVM =
                      Provider.of<HomeViewModel>(context, listen: false);

                  await cartViewModel.placeOrder(
                    cartViewModel.selectedItems,
                    selectedPaymentMethod,
                    deliveryAddress,
                  );

                  homeVM.updateSelectedTab(0);
                  goRouter.go('/home');
                },
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

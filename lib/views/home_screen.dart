import 'package:e_commerce/viewmodels/home_viewmodel.dart';
import 'package:e_commerce/views/widgets/custom_appbar.dart';
import 'package:e_commerce/views/widgets/home_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'ECOMMERCE', back: false, bottom: true,),
      body: Consumer<HomeViewModel>(builder: (context, viewModel, _) {
        return viewModel.isLoading
            ? Center(
                child: SizedBox(
                  height: 60.h,
                  width: 60.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.w,
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: () {
                                context.read<HomeViewModel>().toggleFilter();
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: viewModel.showDiscounted
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.primary,
                                foregroundColor: viewModel.showDiscounted
                                    ? Theme.of(context).colorScheme.onSecondary
                                    : Theme.of(context).colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.h, horizontal: 16.w),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize: Size.zero,
                              ),
                              child: Text(
                                'All',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: FilledButton(
                              onPressed: () {
                                context.read<HomeViewModel>().toggleFilter();
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: viewModel.showDiscounted
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.secondary,
                                foregroundColor: viewModel.showDiscounted
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSecondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.h, horizontal: 16.w),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize: Size.zero,
                              ),
                              child: Text(
                                'Discounted',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: MasonryGridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        itemCount: viewModel.products.length,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        itemBuilder: (context, index) {
                          final product = viewModel.products[index];
                          return HomeProduct(
                            product: product,
                            onPressed: () => context
                                .push('/detail/${product.id}', extra: product),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}

import 'package:e_commerce/viewmodels/home_viewmodel.dart';
import 'package:e_commerce/views/widgets/home_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'ECOMMERCE',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton.filled(
            onPressed: () {},
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.all(14.r),
              minimumSize: Size.zero,
            ),
            icon: Icon(
              Icons.notifications_none,
              size: 20.r,
            ),
          ),
          SizedBox(width: 10.w),
          Container(
            clipBehavior: Clip.hardEdge,
            height: 48.h,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Image.network(
                'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHBvcnRyYWl0fGVufDB8fDB8fHww'),
          ),
          SizedBox(width: 10.w),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            height: 48.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 24.sp,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Search Product',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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
                          return HomeProduct(product: product);
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

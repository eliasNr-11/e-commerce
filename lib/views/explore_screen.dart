import 'package:e_commerce/viewmodels/explore_viewmodel.dart';
import 'package:e_commerce/views/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exploreViewModel = Provider.of<ExploreViewModel>(context);

    if (exploreViewModel.isLoading) {
      return Center(
        child: SizedBox(
          height: 60.h,
          width: 60.h,
          child: CircularProgressIndicator(
            strokeWidth: 3.w,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(title: 'EXPLORE', back: false, bottom: true,),
      body: ListView.separated(
        padding: EdgeInsets.all(20.r),
        itemCount: exploreViewModel.categories.length,
        itemBuilder: (context, index) {
          final category = exploreViewModel.categories[index];
          return GestureDetector(
            onTap: () {
              context.push(
                '/categories/${category.id}',
                extra: {'categoryName': category.name},
              );
            },
            child: Stack(
              children: [
                Container(
                  height: 160.h,
                  width: double.infinity,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Image.network(category.imageUrl!, fit: BoxFit.cover),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      gradient: const LinearGradient(
                        colors: [Colors.transparent, Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(24.r),
                          child: Text(
                            category.name!.toUpperCase(),
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 10.h),
      ),
    );
  }
}

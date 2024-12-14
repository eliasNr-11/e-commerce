import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title, required this.back, required this.bottom,
  });

  final String title;
  final bool back;
  final bool bottom;

  @override
  Size get preferredSize => Size.fromHeight(bottom ? 126.h : 64.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: back ? IconButton(
        onPressed: () => context.pop(),
        style: IconButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.all(14.r),
          minimumSize: Size.zero,
        ),
        icon: Icon(Icons.keyboard_backspace, size: 24.sp),
      ) : null,
      title: Text(
        title,
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
      bottom: bottom ? PreferredSize(
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
      ) : null,
    );
  }
}

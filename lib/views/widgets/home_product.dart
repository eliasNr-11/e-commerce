import 'package:e_commerce/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeProduct extends StatelessWidget {
  const HomeProduct({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.push('/detail/${product.id}', extra: product),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Image.network(
              product.imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            product.name!,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
            overflow: TextOverflow.ellipsis,
          ),
          if (product.discount != null && product.discount! > 0) ...[
            Row(
              children: [
                Text(
                  '\$${(product.price! - product.discount!).toStringAsFixed(0)}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(width: 10.w),
                Text(
                  '\$${product.price!.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey[400],
                    decorationColor: Colors.red
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ] else ...[
            Text(
              '\$${product.price!.toStringAsFixed(0)}',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
              overflow: TextOverflow.ellipsis,
            ),
          ]
        ],
      ),
    );
  }
}

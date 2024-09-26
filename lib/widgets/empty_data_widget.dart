import 'package:flutter/material.dart';
import 'package:foodfixer/core/core.dart';
import 'package:foodfixer/styles/app_colors.dart';
import 'package:foodfixer/styles/icons.dart';
import 'package:foodfixer/widgets/buttons/app_btn.dart';
import 'package:foodfixer/widgets/spaced_column.dart';
import 'package:svg_flutter/svg.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    super.key,
    required this.emptyText,
    this.title = 'Refresh',
    this.onRefresh,
  });

  final String emptyText;
  final String title;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SpacedColumn(
          mainAxisSize: MainAxisSize.min,
          margin: const EdgeInsets.all(12.0),
          defaultHeight: 18.0,
          children: [
            SvgPicture.asset(AppIcons.emptySearch.path, height: 120, width: 120),
            Text(emptyText, style: context.textTheme.titleMedium),
            if(onRefresh.isNotNull)...[
              AppButton(
                label: title,
                onPressed: onRefresh,
                textStyle: context.textTheme.titleLarge,
                bgColor: AppColors.bleachedSilk,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:dokan/features/home/presentation/home/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/sort_bottom_sheet.dart';

void showSortBottomSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.grey,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return BlocProvider.value(
          value: context.read<HomeCubit>(),
        child:  const SortBottomSheet(),
      );
    },
  );
}


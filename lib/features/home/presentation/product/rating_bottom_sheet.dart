import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:dokan/features/home/presentation/product/bloc/rate_cubit.dart';
import 'package:dokan/features/home/presentation/product/rating_screen.dart';
import 'package:dokan/shared/widgets/auth_button.dart';
import 'package:dokan/shared/widgets/auth_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/app_localization.dart';

class RatingBottomSheet extends StatefulWidget {
  const RatingBottomSheet({super.key});

  @override
  State<RatingBottomSheet> createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  final TextEditingController _commentController = TextEditingController();
  int _selectedRating = 0;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userName = UserUtils.resolveUserName(FirebaseAuth.instance.currentUser);
    final locale = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      height: MediaQuery.sizeOf(context).height * 0.75,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              locale.translate('what_is_your_rate'),
              style: AppTextStyles.headline3,
            ),
            const SizedBox(height: 30),
        
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                    (index) => IconButton(
                  onPressed: () => setState(() => _selectedRating = index + 1),
                  icon: Icon(
                    index < _selectedRating ? Icons.star : Icons.star_border,
                    size: 40,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
        
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: Text(
                locale.translate('opinion'),
                style: AppTextStyles.headline3,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
        
            AuthTextField(
              hint: locale.translate('write_comment'),
              controller: _commentController,
            ),
            const SizedBox(height: 30),
        
            AuthButton(
              text: locale.translate('send_review'),
              onPressed: () {
                context.read<RatingCubit>().addReview(
                  rate: _selectedRating,
                  name: userName,
                  comment: _commentController.text,
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
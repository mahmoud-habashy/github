import 'package:flutter/material.dart';
import 'package:github/shared/app_colors.dart';
import 'package:github/shared/app_constants.dart';
import 'package:github/shared/app_strings.dart';
import 'package:github/util/validators.dart';

/// A customized Widget for search entry.

class SearchInputField extends StatelessWidget {
  /// [searchController] is required argument for the input field controller.
  /// [searchFocusNode] is required argument for the input field focus node.
  /// [onSubmit] is required argument to submit the form.
  ///
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final VoidCallback onSubmit;
  const SearchInputField(
      {super.key,
      required this.searchController,
      required this.searchFocusNode,
      required this.onSubmit});

  void _clearSearchInput() {
    searchController.clear();
    searchFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      controller: searchController,
      focusNode: searchFocusNode,
      validator: isValidUserName,
      onFieldSubmitted: (_) {
        onSubmit();
      },
      textInputAction: TextInputAction.search,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
            vertical: AppConstants.paddingElement * 3),
        prefixIcon: const Icon(
          Icons.search,
          size: AppConstants.defaultIconSize,
          color: AppColors.grey,
        ),
        suffixIcon: searchController.text.isNotEmpty
            ? IconButton(
                onPressed: _clearSearchInput,
                icon: const Icon(
                  Icons.close,
                  size: AppConstants.defaultIconSize,
                  color: AppColors.black,
                ))
            : null,
        fillColor: AppColors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: AppColors.white, width: AppConstants.borderWidth),
          borderRadius: BorderRadius.circular(AppConstants.radiusElement * 5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusElement * 5),
        ),
        hintText: AppStrings.userNameSearchHintText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: AppColors.grey),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github/data/models/user_model.dart';
import 'package:github/data/providers/recent_search_provider.dart';
import 'package:github/presentation/widgets/recent_search_card.dart';
import 'package:github/shared/app_colors.dart';
import 'package:github/shared/app_constants.dart';
import 'package:github/shared/app_strings.dart';

/// This is the [HomeScreen]'s second scenario.
/// if the user has any recent searches stored in the device, it has clear all button to remove all the recent searches.
/// the clear all button will show up if the user has more than 2 recent searches.
///
class RecentSearchState extends ConsumerWidget {
  const RecentSearchState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<UserModel> recentSearchResults = ref.watch(storedUserDataProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppConstants.defaultPadding,
            right: AppConstants.defaultPadding,
            top: AppConstants.paddingElement * 2,
            bottom: AppConstants.defaultPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.recentSearchStateTitle,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColors.white),
              ),
              if (recentSearchResults.length > 2)
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    ref
                        .read(storedUserDataProvider.notifier)
                        .resetRecentSearch();
                  },
                  child: Text(AppStrings.recentSearchStateResetBtn,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: AppColors.accent)),
                )
            ],
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: recentSearchResults.length,
                itemBuilder: (context, index) => RecentSearchCard(
                      key: ValueKey(
                          "recent_search_card${recentSearchResults[index].id}"),
                      userModel: recentSearchResults[index],
                    )))
      ],
    );
  }
}

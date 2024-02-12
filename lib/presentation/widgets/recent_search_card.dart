import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github/data/models/user_model.dart';
import 'package:github/data/providers/recent_search_provider.dart';
import 'package:github/data/providers/user_provider.dart';
import 'package:github/shared/app_colors.dart';
import 'package:github/shared/app_constants.dart';
import 'package:github/util/app_router.dart';

/// A customized card widget to render the recent searches.

class RecentSearchCard extends ConsumerWidget {
  /// [userModel] is required argument to get all the needed data.
  ///
  final UserModel userModel;
  const RecentSearchCard({super.key, required this.userModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(bottom: BorderSide(color: AppColors.borderColor))),
      padding: const EdgeInsets.only(
          left: AppConstants.defaultPadding,
          right: AppConstants.paddingElement,
          bottom: AppConstants.paddingElement * 2,
          top: AppConstants.paddingElement * 2),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppConstants.radiusElement * 4,
            backgroundImage: NetworkImage(userModel.avatarUrl),
          ),
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                ref
                    .read(selectedUserProvider.notifier)
                    .setSelectedUser(userModel);
                Navigator.of(context).pushNamed(AppRoutes.dashboardScreen);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingElement * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (userModel.name != null)
                      Text(
                        userModel.name!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    Text(
                      userModel.login,
                      style: userModel.name != null
                          ? Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.grey)
                          : Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              ref
                  .read(storedUserDataProvider.notifier)
                  .removeRecentSearch(userModel);
            },
            icon: const Icon(
              Icons.close,
              size: AppConstants.defaultIconSize,
            ),
          )
        ],
      ),
    );
  }
}

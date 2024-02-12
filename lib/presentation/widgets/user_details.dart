import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github/data/models/user_model.dart';
import 'package:github/data/providers/user_provider.dart';
import 'package:github/shared/app_colors.dart';
import 'package:github/shared/app_constants.dart';
import 'package:github/shared/app_strings.dart';
import 'package:github/util/app_router.dart';
import 'package:github/util/global.dart';

/// A customized widget for rendering the user details in [DashboardScreen].

class UserDetails extends ConsumerWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? userModel = ref.watch(selectedUserProvider);

    return userModel == null
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.defaultPadding),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: AppConstants.radiusElement * 9,
                      backgroundImage: NetworkImage(userModel.avatarUrl),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.defaultPadding),
                          child: Text(
                            userModel.name ?? userModel.login,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                        if (userModel.email != null &&
                            userModel.email!.isNotEmpty)
                          _UserDetailRow(
                              icon: Icons.email, text: userModel.email!),
                        if (userModel.company != null &&
                            userModel.company!.isNotEmpty)
                          _UserDetailRow(
                              icon: Icons.business_center,
                              text: userModel.company!),
                        if (userModel.location != null &&
                            userModel.location!.isNotEmpty)
                          _UserDetailRow(
                              icon: Icons.location_on_sharp,
                              text: userModel.location!),
                        if (userModel.blog != null &&
                            userModel.blog!.isNotEmpty)
                          _UserDetailRow(
                              icon: Icons.link, text: userModel.blog!),
                      ],
                    ))
                  ],
                ),
              ),
              if (userModel.bio != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.defaultPadding),
                  margin: const EdgeInsets.only(
                      top: AppConstants.marginElement * 2),
                  child: Text(
                    userModel.bio!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.white),
                  ),
                ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  openLink(userModel.htmlUrl);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.defaultPadding),
                  margin: const EdgeInsets.symmetric(
                      vertical: AppConstants.marginElement * 2),
                  child: Text(
                    userModel.login,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.link),
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.paddingElement,
                    horizontal: AppConstants.defaultPadding),
                child: Row(
                  children: [
                    _UserDetailColumn(
                        text: AppStrings.dashboardFollowers,
                        value: userModel.followers),
                    _UserDetailColumn(
                        text: AppStrings.dashboardFollowing,
                        value: userModel.following),
                    _UserDetailColumn(
                        text: AppStrings.dashboardPublicRepos,
                        value: userModel.publicRepos)
                  ],
                ),
              ),
              const Divider(),
            ],
          );
  }
}

class _UserDetailRow extends StatelessWidget {
  final String text;
  final IconData icon;

  const _UserDetailRow({required this.text, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppConstants.defaultPadding, top: AppConstants.paddingElement),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.white,
            size: AppConstants.iconSize * 3,
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: AppConstants.paddingElement * 2),
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserDetailColumn extends StatelessWidget {
  final String text;
  final int value;
  const _UserDetailColumn({required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Text(
          AppGlobal.intToStringAsFixed(value),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: AppColors.white),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: AppConstants.paddingElement),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: AppColors.white),
          ),
        ),
      ],
    ));
  }
}

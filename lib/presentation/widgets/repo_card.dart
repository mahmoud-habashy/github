import 'package:flutter/material.dart';
import 'package:github/data/models/repo_model.dart';
import 'package:github/shared/app_colors.dart';
import 'package:github/shared/app_constants.dart';
import 'package:github/shared/app_strings.dart';
import 'package:github/util/app_router.dart';
import 'package:github/util/global.dart';

/// Customized card widget for rendering the repository details.

class RepoCard extends StatelessWidget {
  /// [repoModel] is required argument to get the needed data.
  ///
  final RepoModel repoModel;
  const RepoCard({super.key, required this.repoModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusElement * 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              openLink(repoModel.htmlUrl);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: AppConstants.paddingElement,
                  left: AppConstants.defaultPadding,
                  right: AppConstants.defaultPadding),
              child: Row(
                children: [
                  const Icon(
                    Icons.link,
                    color: AppColors.charcoal,
                    size: AppConstants.iconSize * 4,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: AppConstants.paddingElement),
                      child: Text(
                        repoModel.name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppColors.link),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (repoModel.description != null)
            Padding(
              padding: const EdgeInsets.only(
                  bottom: AppConstants.paddingElement,
                  left: AppConstants.defaultPadding,
                  right: AppConstants.defaultPadding),
              child: Text(
                repoModel.description!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.charcoal),
              ),
            ),
          if (repoModel.license != null)
            _RepoLicenseDetails(license: repoModel.license!),
          _RepoCardFooter(repoModel: repoModel),
        ],
      ),
    );
  }
}

/// Customized widget  for rendering the license details.
class _RepoLicenseDetails extends StatelessWidget {
  /// [license] is required argument to get the needed data.
  ///
  final RepoLicense license;
  const _RepoLicenseDetails({required this.license});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(
                top: AppConstants.paddingElement,
                left: AppConstants.defaultPadding,
                right: AppConstants.defaultPadding),
            child: Row(
              children: [
                const Icon(
                  Icons.balance_sharp,
                  size: AppConstants.iconSize * 3,
                  color: AppColors.charcoal,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: AppConstants.paddingElement),
                    child: Text(
                      license.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppConstants.paddingElement,
                horizontal: AppConstants.defaultPadding),
            child: Text(
              license.key,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.charcoal),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

/// Customized footer for repo card
/// to render the details like watchers count,forks count, language and updated at.
class _RepoCardFooter extends StatelessWidget {
  /// [repoModel] is required argument to get the needed data.
  ///
  final RepoModel repoModel;
  const _RepoCardFooter({required this.repoModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppConstants.paddingElement,
          left: AppConstants.defaultPadding,
          right: AppConstants.defaultPadding),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppConstants.paddingElement * 2,
        runSpacing: AppConstants.paddingElement,
        children: [
          if (repoModel.language != null)
            _buildRowDetail(context, Icons.language, repoModel.language!),
          _buildRowDetail(context, Icons.star,
              AppGlobal.intToStringAsFixed(repoModel.watchersCount)),
          _buildRowDetail(context, Icons.fork_right,
              AppGlobal.intToStringAsFixed(repoModel.forksCount)),
          if (repoModel.updatedAt != null)
            Text(
              "${AppStrings.repoUpdateAtText} ${AppGlobal.formatDate(repoModel.updatedAt!)}",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: AppColors.charcoal),
            ),
        ],
      ),
    );
  }

  Widget _buildRowDetail(BuildContext context, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: AppColors.charcoal,
          size: AppConstants.iconSize * 4,
        ),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: AppColors.charcoal),
        ),
      ],
    );
  }
}

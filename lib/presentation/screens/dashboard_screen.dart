import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github/config/app_config.dart';
import 'package:github/data/models/user_model.dart';
import 'package:github/data/providers/repo_provider.dart';
import 'package:github/data/providers/user_provider.dart';
import 'package:github/presentation/widgets/error_state.dart';
import 'package:github/presentation/widgets/repo_card.dart';
import 'package:github/presentation/widgets/user_details.dart';
import 'package:github/shared/app_colors.dart';
import 'package:github/shared/app_constants.dart';
import 'package:github/shared/app_strings.dart';

/// The dashboard screen for rendering the user details and the public repos for the selected user.
/// it has a pagination logic when user reaches the end of the repo list the app will send a request to get more repos.
///

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _hasError = false;
  int _currentPage = 1;
  UserModel? _userModel;

  int get _totalPageCount => _userModel == null
      ? 1
      : (_userModel!.publicRepos / AppConfig.reposCountPerPage).ceil();

  @override
  void initState() {
    super.initState();
    _userModel = ref.read(selectedUserProvider);
    _scrollController.addListener(_loadMoreRepos);
    Future.delayed(
        const Duration(milliseconds: AppConstants.defaultAnimationDuration * 2),
        () => _fetchRepos());
  }

  @override
  void dispose() {
    // Clean up the scroll controller.
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchRepos() {
    if (_userModel != null) {
      ref
          .read(reposProvider.notifier)
          .getReposByUserName(_userModel!.login, _currentPage);
    }
  }

  void _loadMoreRepos() {
    if (!_hasError &&
        _currentPage < _totalPageCount &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      _currentPage++;
      _fetchRepos();
    }
  }

  @override
  Widget build(BuildContext context) {
    RepoState repoState = ref.watch(reposProvider);
    _hasError = repoState.errorMessage != null;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.backgroundDark, AppColors.backgroundLight])),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              AppStrings.dashboardTitle,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: AppColors.white),
            ),
            leading: const BackButton(color: AppColors.white),
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              SafeArea(
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: AppConstants.defaultPadding),
                        child: UserDetails(),
                      ),
                    ),
                    _DashboardScreenContent(
                      repoState: repoState,
                      onRefresh: _fetchRepos,
                    ),
                  ],
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(
                    milliseconds: AppConstants.defaultAnimationDuration * 2),
                curve: Curves.ease,
                bottom: repoState.isLoading
                    ? AppConstants.containerElement * 8
                    : -AppConstants.containerElement * 8,
                child: Container(
                    decoration: const BoxDecoration(
                        color: AppColors.white, shape: BoxShape.circle),
                    width: AppConstants.containerElement * 4,
                    height: AppConstants.containerElement * 4,
                    padding:
                        const EdgeInsets.all(AppConstants.paddingElement * 2),
                    child: const CircularProgressIndicator()),
              )
            ],
          )),
    );
  }
}

class _DashboardScreenContent extends StatelessWidget {
  final RepoState repoState;
  final VoidCallback onRefresh;
  const _DashboardScreenContent(
      {required this.repoState, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    if (repoState.errorMessage != null) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppConstants.defaultPadding * 2),
          child: ErrorState(
              title: AppStrings.errorTitleText,
              subtitle: repoState.errorMessage!,
              onRefresh: onRefresh),
        ),
      );
    }
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding),
            margin: const EdgeInsets.symmetric(
                vertical: AppConstants.marginElement * 2),
            child: RepoCard(repoModel: repoState.repos[index]),
          );
        }, childCount: repoState.repos.length),
      ),
    );
  }
}

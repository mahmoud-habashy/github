import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github/data/providers/recent_search_provider.dart';
import 'package:github/data/providers/user_provider.dart';
import 'package:github/presentation/widgets/error_state.dart';
import 'package:github/presentation/widgets/empty_search_state.dart';
import 'package:github/presentation/widgets/search_input_field.dart';
import 'package:github/presentation/widgets/recent_search_state.dart';
import 'package:github/shared/app_colors.dart';
import 'package:github/shared/app_constants.dart';
import 'package:github/shared/app_strings.dart';
import 'package:github/util/app_router.dart';

/// The main screen.
/// This screen has three states:
///
/// EmptySearchState:
/// User opens the app for first time or the user does not have any recent searches stored in the device.
///
/// RecentSearchState:
/// User already has recent searches stored in the device.
///
/// ErrorState:
/// When error occurred.
///

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  bool _lockSubmitBtn = false;
  bool _hasRecentSearch = false;
  UserState? _userState;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchInputChange);
    ref.read(storedUserDataProvider.notifier).fetchRecentSearch();
  }

  @override
  void dispose() {
    // Clean up the controller and focus node.
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchInputChange() => setState(() => {});

  void _search() async {
    if (!_lockSubmitBtn && _formKey.currentState!.validate()) {
      _lockSubmitBtn = true;
      FocusScope.of(context).unfocus();

      bool result = await ref
          .read(userProvider.notifier)
          .getUserByName(_searchController.text);

      _lockSubmitBtn = false;

      if (result && mounted) {
        _searchController.clear();
        Future.delayed(
            const Duration(milliseconds: AppConstants.defaultAnimationDuration),
            () => Navigator.of(context).pushNamed(AppRoutes.dashboardScreen));
      }
    }
  }

  Widget _getContent() {
    if (_userState != null && _userState!.errorMessage != null) {
      return ErrorState(
          title: AppStrings.errorTitleText,
          subtitle: _userState!.errorMessage!,
          onRefresh: _search);
    }
    if (_hasRecentSearch) {
      return const RecentSearchState();
    }
    return EmptySearchState(
      isPrimaryBtnActive: !_lockSubmitBtn && _searchController.text.isNotEmpty,
      onPrimaryBtnPressed: _search,
    );
  }

  @override
  Widget build(BuildContext context) {
    _hasRecentSearch = ref.watch(storedUserDataProvider).isNotEmpty;
    _userState = ref.watch(userProvider);
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.backgroundDark, AppColors.backgroundLight])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Form(
                key: _formKey,
                child: SearchInputField(
                  searchController: _searchController,
                  searchFocusNode: _searchFocusNode,
                  onSubmit: _search,
                ),
              ),
            ),
            Expanded(child: _getContent()),
          ],
        )),
      ),
    );
  }
}

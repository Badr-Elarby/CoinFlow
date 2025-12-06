import 'package:flutter/material.dart';
import 'package:team_7/core/responsive/size_extensions.dart';
import 'package:team_7/features/onboarding/domain/models/onboarding_model.dart';
import 'package:team_7/features/onboarding/presentation/widgets/onboarding_action_buttons.dart';
import 'package:team_7/features/onboarding/presentation/widgets/onboarding_content.dart';
import 'package:team_7/features/onboarding/presentation/widgets/onboarding_navigation.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingModel> _pages = const [
    OnboardingModel(
      image: 'assets/images/onboarding_1.png',
      title: 'Welcome To ',
      highlight: 'Crypto X',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding_2.png',
      title: 'Transaction Security',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding_3.png',
      title: 'Fast And Reliable Market\nUpdated',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding_4.png',
      title: 'Get Started Now!',
    ),
  ];

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onSkip() {
    _pageController.jumpToPage(_pages.length - 1);
  }

  Widget _buildPage(int index) {
    final page = _pages[index];
    final isLastPage = index == _pages.length - 1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OnboardingContent(
          imagePath: page.image,
          title: page.title,
          highlightedText: page.highlight,
          imageHeight: isLastPage ? context.hp(35) : null,
          imageWidth: isLastPage ? context.wp(70) : null,
        ),
        if (isLastPage) ...[
          SizedBox(height: context.hp(8)),
          const OnboardingActionButtons(),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _pages.length - 1;
    final showSkip = _currentPage == 1 || _currentPage == 2;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.wp(6),
                vertical: context.hp(2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (showSkip)
                    GestureDetector(
                      onTap: _onSkip,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    )
                  else
                    const SizedBox(height: 24),
                ],
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) => _buildPage(index),
              ),
            ),

            if (!isLastPage)
              OnboardingNavigation(
                currentPage: _currentPage,
                totalPages: _pages.length,
                onNext: _onNext,
              )
            else
              SizedBox(height: context.hp(4)),
          ],
        ),
      ),
    );
  }
}

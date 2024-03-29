part of '_pages.dart';

class OnboardingPageV2 extends StatefulWidget {
  const OnboardingPageV2({super.key});

  @override
  State<OnboardingPageV2> createState() => _OnboardingPageV2State();
}

class _OnboardingPageV2State extends State<OnboardingPageV2> {
  int selectedIndex = 0;
  void setPage(int index) {
    selectedIndex = index;
  }

  final PageController pageController = PageController();
  final currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: PageView.builder(
                  controller: pageController,
                  itemCount: getStartedList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = getStartedList[index];
                    return buildOnboardPage(index, item['image'] as String,
                        item['title'] as String, item['description'] as String);
                  },
                  onPageChanged: (int index) {
                    currentPageNotifier.value = index;
                    setPage(index);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnboardPage(
      int index, String image, String title, String description) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${index + 1}/${getStartedList.length}',
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              buildIndicator(),
            ],
          ),
          Visibility(
            visible: image.isNotEmpty,
            child: Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Image.asset(
                    image,
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Text(
                    title,
                    style: FontTheme.blackSubtitleBold(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    description,
                    style: FontTheme.greyNormal14(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.6, // Set the width to 80%
            child: Button(
              onTap: () async {
                if (selectedIndex != 2) {
                  await pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                } else {
                  await context.push('/login');
                }
              },
              customButtonColor: BaseColors.brightBlue,
              customTextColor: Colors.white,
              text: (index != 2 ? 'Selanjutnya' : 'Masuk'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      child: CirclePageIndicator(
        dotColor: BaseColors.greyCustom,
        selectedDotColor: BaseColors.brightBlue,
        itemCount: getStartedList.length,
        currentPageNotifier: currentPageNotifier,
      ),
    );
  }
}

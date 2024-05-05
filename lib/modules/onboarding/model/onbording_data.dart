import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';

import '../../../utils/k_images.dart';
import 'onbording_model.dart';

final onBoardingList = [
  OnBordingModel(
    image: Kimages.onboarding_1,
    title: Language.onBoardingTitle1.capitalizeByWord(),
    paragraph: Language.onBoardingSubTitle,
  ),
  OnBordingModel(
    image: Kimages.onboarding_2,
    title: Language.onBoardingTitle2.capitalizeByWord(),
    paragraph: Language.onBoardingSubTitle,
  ),
  OnBordingModel(
    image: Kimages.onboarding_3,
    title: Language.onBoardingTitle3,
    paragraph: Language.onBoardingSubTitle,
  ),
  OnBordingModel(
    image: Kimages.enableLocation,
    title: Language.enabledLocation.capitalizeByWord(),
    paragraph: Language.onBoardingSubTitle,
  ),
];

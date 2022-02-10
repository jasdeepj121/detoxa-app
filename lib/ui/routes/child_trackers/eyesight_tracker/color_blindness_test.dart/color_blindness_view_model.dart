import 'package:detoxa/dataModels/color_blindness_option.dart';
import 'package:stacked/stacked.dart';

class ColorBlindnessTestViewModel extends BaseViewModel {
  int _totalImages = 18;
  int _imageNumber = 1;
  double _progress = 0.0;
  List<ColorBlindnessOption> _selectedAnswers = [];

  int get imageNumber => _imageNumber;
  double get progress => _progress;

  ColorBlindnessTestViewModel() {
    // _progress = (1.0 / _totalImages);
  }

  // void updateImageNumber({int newNumber}) {
  //   if (newNumber == null && _imageNumber == _totalImages) {
  //     return;
  //   }
  //   if (newNumber == null) {
  //     print((1.0 / _totalImages));
  //     _imageNumber++;
  //     _progress += (1.0 / _totalImages);
  //     if (_progress > 1.0) {
  //       _progress = 1.0;
  //     }
  //   } else {
  //     _imageNumber = newNumber;
  //   }
  //   notifyListeners();
  // }

  void selectAnswer(ColorBlindnessOption option) {
    if (_progress < 1.0 && _imageNumber < _totalImages) {
      _selectedAnswers.add(option);
      _imageNumber++;
      _progress += (1.0 / _totalImages);
      if (_progress > 1.0) {
        _progress = 1.0;
      }
    } else {
      _progress = 1.0;
    }
    notifyListeners();
  }
}

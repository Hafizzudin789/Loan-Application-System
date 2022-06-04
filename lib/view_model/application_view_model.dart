import 'package:stacked/stacked.dart';

class ApplicationViewModel extends BaseViewModel {

  bool _cardSelected = false;
  bool get cardSelected => _cardSelected;
  selectCard() {
    _cardSelected = !_cardSelected;
    notifyListeners();
  }
}
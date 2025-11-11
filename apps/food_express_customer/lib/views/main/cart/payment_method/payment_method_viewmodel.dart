import 'package:shared/common_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/locator.dart';
import '../../../../data/model/bean/card.dart';
import '../../../../data/remote/repository.dart';

class PaymentMethodViewModel extends BaseViewModel {
  final _navigationService = locator.get<NavigationService>();
  var _snackBarService = locator.get<SnackbarService>();
  var _dialogService = locator.get<DialogService>();

  PaymentMethodViewModel() {
    StripePayment.setOptions(StripeOptions(publishableKey: STRIPE_KEY));
    _getCards();
  }

  List<Card>? _cards;
  List<Card>? get cards => _cards;

  Card? _selectedCard;
  Card? get selectedCard => _selectedCard;

  updatedSelectedCard(c) {
    _selectedCard = c;
    notifyListeners();
  }

  selectCardForPayment(Card card) {
    _navigationService.back(result: card);
  }

  _getCards() async {
    setBusyForObject(_cards, true);
    var result = await locator<Repository>().getCards();
    setBusyForObject(_cards, false);
    result.fold((failure) => showRetryDialog(failure: failure), (res) {
      _cards = res.cards;
      notifyListeners();
    });
  }

  String number = '', name = '', expiry = '', cvv = '';
  var numError, nameError, expError, cvvError;

  navigateBack() {
    _navigationService.back();
  }

  doneClick() async {
    if (_validateInput()) {
      showLoading();
      CreditCard card = CreditCard(
          name: name,
          cvc: cvv,
          number: number,
          expMonth: int.tryParse(expiry.split('/').elementAt(0)),
          expYear: int.parse(expiry.split('/').elementAt(1)));
      try {
        var token = await StripePayment.createTokenWithCard(card);
        _callAddCardApi(token);
      } catch (e) {
        await hideLoading();
        showRetryDialog(message: e.message);
      }
    }
  }

  _callAddCardApi(Token token) async {
    var result = await locator<Repository>()
        .addCard(requestBody: _getRequestForAddCard(token.tokenId));
    await hideLoading();
    result.fold((failure) => showRetryDialog(failure: failure), (res) {
      _navigationService.back(result: res.card);
    });
  }

  Map<String, dynamic> _getRequestForAddCard(String token) {
    Map<String, dynamic> request = Map();
    request['stripe_token'] = token;
    request['card_holder_name'] = name;
    return request;
  }

  bool _validateInput() {
    var e1, e2, e3, e4;
    if (number.isEmpty) {
      e1 = 'required';
    } else {
      bool isValidCard = CreditCardValidator.getCard(
          removeAllSpace(number))[CreditCardValidator.isValidCard];
      if (!isValidCard) {
        e1 = 'invalid number';
      }
    }
    if (name.isEmpty) {
      e2 = 'required';
    }
    if (expiry.isEmpty) {
      e3 = 'required';
    } else {
      if (expiry.length < 7) {
        e3 = 'invalid date';
      }
    }
    if (cvv.isEmpty) {
      e4 = 'required';
    } else {
      if (cvv.length < 3) {
        e4 = 'invalid cvv';
      }
    }
    numError = e1;
    nameError = e2;
    expError = e3;
    cvvError = e4;
    notifyListeners();
    return e1 == null && e2 == null && e3 == null && e4 == null;
  }

  confirmDelete(Card card) async {
    showDialog(
      'Are you sure, you want to delete this card?',
      okBtnTitle: 'Yes',
      cancelBtnTitle: 'No',
      okBtnClick: () {
        deleteCard(card);
      },
    );
  }

  deleteCard(Card card) async {
    showLoading();
    var result = await locator<Repository>().deleteCard('${card.id}');
    await hideLoading();
    result.fold((failure) => showRetryDialog(failure: failure), (res) {
      _cards?.remove(card);
      notifyListeners();
    });
  }
}

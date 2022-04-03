class CurrencyHelper {
  String getCurrencySymbol(currency) {
    var symbol = '';
    switch (currency) {
      case 'USD':
        symbol = '\$';
        break;

      case 'EUR':
        symbol = '€';
        break;

      case 'GBP':
        symbol = '£';
        break;

      case 'HKD':
        symbol = '\$';
        break;

      case 'TRY':
        symbol = '₺';
        break;

      case 'INR':
        symbol = '₹';
        break;

      case 'KRW':
        symbol = '₩';
        break;

      case 'CHF':
        symbol = 'Fr.';
        break;

      case 'JPY':
        symbol = '¥';
        break;

      case 'RMB':
        symbol = '¥';
        break;

      case 'RUB':
        symbol = '₽';
        break;

      case 'SEK':
        symbol = 'kr.';
        break;

      case 'SGD':
        symbol = '\$';
        break;

      case 'AUD':
        symbol = '\$';
        break;

      case 'CAD':
        symbol = '\$';
        break;

      case 'NZD':
        symbol = '\$';
        break;

      case 'default':
        symbol = '';
    }
    return symbol;
  }
}

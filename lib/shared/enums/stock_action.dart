enum StockAction {
  incoming,
  outgoing,
}

extension StockActionExtension on StockAction {
  String get value {
    switch (this) {
      case StockAction.incoming:
        return 'IN';
      case StockAction.outgoing:
        return 'OUT';
    }
  }

  String get label {
    switch (this) {
      case StockAction.incoming:
        return 'นำเข้า';
      case StockAction.outgoing:
        return 'จ่ายออก';
    }
  }

  static StockAction fromString(String s) {
    switch (s) {
      case 'IN':
        return StockAction.incoming;
      case 'OUT':
        return StockAction.outgoing;
      default:
        throw ArgumentError('Invalid StockAction: $s');
    }
  }
}

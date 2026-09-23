import '../../helpers/fake_helper.dart';

abstract final class WooCurrency {
  static const String usd = 'USD';
  static const String eur = 'EUR';
  static const String gbp = 'GBP';
  static const String aud = 'AUD';
  static const String cad = 'CAD';
  static const String jpy = 'JPY';
  static const String inr = 'INR';
  static const String brl = 'BRL';
  static const String mxn = 'MXN';
  static const String nzd = 'NZD';
  static const String sgd = 'SGD';
  static const String chf = 'CHF';
  static const String hkd = 'HKD';
  static const String cny = 'CNY';
  static const String krw = 'KRW';
  static const String sek = 'SEK';
  static const String nok = 'NOK';
  static const String dkk = 'DKK';
  static const String pln = 'PLN';
  static const String czk = 'CZK';
  static const String try_ = 'TRY';
  static const String aed = 'AED';
  static const String sar = 'SAR';
  static const String zar = 'ZAR';
  static const String ils = 'ILS';
  static const String rub = 'RUB';
  static const String ron = 'RON';
  static const String huf = 'HUF';
  static const String uah = 'UAH';
  static const String vnd = 'VND';
  static const String thb = 'THB';
  static const String php = 'PHP';
  static const String idr = 'IDR';
  static const String myr = 'MYR';
  static const String twd = 'TWD';
  static const String clp = 'CLP';
  static const String cop = 'COP';
  static const String ars = 'ARS';
  static const String egp = 'EGP';
  static const String ngn = 'NGN';
  static const String kes = 'KES';
  static const String pkr = 'PKR';
  static const String bdt = 'BDT';
  static const String lkr = 'LKR';
  static const List<String> common = [
    usd,
    eur,
    gbp,
    aud,
    cad,
    jpy,
    inr,
    brl,
    mxn,
    nzd,
    sgd,
    chf,
    hkd,
    cny,
    krw,
    sek,
    nok,
    dkk,
    pln,
    czk,
    try_,
    aed,
    sar,
    zar,
    ils,
    rub,
    ron,
    huf,
    uah,
    vnd,
    thb,
    php,
    idr,
    myr,
    twd,
    clp,
    cop,
    ars,
    egp,
    ngn,
    kes,
    pkr,
    bdt,
    lkr,
  ];
  static String fake() => FakeHelper.randomItem(common);
}

// ignore_for_file: constant_identifier_names

import 'package:faker/faker.dart';

enum WooOrderCurrency {
  AED,
  AFN,
  ALL,
  AMD,
  ANG,
  AOA,
  ARS,
  AUD,
  AWG,
  AZN,
  BAM,
  BBD,
  BDT,
  BGN,
  BHD,
  BIF,
  BMD,
  BND,
  BOB,
  BRL,
  BSD,
  BTC,
  BTN,
  BWP,
  BYR,
  BZD,
  CAD,
  CDF,
  CHF,
  CLP,
  CNY,
  COP,
  CRC,
  CUC,
  CUP,
  CVE,
  CZK,
  DJF,
  DKK,
  DOP,
  DZD,
  EGP,
  ERN,
  ETB,
  EUR,
  FJD,
  FKP,
  GBP,
  GEL,
  GGP,
  GHS,
  GIP,
  GMD,
  GNF,
  GTQ,
  GYD,
  HKD,
  HNL,
  HRK,
  HTG,
  HUF,
  IDR,
  ILS,
  IMP,
  INR,
  IQD,
  IRR,
  IRT,
  ISK,
  JEP,
  JMD,
  JOD,
  JPY,
  KES,
  KGS,
  KHR,
  KMF,
  KPW,
  KRW,
  KWD,
  KYD,
  KZT,
  LAK,
  LBP,
  LKR,
  LRD,
  LSL,
  LYD,
  MAD,
  MDL,
  MGA,
  MKD,
  MMK,
  MNT,
  MOP,
  MRO,
  MUR,
  MVR,
  MWK,
  MXN,
  MYR,
  MZN,
  NAD,
  NGN,
  NIO,
  NOK,
  NPR,
  NZD,
  OMR,
  PAB,
  PEN,
  PGK,
  PHP,
  PKR,
  PLN,
  PRB,
  PYG,
  QAR,
  RON,
  RSD,
  RUB,
  RWF,
  SAR,
  SBD,
  SCR,
  SDG,
  SEK,
  SGD,
  SHP,
  SLL,
  SOS,
  SRD,
  SSP,
  STD,
  SYP,
  SZL,
  THB,
  TJS,
  TMT,
  TND,
  TOP,
  TRY,
  TTD,
  TWD,
  TZS,
  UAH,
  UGX,
  USD,
  UYU,
  UZS,
  VEF,
  VND,
  VUV,
  WST,
  XAF,
  XCD,
  XOF,
  XPF,
  YER,
  ZAR,
  ZMW;

  static WooOrderCurrency fake() {
    return values[Faker().randomGenerator.integer(values.length - 1)];
  }

  static WooOrderCurrency fromString(String type) {
    if (type == 'AED') {
      return WooOrderCurrency.AED;
    }
    if (type == 'AFN') {
      return WooOrderCurrency.AFN;
    }
    if (type == 'ALL') {
      return WooOrderCurrency.ALL;
    }
    if (type == 'AMD') {
      return WooOrderCurrency.AMD;
    }
    if (type == 'ANG') {
      return WooOrderCurrency.ANG;
    }
    if (type == 'AOA') {
      return WooOrderCurrency.AOA;
    }
    if (type == 'ARS') {
      return WooOrderCurrency.ARS;
    }
    if (type == 'AUD') {
      return WooOrderCurrency.AUD;
    }
    if (type == 'AWG') {
      return WooOrderCurrency.AWG;
    }
    if (type == 'AZN') {
      return WooOrderCurrency.AZN;
    }
    if (type == 'BAM') {
      return WooOrderCurrency.BAM;
    }
    if (type == 'BBD') {
      return WooOrderCurrency.BBD;
    }
    if (type == 'BDT') {
      return WooOrderCurrency.BDT;
    }
    if (type == 'BGN') {
      return WooOrderCurrency.BGN;
    }
    if (type == 'BHD') {
      return WooOrderCurrency.BHD;
    }
    if (type == 'BIF') {
      return WooOrderCurrency.BIF;
    }
    if (type == 'BMD') {
      return WooOrderCurrency.BMD;
    }
    if (type == 'BND') {
      return WooOrderCurrency.BND;
    }
    if (type == 'BOB') {
      return WooOrderCurrency.BOB;
    }
    if (type == 'BRL') {
      return WooOrderCurrency.BRL;
    }
    if (type == 'BSD') {
      return WooOrderCurrency.BSD;
    }
    if (type == 'BTC') {
      return WooOrderCurrency.BTC;
    }
    if (type == 'BTN') {
      return WooOrderCurrency.BTN;
    }
    if (type == 'BWP') {
      return WooOrderCurrency.BWP;
    }
    if (type == 'BYR') {
      return WooOrderCurrency.BYR;
    }
    if (type == 'BZD') {
      return WooOrderCurrency.BZD;
    }
    if (type == 'CAD') {
      return WooOrderCurrency.CAD;
    }
    if (type == 'CDF') {
      return WooOrderCurrency.CDF;
    }
    if (type == 'CHF') {
      return WooOrderCurrency.CHF;
    }
    if (type == 'CLP') {
      return WooOrderCurrency.CLP;
    }
    if (type == 'CNY') {
      return WooOrderCurrency.CNY;
    }
    if (type == 'COP') {
      return WooOrderCurrency.COP;
    }
    if (type == 'CRC') {
      return WooOrderCurrency.CRC;
    }
    if (type == 'CUC') {
      return WooOrderCurrency.CUC;
    }
    if (type == 'CUP') {
      return WooOrderCurrency.CUP;
    }
    if (type == 'CVE') {
      return WooOrderCurrency.CVE;
    }
    if (type == 'CZK') {
      return WooOrderCurrency.CZK;
    }
    if (type == 'DJF') {
      return WooOrderCurrency.DJF;
    }
    if (type == 'DKK') {
      return WooOrderCurrency.DKK;
    }
    if (type == 'DOP') {
      return WooOrderCurrency.DOP;
    }
    if (type == 'DZD') {
      return WooOrderCurrency.DZD;
    }
    if (type == 'EGP') {
      return WooOrderCurrency.EGP;
    }
    if (type == 'ERN') {
      return WooOrderCurrency.ERN;
    }
    if (type == 'ETB') {
      return WooOrderCurrency.ETB;
    }
    if (type == 'EUR') {
      return WooOrderCurrency.EUR;
    }
    if (type == 'FJD') {
      return WooOrderCurrency.FJD;
    }
    if (type == 'FKP') {
      return WooOrderCurrency.FKP;
    }
    if (type == 'GBP') {
      return WooOrderCurrency.GBP;
    }
    if (type == 'GEL') {
      return WooOrderCurrency.GEL;
    }
    if (type == 'GGP') {
      return WooOrderCurrency.GGP;
    }
    if (type == 'GHS') {
      return WooOrderCurrency.GHS;
    }
    if (type == 'GIP') {
      return WooOrderCurrency.GIP;
    }
    if (type == 'GMD') {
      return WooOrderCurrency.GMD;
    }
    if (type == 'GNF') {
      return WooOrderCurrency.GNF;
    }
    if (type == 'GTQ') {
      return WooOrderCurrency.GTQ;
    }
    if (type == 'GYD') {
      return WooOrderCurrency.GYD;
    }
    if (type == 'HKD') {
      return WooOrderCurrency.HKD;
    }
    if (type == 'HNL') {
      return WooOrderCurrency.HNL;
    }
    if (type == 'HRK') {
      return WooOrderCurrency.HRK;
    }
    if (type == 'HTG') {
      return WooOrderCurrency.HTG;
    }
    if (type == 'HUF') {
      return WooOrderCurrency.HUF;
    }
    if (type == 'IDR') {
      return WooOrderCurrency.IDR;
    }
    if (type == 'ILS') {
      return WooOrderCurrency.ILS;
    }
    if (type == 'IMP') {
      return WooOrderCurrency.IMP;
    }
    if (type == 'INR') {
      return WooOrderCurrency.INR;
    }
    if (type == 'IQD') {
      return WooOrderCurrency.IQD;
    }
    if (type == 'IRR') {
      return WooOrderCurrency.IRR;
    }
    if (type == 'IRT') {
      return WooOrderCurrency.IRT;
    }
    if (type == 'ISK') {
      return WooOrderCurrency.ISK;
    }
    if (type == 'JEP') {
      return WooOrderCurrency.JEP;
    }
    if (type == 'JMD') {
      return WooOrderCurrency.JMD;
    }
    if (type == 'JOD') {
      return WooOrderCurrency.JOD;
    }
    if (type == 'JPY') {
      return WooOrderCurrency.JPY;
    }
    if (type == 'KES') {
      return WooOrderCurrency.KES;
    }
    if (type == 'KGS') {
      return WooOrderCurrency.KGS;
    }
    if (type == 'KHR') {
      return WooOrderCurrency.KHR;
    }
    if (type == 'KMF') {
      return WooOrderCurrency.KMF;
    }
    if (type == 'KPW') {
      return WooOrderCurrency.KPW;
    }
    if (type == 'KRW') {
      return WooOrderCurrency.KRW;
    }
    if (type == 'KWD') {
      return WooOrderCurrency.KWD;
    }
    if (type == 'KYD') {
      return WooOrderCurrency.KYD;
    }
    if (type == 'KZT') {
      return WooOrderCurrency.KZT;
    }
    if (type == 'LAK') {
      return WooOrderCurrency.LAK;
    }
    if (type == 'LBP') {
      return WooOrderCurrency.LBP;
    }
    if (type == 'LKR') {
      return WooOrderCurrency.LKR;
    }
    if (type == 'LRD') {
      return WooOrderCurrency.LRD;
    }
    if (type == 'LSL') {
      return WooOrderCurrency.LSL;
    }
    if (type == 'LYD') {
      return WooOrderCurrency.LYD;
    }
    if (type == 'MAD') {
      return WooOrderCurrency.MAD;
    }
    if (type == 'MDL') {
      return WooOrderCurrency.MDL;
    }
    if (type == 'MGA') {
      return WooOrderCurrency.MGA;
    }
    if (type == 'MKD') {
      return WooOrderCurrency.MKD;
    }
    if (type == 'MMK') {
      return WooOrderCurrency.MMK;
    }
    if (type == 'MNT') {
      return WooOrderCurrency.MNT;
    }
    if (type == 'MOP') {
      return WooOrderCurrency.MOP;
    }
    if (type == 'MRO') {
      return WooOrderCurrency.MRO;
    }
    if (type == 'MUR') {
      return WooOrderCurrency.MUR;
    }
    if (type == 'MVR') {
      return WooOrderCurrency.MVR;
    }
    if (type == 'MWK') {
      return WooOrderCurrency.MWK;
    }
    if (type == 'MXN') {
      return WooOrderCurrency.MXN;
    }
    if (type == 'MYR') {
      return WooOrderCurrency.MYR;
    }
    if (type == 'MZN') {
      return WooOrderCurrency.MZN;
    }
    if (type == 'NAD') {
      return WooOrderCurrency.NAD;
    }
    if (type == 'NGN') {
      return WooOrderCurrency.NGN;
    }
    if (type == 'NIO') {
      return WooOrderCurrency.NIO;
    }
    if (type == 'NOK') {
      return WooOrderCurrency.NOK;
    }
    if (type == 'NPR') {
      return WooOrderCurrency.NPR;
    }
    if (type == 'NZD') {
      return WooOrderCurrency.NZD;
    }
    if (type == 'OMR') {
      return WooOrderCurrency.OMR;
    }
    if (type == 'PAB') {
      return WooOrderCurrency.PAB;
    }
    if (type == 'PEN') {
      return WooOrderCurrency.PEN;
    }
    if (type == 'PGK') {
      return WooOrderCurrency.PGK;
    }
    if (type == 'PHP') {
      return WooOrderCurrency.PHP;
    }
    if (type == 'PKR') {
      return WooOrderCurrency.PKR;
    }
    if (type == 'PLN') {
      return WooOrderCurrency.PLN;
    }
    if (type == 'PRB') {
      return WooOrderCurrency.PRB;
    }
    if (type == 'PYG') {
      return WooOrderCurrency.PYG;
    }
    if (type == 'QAR') {
      return WooOrderCurrency.QAR;
    }
    if (type == 'RON') {
      return WooOrderCurrency.RON;
    }
    if (type == 'RSD') {
      return WooOrderCurrency.RSD;
    }
    if (type == 'RUB') {
      return WooOrderCurrency.RUB;
    }
    if (type == 'RWF') {
      return WooOrderCurrency.RWF;
    }
    if (type == 'SAR') {
      return WooOrderCurrency.SAR;
    }
    if (type == 'SBD') {
      return WooOrderCurrency.SBD;
    }
    if (type == 'SCR') {
      return WooOrderCurrency.SCR;
    }
    if (type == 'SDG') {
      return WooOrderCurrency.SDG;
    }
    if (type == 'SEK') {
      return WooOrderCurrency.SEK;
    }
    if (type == 'SGD') {
      return WooOrderCurrency.SGD;
    }
    if (type == 'SHP') {
      return WooOrderCurrency.SHP;
    }
    if (type == 'SLL') {
      return WooOrderCurrency.SLL;
    }
    if (type == 'SOS') {
      return WooOrderCurrency.SOS;
    }
    if (type == 'SRD') {
      return WooOrderCurrency.SRD;
    }
    if (type == 'SSP') {
      return WooOrderCurrency.SSP;
    }
    if (type == 'STD') {
      return WooOrderCurrency.STD;
    }
    if (type == 'SYP') {
      return WooOrderCurrency.SYP;
    }
    if (type == 'SZL') {
      return WooOrderCurrency.SZL;
    }
    if (type == 'THB') {
      return WooOrderCurrency.THB;
    }
    if (type == 'TJS') {
      return WooOrderCurrency.TJS;
    }
    if (type == 'TMT') {
      return WooOrderCurrency.TMT;
    }
    if (type == 'TND') {
      return WooOrderCurrency.TND;
    }
    if (type == 'TOP') {
      return WooOrderCurrency.TOP;
    }
    if (type == 'TRY') {
      return WooOrderCurrency.TRY;
    }
    if (type == 'TTD') {
      return WooOrderCurrency.TTD;
    }
    if (type == 'TWD') {
      return WooOrderCurrency.TWD;
    }
    if (type == 'TZS') {
      return WooOrderCurrency.TZS;
    }
    if (type == 'UAH') {
      return WooOrderCurrency.UAH;
    }
    if (type == 'UGX') {
      return WooOrderCurrency.UGX;
    }
    if (type == 'USD') {
      return WooOrderCurrency.USD;
    }
    if (type == 'UYU') {
      return WooOrderCurrency.UYU;
    }
    if (type == 'UZS') {
      return WooOrderCurrency.UZS;
    }
    if (type == 'VEF') {
      return WooOrderCurrency.VEF;
    }
    if (type == 'VND') {
      return WooOrderCurrency.VND;
    }
    if (type == 'VUV') {
      return WooOrderCurrency.VUV;
    }
    if (type == 'WST') {
      return WooOrderCurrency.WST;
    }
    if (type == 'XAF') {
      return WooOrderCurrency.XAF;
    }
    if (type == 'XCD') {
      return WooOrderCurrency.XCD;
    }
    if (type == 'XOF') {
      return WooOrderCurrency.XOF;
    }
    if (type == 'XPF') {
      return WooOrderCurrency.XPF;
    }
    if (type == 'YER') {
      return WooOrderCurrency.YER;
    }
    if (type == 'ZAR') {
      return WooOrderCurrency.ZAR;
    }
    if (type == 'ZMW') {
      return WooOrderCurrency.ZMW;
    }

    return WooOrderCurrency.USD;
  }
}

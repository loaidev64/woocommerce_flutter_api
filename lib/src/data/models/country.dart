import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooCountry {
  WooCountry({this.code, this.name, this.states});
  factory WooCountry.fromJson(Map<String, dynamic> json) => WooCountry(
        code: WooJson.readString(json, 'code'),
        name: WooJson.readString(json, 'name'),
        states: WooJson.readList(json, 'states', StateInCountry.fromJson),
      );
  factory WooCountry.fake() => WooCountry(
        code: FakeHelper.countryCode(),
        name: FakeHelper.country(),
        states: FakeHelper.list(StateInCountry.fake),
      );
  final String? code;
  final String? name;
  final List<StateInCountry>? states;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('code', code)
    ..putIfPresent('name', name)
    ..putIfPresent('states', states?.map((e) => e.toJson()).toList());
  WooCountry copyWith({
    String? code,
    String? name,
    List<StateInCountry>? states,
  }) =>
      WooCountry(
        code: code ?? this.code,
        name: name ?? this.name,
        states: states ?? this.states,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooCountry &&
        other.code == code &&
        other.name == name &&
        WooJson.listEquals(other.states, states);
  }

  @override
  int get hashCode =>
      Object.hash(code, name, Object.hashAll(states ?? const []));
  @override
  String toString() => 'WooCountry(code: $code, name: $name)';
}

class StateInCountry {
  StateInCountry({this.code, this.name});
  factory StateInCountry.fromJson(Map<String, dynamic> json) => StateInCountry(
        code: WooJson.readString(json, 'code'),
        name: WooJson.readString(json, 'name'),
      );
  factory StateInCountry.fake() => StateInCountry(
        code: FakeHelper.word(),
        name: FakeHelper.state(),
      );
  final String? code;
  final String? name;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('code', code)
    ..putIfPresent('name', name);
  StateInCountry copyWith({String? code, String? name}) => StateInCountry(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StateInCountry && other.code == code && other.name == name;
  }

  @override
  int get hashCode => Object.hashAll([code, name]);
  @override
  String toString() => 'StateInCountry(code: $code, name: $name)';
}

import 'package:ast_parser/src/token/implementations/pattern.dart';
import 'package:ast_parser/src/token/match.dart';
import 'package:ast_parser/src/token/pattern.dart';

class MultipleToken<PatternT extends Pattern> extends PatternToken<PatternT> {
  final bool orNone;
  MultipleToken(super.pattern, { super.name, this.orNone = false });
  MultipleToken.orNone(super.pattern, { super.name }) : orNone = true;

  @override
  TokenMatch<MultipleToken<PatternT>>? match(String string, [ int start = 0 ]) {
    final token = pattern.token();
    final matches = <TokenMatch>[];

    int index = start;
    TokenMatch? match;
    while ((match = token.match(string, index)) != null) {
      matches.add(match!);
      index = match.end;
    }

    if (orNone && matches.isEmpty) return TokenMatch.emptyAt(this, string, start);
    if (matches.isEmpty) return null;
    return TokenMatch.all(this, matches);
  }

  @override
  String toString() => '$pattern*';
}
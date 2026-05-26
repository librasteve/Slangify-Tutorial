[← Index](../index.md)

5. Validation and Constraints
=============================

This is where the Slangify approach becomes more valuable than plain prompting. Constraints live in the grammar and the `Booking` class — not in the prompt.

Tightening grammar tokens
-------------------------

Restrict `party` to one or two digits (no absurdly large parties):

```raku
token party { <[1..9]> \d? }   # 1–99
```

Restrict `time` to valid 24-hour ranges:

```raku
token time { <[0..2]>\d ':' <[0..5]>\d }
```

Any LLM output that violates these rules causes the grammar to fail — the error surfaces before the result reaches your application.

Constraints in the Booking class
--------------------------------

Use Raku's type system and `TWEAK` for business-rule validation:

```raku
class Booking does Actionable {
    has Str $.name;
    has Int $.party where 1 <= * <= 20;   # range constraint
    has Str $.time;
    has Str $.restaurant;
    has Str $.date;
}
```

If the LLM produces `party: 0` or `party: 99`, object construction fails with a clear type error rather than silently accepting bad data.

Seeing failure in action
------------------------

```raku
# LLM normalized "a crowd" to: party many
my $m = Slangify::Tutorial::Grammar.parse(
    'name "X" party many time 19:00 restaurant "Y" date today'
);
say $m.so;   # False — grammar rejects non-numeric party
```

Readers love seeing failure **and** correction. The grammar gives you both: a clear rejection plus a single place to tighten the rule.

Preferred types
---------------

**integers**

Use C<\d+> in the token and C<Int> in the class attribute.

**enums**

Use alternation in the token: C<low | medium | high>.

**dates**

Use a specific pattern token rather than bare C<\S+> if you need validation.

**free strings**

Keep C<\S+> or C<< <-["]>+ >> but add C<Str> typing so at least the attribute is defined.


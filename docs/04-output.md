[← Index](../index.md)

# 04. The Generated Output

## Example call

```raku
use Slangify::Tutorial;

say extract-booking("Book a table for Sam and three friends at Pizza East tomorrow at 8pm");
```

## Output

```json
{
  "name": "Sam",
  "party": 4,
  "time": "20:00",
  "restaurant": "Pizza East",
  "date": "tomorrow"
}
```

The LLM resolved `"Sam and three friends"` to `party: 4` and normalized `8pm` to `20:00` — both things a regex alone cannot do reliably.

## Why structured output matters

  * **Easier to consume downstream** — hand the hash to a database, API, or next pipeline step without parsing

  * **Avoids brittle regex** — the grammar rejects anything that doesn't fit, so bad output surfaces immediately rather than silently corrupting data

  * **Easy to validate** — typed fields (`Int`, `Str`) give you free basic checks before any business logic runs

## The Booking object

Behind the scenes `extract-booking` returns `$match.made.raku`, where `.made` is a `Booking` instance populated by the `Actionable` role:

```raku
use Slangify::Tutorial::Grammar;
use Slangify::Tutorial::Actions;

my $canonical = 'name "Jane" party 4 time 19:30 restaurant "Bistro Verde" date tomorrow';

my $m = Slangify::Tutorial::Grammar.parse($canonical,
            :actions(Slangify::Tutorial::Actions.new));
my $b = $m.made;
say $b.WHAT;        # (Booking)
say $b.name;        # Sam
say $b.party;       # 4  (Int, not Str)
say $b.restaurant;  # Pizza East
```

See [Booking Class](./actions.md) declaration.


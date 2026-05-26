[← Index](../index.md)

# 05. Iteration

Building a reliable DSL pipeline is rarely one-shot. The typical workflow is a short loop: run → observe → tighten → repeat.

## The iteration loop

    1. Write grammar + prompt
    2. Run against a sample input
    3. Inspect the canonical DSL the LLM produced
    4. If the grammar rejects it — tighten the prompt or relax the token
    5. If the grammar accepts it but the data is wrong — tighten the token
    6. Repeat until the full sample set passes

## Logging the canonical DSL

Always log the intermediate DSL string so you can see exactly what the LLM produced before the grammar runs:

```raku
sub parse-booking(Str $text --> Str) is export {
    my $canonical = normalize-text($text);
    note "canonical: $canonical";          # ← add during development
    my $match = Slangify::Tutorial::Grammar.parse(
        $canonical,
        :actions(Slangify::Tutorial::Actions.new)
    );
    die "Parse failed on: $canonical" unless $match;
    $match.made.raku
}
```

The `note` line writes to `STDERR` so it doesn't pollute the JSON output. Remove it once the grammar is stable.

## Common iteration scenarios

#### LLM uses the wrong field name

The LLM outputs `guests 4` instead of `party 4`. Fix: add an alias example to the prompt, or rename the token to match natural LLM output.

#### LLM adds extra fields

The LLM outputs `name "Jane" party 4 time 19:30 restaurant "Bistro Verde" date tomorrow notes "window seat"`. The grammar rejects it because `notes` is unknown. Fix: either add a `notes` token to the grammar, or add a rule to the prompt: `Output ONLY the five specified fields`.

#### LLM drops optional fields

The LLM omits `date` when it is not mentioned. Fix: make the token optional in `TOP` with `?` and handle the missing case in `Booking`.

#### Token too strict

Your `token time { <[0..2]>\d ':' <[0..5]>\d }` rejects `9:00` (single digit hour). Fix: `token time { \d\d? ':' <[0..5]>\d }`.

## Using the Slangify Playground for iteration

Paste your grammar into [https://slangify.org](https://slangify.org) and type DSL lines directly to test token rules without any LLM round-trip. Fast feedback for grammar iteration.


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

## Tool: Slangify Playground

[Playground Link](https://play.slangify.org/91912aa811d5a940bdcb161d131a4c1004f4d053)

[https://slangify.org/playground](https://slangify.org/playground) lets you paste a grammar and type DSL lines directly to test token rules without any LLM round-trip. Fast feedback for grammar iteration — no local install required.

You can `Share` a url to the playground to distribute the DSL model to colleagues - the `DSL` selector limits the view to `input` and `made` panels only for less technical team members.

Workflow:

  * Paste `Slangify::Tutorial::Grammar` into the grammar panel

  * Paste `Slangify::Tutorial::Action` into the action panel

  * Type a canonical DSL line into the input panel

  * The playground shows the parse tree and named captures immediately

  * Tweak a token, re-paste, re-run — tight loop with no Raku install needed

  * Share a permalink to your grammar with collaborators

## Tool: Grammar::Editor

The [Grammar::Editor](https://raku.land/zef:FCO/Grammar::Editor) module is a convenient tool for those that prefer a Terminal User Interface (TUI) environment.

Workflow:

  * Paste both `Slangify::Tutorial::Grammar` and `Slangify::Tutorial::Actions`

  * Run against a canonical DSL line to verify the `Booking` object is populated correctly

## Other Tools

For general Raku programming, a selection of IDE and editor tooling can be found at [https://raku.org/tools](https://raku.org/tools).

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


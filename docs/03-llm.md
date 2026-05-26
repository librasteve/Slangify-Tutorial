[← Index](../index.md)

# 03. Connecting to an LLM

The `normalize-text` function is the bridge between free-form English and the canonical DSL the grammar can parse.

## How it works

```raku
use LLM::Functions;

sub normalize-text(Str $text --> Str) {
    my &normalizer = llm-function(
        -> :$input {
            qq:to/PROMPT/.trim
            Convert this restaurant booking text into the DSL format shown.

            Example input:  Jane booked a table for 4 at 7:30pm tomorrow at Bistro Verde
            Example output: name "Jane" party 4 time 19:30 restaurant "Bistro Verde" date tomorrow

            Rules:
            - name: full name in double quotes
            - party: integer number of people
            - time: 24-hour HH:MM
            - restaurant: full name in double quotes
            - date: single word or ISO date

            Respond with ONLY the DSL line, no explanation.

            Input: $input
            PROMPT
        },
        llm-evaluator => 'chatgpt'
    );
    ~normalizer(input => $text)
}
```

## The three-part pipeline

  * **Prompt goes in** — free-form English from the user

  * **LLM normalizes** — converts to the canonical DSL line

  * **Grammar parses** — extracts typed, named captures

This separation is the key insight: the LLM handles natural language variation; the grammar enforces structure. Neither has to do the other's job.

## Putting it together

```raku
sub extract-booking(Str $text --> Str) is export {
    my $canonical = normalize-text($text);
    my $match = Slangify::Tutorial::Grammar.parse(
        $canonical,
        :actions(Slangify::Tutorial::Actions.new)
    );
    die "Could not parse: '$canonical'" unless $match;
    $match.made.raku
}
```

The `extract-booking` sub chains normalization → grammar → actions in one call and returns a JSON string.


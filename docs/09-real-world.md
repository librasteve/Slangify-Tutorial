[← Index](../index.md)

# 09. A Real-World Example

A support-ticket parser: convert a customer email into a structured ticket record.

## The grammar

```raku
grammar Ticket::Grammar {
    token TOP {
        <.ws>
        customer  <.ws> <customer>  <.ws>
        issue     <.ws> <issue>     <.ws>
        priority  <.ws> <priority>  <.ws>
        summary   <.ws> <summary>   <.ws>?
        $
    }

    token customer { '"' <( <-["]>+ )> '"' }
    token issue    { '"' <( <-["]>+ )> '"' }
    token priority { 'low' | 'medium' | 'high' }
    token summary  { '"' <( <-["]>+ )> '"' }
    token ws       { \h*                       }
}
```

## The Ticket class

```raku
use Actionable;

class Ticket does Actionable {
    has Str $.customer;
    has Str $.issue;
    has Str $.priority;
    has Str $.summary;

    method raku { self.action-to-json }
}

class Ticket::Actions {
    method TOP($/) { make Ticket.action($/) }
}
```

## The LLM normalizer

```raku
use LLM::Functions;

sub normalize-ticket(Str $email --> Str) {
    my &fn = llm-function(
        -> :$input {
            qq:to/PROMPT/.trim
            Convert this customer support email to DSL format.

            Example output:
              customer "Alice" issue "cannot log in" priority high summary "User locked out since yesterday"

            Rules:
            - customer: person's name in double quotes
            - issue: short phrase in double quotes
            - priority: exactly one of: low medium high
            - summary: one sentence in double quotes

            Respond with ONLY the DSL line.

            Input: $input
            PROMPT
        },
        llm-evaluator => 'chatgpt'
    );
    ~fn(input => $email)
}
```

## End-to-end call

```raku
my $email = q:to/END/;
Hi, I've been locked out of my account since yesterday morning and
have a client demo in two hours. Please help urgently! — Alice
END

my $dsl   = normalize-ticket($email);
my $match = Ticket::Grammar.parse($dsl, :actions(Ticket::Actions.new));
say $match.made.raku;
```

Output:

```json
{
  "customer": "Alice",
  "issue": "cannot log in",
  "priority": "high",
  "summary": "User locked out since yesterday morning with urgent demo upcoming"
}
```


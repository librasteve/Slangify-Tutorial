[← Index](../index.md)

# 08. Common Pitfalls

## Overly broad schemas

**Bad** — a single catch-all field:

```raku
token details { .* }
```

**Better** — specific named fields:

```raku
token customer_email { <-[\s]>+ '@' <-[\s]>+ }
token customer_issue { '"' <( <-["]>+ )> '"' }
```

Broad tokens give the grammar nothing to check and make downstream code harder to write.

## Too much logic in the prompt

Put structure in the grammar — not in the prompt.

**Fragile:**

    Extract the name, party size as an integer between 1 and 20, the time in
    24-hour format, the restaurant name without articles, and the date as a
    single lowercase word or ISO date…

**Better:** write a tight grammar and tell the LLM only the DSL format and one worked example. The grammar enforces everything else.

## Ambiguous types

Prefer precise token patterns over bare `\S+`:

<table class="pod-table">
<tbody>
<tr> <td>Vague</td> <td>Precise</td> <td></td> <td></td> </tr> <tr> <td>\S+</td> <td>\d\d\d\d &#39;-&#39; \d\d &#39;-&#39; \d\d (date)</td> <td></td> <td></td> </tr> <tr> <td>\S+</td> <td>\d+ &#39;:&#39; \d\d (time)</td> <td></td> <td></td> </tr> <tr> <td>\S+</td> <td>&#39;low&#39;</td> <td>&#39;medium&#39;</td> <td>&#39;high&#39; (enum)</td> </tr> <tr> <td>.+</td> <td>&#39;&quot;&#39; &lt;( &lt;-[&quot;]&gt;+ )&gt; &#39;&quot;&#39; (quoted string)</td> <td></td> <td></td> </tr>
</tbody>
</table>

The more specific the token, the earlier bad LLM output is caught.

## Not testing the grammar standalone

Always verify the grammar parses your canonical DSL **before** adding the LLM step. Use the [Slangify Playground](https://slangify.org) or a quick `prove6 t/01-basic.rakutest`. If the grammar itself is broken, no amount of prompt tuning will help.

## Ignoring parse failures

```raku
my $m = Grammar.parse($canonical, :actions(Actions.new));
die "Parse failed on: $canonical" unless $m;   # always check!
```

A silent `Nil` match means the LLM deviated from the DSL. Log the canonical string so you can see exactly what the LLM produced and tighten the prompt or grammar accordingly.


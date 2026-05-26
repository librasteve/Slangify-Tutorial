[← Index](../index.md)

# 09. Next Steps

## What you learned

  * Define a schema as a Raku Grammar with named tokens

  * Use `LLM::Functions` to normalize free-form text to your DSL

  * Parse the DSL with Grammar + Actions + `Actionable`

  * Get typed, validated structured output

  * Build schema-driven pipelines instead of fragile regex or prompt hacks

## Things to explore next

**Nested schemas**

Add a C<token address> subrule with its own sub-tokens, and a nested class inside C<Booking>. The C<Actionable> role composes naturally.

**Tool calling**

Wire C<extract-booking> as a tool in an C<LLM::Functions> agent so the LLM can invoke it mid-conversation.

**Streaming structured output**

Parse incrementally as the LLM streams tokens — useful when the DSL is long.

**Retries on validation failure**

Catch a failed parse, feed the raw LLM output back with an error message, and ask it to correct the DSL. Usually one retry is enough.

**Integration with agent workflows**

Use the structured C<Booking> / C<Ticket> objects as typed messages passed between agents in a multi-step pipeline.

**The Slangify Playground**

Paste any Grammar + Actions pair into L<https://slangify.org> to test and share your DSL interactively — no local install needed.

## Further reading

  * [Slangify::Tutorial source](https://github.com/librasteve/Slangify-Tutorial)

  * [LLM::Functions on CPAN](https://raku.land/zef:antononcube/LLM::Functions)

  * [Actionable on CPAN](https://raku.land/zef:librasteve/Actionable)

  * [Raku Grammar tutorial](https://docs.raku.org/language/grammars)


[← Index](../index.md)

# 10. Next Steps

## What you learned

  * Define a schema as a Raku Grammar with named tokens

  * Use `LLM::Functions` to normalize free-form text to your DSL

  * Parse the DSL with Grammar + Actions

  * Get typed, validated structured output

  * Build schema-driven pipelines instead of fragile regex or prompt hacks

## Things to explore next

#### Nested schemas

Add a `token-address` subrule with its own sub-tokens, and a nested class inside `Booking`. The `Actionable` role composes naturally.

#### Tool calling

Wire `extract-booking` as a tool in an `LLM::Functions` agent so the LLM can invoke it mid-conversation.

#### Streaming structured output

Parse incrementally as the LLM streams tokens — useful when the DSL is long.

#### Retries on validation failure

Catch a failed parse, feed the raw LLM output back with an error message, and ask it to correct the DSL. Usually one retry is enough.

#### Integration with agent workflows

Use the structured `Booking` / `Ticket` objects as typed messages passed between agents in a multi-step pipeline.

#### The Slangify Playground

Paste any Grammar + Actions pair into [https://slangify.org](https://slangify.org) to test and share your DSL interactively — no local install needed.

## Further reading

#### This tutorial

  * [Slangify::Tutorial source code](https://github.com/librasteve/Slangify-Tutorial)

  * [Slangify Website Examples](https://slangify.org/examples)

  * [Grammar Editor](https://play.slangify.org)

#### Raku docs

  * [Raku Grammar tutorial](https://docs.raku.org/language/grammars)

  * [Raku Regexes](https://docs.raku.org/language/regexes)

  * [Raku Pod6](https://docs.raku.org/language/pod)

#### Key modules

  * [LLM::Functions on raku.land](https://raku.land/zef:antononcube/LLM::Functions)

  * [Actionable on raku.land](https://raku.land/zef:librasteve/Actionable)

  * [JSON::Fast on raku.land](https://raku.land/zef:timo/JSON::Fast)


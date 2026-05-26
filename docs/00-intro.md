[← Index](../index.md)

# 00. Slangify::Tutorial

**Using DSLs with LLMs: From Prompt to Structured Output**

Suppose you want an LLM to extract structured information from messy text — but you don't want to hand-write JSON schemas or fragile parsing logic.

Input:

    Jane booked a table for 4 at 7:30pm tomorrow at Bistro Verde

Desired output:

```json
{
  "name": "Jane",
  "party_size": 4,
  "time": "7:30 PM",
  "restaurant": "Bistro Verde",
  "date": "tomorrow"
}
```

Slangify lets you define that structure with a DSL, then use an LLM to populate it reliably. This tutorial walks through everything from a first schema to a real-world pipeline.

## What you will learn

  * Understand what Slangify does

  * Define a simple DSL schema using a Raku Grammar

  * Connect it to an LLM via `LLM::Functions`

  * Generate structured outputs from prompts

  * Validate and post-process results

  * See how this fits into a real workflow

## Chapters

  * [01. Setup](01-setup.md)

  * [02. Your First Schema](02-schema.md)

  * [03. Connecting to an LLM](03-llm.md)

  * [04. The Generated Output](04-output.md)

  * [05. Iteration](05-iteration.md)

  * [06. Validation and Constraints](06-validation.md)

  * [07. Prompt Engineering Patterns](07-patterns.md)

  * [08. A Real-World Example](08-real-world.md)

  * [09. Common Pitfalls](09-pitfalls.md)

  * [10. Next Steps](10-next-steps.md)

## More Info

Visit [https://slangify.org](https://slangify.org) for more information, examples and guidance.

Please ping the [https://raku.org/community](https://raku.org/community)


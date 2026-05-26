[← Index](../index.md)

# Slangify::Tutorial

**Using Slangify with LLMs: From Prompt to Structured Output**

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

  * [1. Setup](01-setup.md)

  * [2. Your First Schema](02-schema.md)

  * [3. Connecting to an LLM](03-llm.md)

  * [4. The Generated Output](04-output.md)

  * [5. Validation and Constraints](05-validation.md)

  * [6. Prompt Engineering Patterns](06-patterns.md)

  * [7. A Real-World Example](07-real-world.md)

  * [8. Common Pitfalls](08-pitfalls.md)

  * [9. Next Steps](09-next-steps.md)


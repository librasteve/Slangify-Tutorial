[← Index](../index.md)

# 07. Prompt Engineering Patterns

Four practical patterns for combining Slangify grammars with LLMs.

## a) Extraction

Convert free text into structured data. This is the core use case.

Prompt instruction:

    Convert the following booking request into DSL format.
    Output only the DSL line.

Result: the LLM strips noise and maps fields — you parse the DSL.

## b) Generation

Ask the LLM to *create* content that already conforms to your schema.

Example — generate a support-ticket summary in DSL form:

    Write a support ticket for a user who cannot log in.
    Use this format: customer_name "..." issue_type "..." priority low|medium|high summary "..."

The grammar then validates that the generated text is well-formed before it touches your database.

## c) Transformation

Convert one structure into another.

Example: turn a raw email into a CRM record.

    Given this customer email, produce a CRM record in DSL format:
      contact_name "..." company "..." intent "..." follow_up_date YYYY-MM-DD

The LLM handles the semantic mapping; the grammar enforces the output contract.

## d) Classification

Use an `enum` token to constrain the LLM to a fixed vocabulary.

Grammar:

```raku
token priority { 'low' | 'medium' | 'high' }
```

Prompt instruction:

    Classify the urgency of this support request as low, medium, or high.
    Output only: priority <value>

If the LLM outputs `priority urgent`, the grammar rejects it. Retry logic or a stricter prompt resolves the mismatch.

## Choosing a pattern

<table class="pod-table">
<tbody>
<tr> <td>Pattern</td> <td>When to use</td> </tr> <tr> <td>Extraction</td> <td>Unstructured input → known schema</td> </tr> <tr> <td>Generation</td> <td>LLM creates content, schema validates it</td> </tr> <tr> <td>Transformation</td> <td>Structured input → different structured output</td> </tr> <tr> <td>Classification</td> <td>Categorical output from a closed vocabulary</td> </tr>
</tbody>
</table>


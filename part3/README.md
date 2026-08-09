# Part 3 — GenAI Text Analytics with Groq

## Overview

Part 3 applies a Groq-hosted large language model to customer clothing reviews from the Women's Clothing E-Commerce Reviews dataset.

The notebook demonstrates prompt engineering, reusable API calls, retry handling, structured JSON validation, aspect extraction, response drafting, multi-turn context, and API-key security.

## Dataset

- File: `Womens Clothing E-Commerce Reviews.csv`
- Rows: 23,486
- Columns: 11
- Main text field: `Review Text`

Example review:

> Absolutely wonderful - silky and sexy and comfortable

## Tasks Completed

### Task 1 — Three Prompt Templates

Three sentiment-classification prompt styles were created:

- **A — Zero-shot**
- **B — Few-shot**
- **C — Role-prompted**

Each template requests the same JSON structure:

```json
{
  "label": "positive|negative|neutral",
  "confidence": "low|medium|high",
  "reason": "string"
}
```

The templates were designed to keep the output structured and easy to validate.

### Task 2 — Reusable Groq API Wrapper

A reusable `call_llm()` function was created to send prompts to the Groq API.

The wrapper accepts:

- `prompt`
- `temperature`
- `max_tokens`

The API call was successfully tested using a clothing review.

### Task 3 — Retry-on-Failure Handling

Retry logic was implemented so temporary API failures can be retried instead of immediately stopping the workflow.

The completed test successfully returned a valid response.

### Task 4 — Prompt Comparison

Five reviews were evaluated with each of the three prompt templates.

Total API calls:

- A — Zero-shot: 5
- B — Few-shot: 5
- C — Role-prompted: 5
- **Total: 15**

All three templates achieved:

- JSON success rate: **100%**
- Schema success rate: **100%**

Therefore, no single template outperformed the others on this small validation sample in terms of JSON/schema compliance.

The most consistently schema-conformant result was reported as a tie across the three templates.

### Task 5 — Aspect Extraction

The model extracted sentiment for the following clothing-review aspects:

- quality
- comfort
- fit
- appearance
- material
- sizing

Five reviews were processed.

Results:

- JSON responses: **5/5**
- Schema-valid responses: **5/5**

The output used `not_mentioned` when an aspect was not discussed in the review.

### Task 6 — Response Drafting

The model generated customer-service responses based on the review sentiment.

Five reviews were processed.

Results:

- JSON responses: **5/5**
- Schema-valid responses: **5/5**

Positive reviews received appreciative responses, while negative feedback received an appropriate acknowledgement.

### Task 7 — Multi-turn Context

A two-turn conversation was demonstrated.

Turn 1 summarized the customer's review and extracted important details.

Turn 2 asked a follow-up question referring to the previous review.

The model successfully used the previous context to answer the follow-up.

Validation:

- Turn 1 valid: **True**
- Turn 2 valid: **True**
- Multi-turn context successfully demonstrated.

### Task 8 — API-Key Security

The API key is loaded from a `.env` file rather than being hardcoded in the notebook.

The notebook checks that the key exists without displaying its value.

The `.env` file is excluded from Git using `.gitignore`.

The required environment variable is:

```text
GROQ_API_KEY
```

**Never commit `.env` or the actual Groq API key to GitHub.**

## Requirements

The pinned dependencies are listed in `requirements.txt`.

Install them with:

```bash
pip install -r requirements.txt
```

## Environment Setup

Create a `.env` file locally containing:

```text
GROQ_API_KEY=your_groq_api_key_here
```

Do not commit this file to GitHub.

The notebook loads the key using `python-dotenv` and reads the `GROQ_API_KEY` environment variable.

## How to Run

1. Install the required dependencies:

```bash
pip install -r requirements.txt
```

2. Place `Womens Clothing E-Commerce Reviews.csv` in the working directory.

3. Create the `.env` file with your Groq API key.

4. Open:

```text
part3.ipynb
```

5. Run the notebook from top to bottom.

The notebook uses the `Review Text` column from the dataset.

## Security

Secrets are intentionally kept outside the notebook.

The repository must not contain:

- API keys
- passwords
- `.env` files
- other credentials

The included `.gitignore` prevents `.env` and common temporary Python/Jupyter files from being tracked.

## Files

```text
part3/
├── part3.ipynb
├── README.md
├── requirements.txt
├── .gitignore
└── Womens Clothing E-Commerce Reviews.csv
```

## Submission

Part 3 is a code submission. Submit **one public GitHub repository link** for this Part.

The repository must be publicly accessible without requiring a GitHub account.

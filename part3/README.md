# Part 3 – GenAI-Powered Text Analytics: Prompt Engineering & LLM API Integration

## Project Overview

This project automates sentiment analysis of customer clothing reviews using a large 
language model. Three prompting strategies were designed and compared, wired to a real 
LLM API with retry-on-failure handling, then extended into an aspect-based sentiment 
pipeline that also auto-drafts personalized customer service replies.

---

# Dataset

**Source:** Women's E-Commerce Clothing Reviews (Kaggle)
**Field used:** `Review Text`

---

# Tools Used

- Google Colab
- Python
- Groq API (llama-3.3-70b-versatile)
- json (standard library)

---

# API Provider Note

Google Gemini was originally attempted per the assignment's cost note, but its free-tier 
API access consistently returned `429 RESOURCE_EXHAUSTED` errors with `limit: 0` across 
multiple fresh API keys and projects — a widely reported issue with Gemini's free tier. 
Groq was used instead, offering a comparable free-tier LLM API (Llama 3.3 70B) with no 
billing required.

---

# Task 1 – Prompt Template Design

Three prompt templates were created for sentiment classification, each instructing the 
model to respond only in a locked JSON schema (`label`, `confidence`, `reason`):

- **Zero-shot** — instruction only, no worked examples.
- **Few-shot** — the same instruction plus 3 worked examples embedded in the prompt.
- **Role-prompted** — begins with a persona line ("Act as a senior customer-insights 
  analyst...") and applies the Three Cs framework (Clarity, Context, Constraint).

---

# Task 2 – Reusable API Wrapper

A `call_llm(prompt, temperature, max_tokens)` function was implemented using the Groq 
API. It loads the API key from an environment variable (via Colab Secrets), sends the 
prompt with the given parameters, and returns the model's text response.

---

# Task 3 – Retry-on-Failure Handling

The `call_llm()` function retries up to 3 times if a call fails (network error, rate 
limit, or non-200 response), logging a description of the failure before retrying, 
rather than crashing the run.

---

# Task 4 – 15-Call Template Comparison

All three templates were run on the same 5 real reviews (15 calls total). Each response 
was parsed as JSON.

**Result: 15/15 calls returned valid, schema-conformant JSON (100% success rate) across 
all three templates.** Since all three performed equally reliably, the role-prompted 
template was selected as the best-performing template going forward, since it provides 
the most context and is likely to generalize better to more ambiguous reviews.

---

# Task 5 – Aspect-Based Sentiment Extension

The role-prompted template was extended to return sentiment for two aspects — 
**product quality** and **fit** — plus a short actionable phrase per aspect, across 
10 real records.

| Record | Review Snippet | Product Quality | Fit |
|---|---|---|---|
| 1 | "Absolutely wonderful - silky and sexy and comfortable" | positive – "Silky and sexy" | positive – "Very comfortable fit" |
| 2 | "Love this dress! it's sooo pretty..." | positive – "Love this dress" | positive – "Flattering length found" |
| 3 | "I had such high hopes for this dress and really wanted it to..." | negative – "cheap materials used" | negative – "runs very small" |
| 4 | "I love, love, love this jumpsuit. it's fun, flirty, and fabu..." | positive – "Great material used" | positive – "Flattering fit found" |
| 5 | "This shirt is very flattering to all due to the adjustable f..." | positive – "High quality fabric" | positive – "Flattering adjustable design" |
| 6 | "I love tracy reese dresses, but this one is not for the very..." | positive – "High quality fabric" | negative – "Not for petite frames" |
| 7 | "I added this in my basket at the last minute to see what it w..." | positive – "Gorgeous color matches" | negative – "Little baggy fit" |
| 8 | "I ordered this in carbon for store pick up, and had a ton of..." | positive – "Nice color quality" | negative – "Runs a bit big" |
| 9 | "I love this dress. i usually get an xs but it runs a little..." | positive – "High quality fabric" | negative – "Runs a bit snug" |
| 10 | "I'm 5'5\" and 125 lbs. i ordered the s petite to make sure th..." | positive – "High quality fabric" | positive – "Fits perfectly snug" |

---

# Task 6 – Chained Response-Drafting

The structured output from Task 5 was fed into a second prompt that drafted a short, 
professional, empathetic reply addressing the specific points raised in each review 
(not a generic template reply).

**Example 1** (positive quality + fit):
> "We're thrilled to hear that you're enjoying the silky texture and sexy style of our 
> garment, as we take great care in selecting high-quality materials that exude 
> confidence and sophistication."

**Example 2** (positive overall, despite sizing hesitation):
> "We're thrilled to hear that you fell in love with our dress and found a flattering 
> fit, despite initially being hesitant due to the petite sizing. It's great that the 
> length worked well for you..."

**Example 3** (negative fit/quality):
> "I'm so sorry to hear that the dress didn't meet your expectations, particularly with 
> the sizing running very small and the discomfort caused by the tight under layer and 
> net over layers. We understand that..."

---

# Task 7 – Multi-Turn Context Demonstration

A 2-turn conversation was run where turn 2 correctly reused sentiment information from 
turn 1 without the user repeating it.

- **Turn 1:** Asked for the sentiment of a jumpsuit review. Model correctly identified 
  it as "extremely positive," noting the repeated use of the word "love."
- **Turn 2:** Asked for a marketing tagline "based on that sentiment" — without 
  restating what the sentiment was. Model correctly generated a tagline consistent with 
  the positive sentiment established in turn 1, confirming context was carried across 
  turns.

The full conversation history object (list of role/content messages) was printed in the 
notebook as evidence.

---

# Task 8 – API Key Security

The API key is stored using Colab's Secrets manager (accessed via 
`google.colab.userdata`), which serves the same purpose as a local `.env` file — 
keeping the key out of the notebook's visible code and out of GitHub. 

**Required environment variable name:** `GROQ_API_KEY`

To run this project, a grader would need to supply their own free Groq API key 
(https://console.groq.com/keys) as a Colab secret named `GROQ_API_KEY`.

---

# Files Included


---

# How to Run

1. Open `part3_genai.ipynb` in Google Colab.
2. Add your Groq API key as a Colab secret named `GROQ_API_KEY`.
3. Upload the Women's E-Commerce Clothing Reviews CSV when prompted.
4. Run all notebook cells from top to bottom.

---

# Conclusion

This project demonstrates a complete GenAI text-analytics workflow — from prompt 
template design and comparison, through secure API integration with retry handling, 
to aspect-based sentiment extraction, chained response drafting, and multi-turn 
conversational context. All three prompting strategies proved reliable, with the 
role-prompted template selected for further extension due to its richer context.
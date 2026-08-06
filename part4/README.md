# Part 4 – Agentic AI System: Tool-Using Crew (CrewAI, Option B)

## Project Overview

This project builds a multi-agent crew using CrewAI, where two agents collaborate to 
fetch real content (a joke and a piece of life advice) from live external APIs and 
turn it into a warm message. The crew was run using both a sequential process and a 
hierarchical process, and delegation between agents was demonstrated.

---

# Why Option B (CrewAI)

CrewAI was chosen to demonstrate multi-agent collaboration — assigning distinct roles 
to different agents, passing outputs between tasks, and comparing sequential vs. 
manager-led task execution.

---

# Tools Used

- Google Colab
- Python
- CrewAI, crewai-tools
- Groq API (llama-3.3-70b-versatile), via LiteLLM
- requests

---

# API Provider Note

Google Gemini was originally considered per the assignment's cost note, but its 
free-tier API access consistently returned quota errors across multiple fresh keys. 
Groq was used instead (same as Part 3), offering a comparable free-tier LLM API.

---

# Task – Tools (Common Requirement 1 & 2)

| Tool Name | Description | Type |
|---|---|---|
| Get Random Joke | Fetches a random joke from the Official Joke API | Read |
| Get Life Advice | Fetches a random piece of life advice from the Advice Slip API | Read |

Both tools are read-only.

---

# Task – Logged Tool Decisions (Common Requirement 3)

Every tool call is captured by CrewAI's native execution log, e.g.:

---

# Task – Three Distinct Queries (Common Requirement 4)

1. **"Fetch a joke and advice, combine into a message"** — used both tools and both 
   agents. Result: a warm message combining an orange joke with advice about growing up.
2. **"Get me a joke to brighten my day"** — used only the joke tool and the Fetcher 
   agent. Result: "I hope that joke brightened your day!"
3. **"I'm feeling stuck in life, give me advice"** — used the advice tool. Result: 
   "Work is never as important as you think it is."

---

# Task 1 – Agents

- **Content Fetcher** — fetches content using tools; cheerful, always uses real data.
- **Message Writer** — turns content into a polished message; `allow_delegation=True`.

---

# Task 2 – Tasks with a Handoff

`fetch_task` (Content Fetcher) feeds its output into `write_task` (Message Writer) via 
`context=[fetch_task]`.

---

# Task 3 – Sequential vs. Hierarchical

**Sequential:** each task went to its assigned agent as expected.

**Hierarchical:** an automatic Crew Manager agent took charge — it executed the fetch 
task itself instead of assigning it to the Content Fetcher, then delegated the write 
task to the Message Writer. This is the key difference: hierarchical mode lets the 
manager choose to do a task itself, while sequential mode always follows the fixed 
assignment.

---

# Task 4 – Delegation

`allow_delegation=True` was set on the Message Writer. During the sequential run, it 
used `delegate_work_to_coworker` to ask the Content Fetcher for a combined draft — a 
real, captured delegation event visible in the notebook output.

---

# API Key Security

Stored using Colab's Secrets manager. **Required environment variable:** `GROQ_API_KEY`

---

# Files Included

---

# How to Run

1. Open `part4_agent.ipynb` in Google Colab.
2. Add your Groq API key as a Colab secret named `GROQ_API_KEY`.
3. Run all notebook cells from top to bottom.

---

# Conclusion

This project demonstrates a working multi-agent CrewAI system — two agents with 
distinct roles, a task handoff, live API tool use, logged tool calls, real delegation, 
and a comparison between sequential and hierarchical execution across three queries.
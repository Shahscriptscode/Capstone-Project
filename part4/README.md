# Part 4 — Agentic AI with CrewAI

## Overview

This Part 4 project demonstrates an agentic AI workflow using CrewAI and a Groq-powered LLM.

The project includes:
- CrewAI agents
- CrewAI tasks
- Tool usage
- Native CrewAI tool-call event logging
- Sequential agent execution
- Multi-agent collaboration
- Groq/LiteLLM integration

The notebook is designed to run from top to bottom in Google Colab.

## Files

```text
part4/
├── part4_agent.ipynb
├── README.md
├── requirements.txt
└── .gitignore
```

## Requirements

Tested versions:

- pandas 2.2.2
- crewai 1.15.14
- litellm 1.96.0
- requests 2.34.2

Install dependencies:

```bash
pip install -r requirements.txt
```

## API Key Setup

The project uses a Groq API key.

Do not write the API key directly in the notebook or commit it to GitHub.

For Google Colab, store the key in Colab Secrets using:

```text
GROQ_API_KEY
```

Grant the notebook access to the secret when Colab asks for permission.

The actual API key is never printed in the notebook output.

## How to Run

1. Open `part4_agent.ipynb` in Google Colab.
2. Install dependencies if required:
   ```bash
   pip install -r requirements.txt
   ```
3. Add `GROQ_API_KEY` to Google Colab Secrets.
4. Grant notebook access to the secret.
5. Run the notebook from the first cell to the last cell.

The notebook was tested after restarting the Colab session and running all cells from top to bottom.

## Agent Workflow

The project uses multiple CrewAI agents and tasks. The agents work together to perform the required workflow, with tasks assigned according to their roles.

## Native Tool-Call Logging

The project uses CrewAI's native event system to capture tool usage.

The implementation uses:

```python
from crewai.events import BaseEventListener
```

The logger captures structured information about tool calls, including:
- Tool name
- Parsed tool arguments
- Tool completion
- Tool errors when applicable

This provides structured evidence of actual tool usage rather than relying only on the agent's final text response.

## Security

No API keys, passwords, or other secrets are included in this repository.

The Groq API key is loaded from Google Colab Secrets using:

```text
GROQ_API_KEY
```

The `.gitignore` file prevents local environment and secret files from being committed.

## Design Decisions

### CrewAI
CrewAI was used to implement the multi-agent workflow and task orchestration.

### Groq / LiteLLM
The Groq-powered LLM is accessed through the configured CrewAI/LiteLLM integration.

### Native event logging
CrewAI's native event system was used for tool-call logging so that tool calls can be inspected from framework-generated events.

### Sequential execution
A sequential workflow is used where tasks are executed in the required order and information can flow from one task to the next.

## Validation

The notebook was tested after restarting the Google Colab runtime.

All notebook cells executed successfully from top to bottom.

Verified components:
- API key access
- LLM initialization
- Tool initialization
- Native CrewAI event listener
- Agent creation
- Task creation
- Crew execution
- Tool usage
- Final agent output

## Reproducibility

Exact dependency versions are pinned in `requirements.txt`.

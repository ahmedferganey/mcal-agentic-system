# AI MCAL Multi-Agent System

## 🚀 Overview

AI MCAL Agent is a production-grade multi-agent system designed to automate and accelerate **AUTOSAR MCAL (Microcontroller Abstraction Layer)** development.

The system leverages LLM-powered agents to:

* Parse microcontroller datasheets
* Generate MCAL-compliant driver code
* Validate against MISRA & AUTOSAR rules
* Debug low-level hardware issues

This project bridges **embedded systems engineering** and **AI agent orchestration**, enabling intelligent, data-driven development workflows.

---

## 🧠 System Architecture

The system follows a **multi-agent architecture** where each agent has a specialized responsibility:

* **Planner Agent** → Decides workflow
* **Datasheet Agent** → Extracts hardware knowledge
* **Codegen Agent** → Generates MCAL drivers
* **Validation Agent** → Ensures compliance
* **Debug Agent** → Diagnoses issues

All agents are orchestrated via a graph-based execution engine.

---

## ⚙️ Tech Stack

* Python
* FastAPI (API serving)
* LangGraph (multi-agent orchestration)
* LangChain (LLM abstraction)
* Vector DB (Qdrant / FAISS)
* Docker + Kubernetes (deployment)

---

## 📂 Project Structure

```
ai-mcal-agent/
```

### 1. apps/

**Purpose:** Entry points for interacting with the system

* `api/` → Production FastAPI service
* `cli/` → Local command-line interface
* `playground/` → Experimental notebooks / UI

---

### 2. agents/

**Purpose:** Core intelligence of the system (modular agents)

#### datasheet_agent/

* Extracts structured data from PDFs
* Converts raw datasheets → register maps

#### codegen_agent/

* Generates MCAL drivers
* Uses templates + retrieved context

#### validation_agent/

* Enforces:

  * MISRA C rules
  * AUTOSAR compliance

#### debug_agent/

* Analyzes:

  * Register dumps
  * Timing issues

#### planner_agent/

* Decides execution flow
* Routes tasks between agents

---

### 3. orchestration/

**Purpose:** Multi-agent coordination layer

* `graph.py` → Defines workflow graph
* `state.py` → Shared state across agents
* `router.py` → Decision logic
* `executor.py` → Runs pipelines

---

### 4. tools/

**Purpose:** Shared utilities used by all agents

#### rag/

* Retrieval system for datasheets
* Embeddings + vector search

#### code_tools/

* C parsing
* Formatting
* Static analysis

#### hardware/

* Register abstractions
* Peripheral models

#### utils/

* Logging
* Configuration management

---

### 5. knowledge/

**Purpose:** Domain knowledge base (RAG input)

* `datasheets/` → MCU reference manuals
* `autosar/` → MCAL specifications
* `examples/` → Reference drivers

---

### 6. memory/

**Purpose:** Agent memory (optional)

* `short_term/` → Session context
* `long_term/` → Persistent knowledge

---

### 7. evaluation/

**Purpose:** System benchmarking & validation (critical)

#### benchmarks/

* Test scenarios (ADC, SPI, etc.)

#### metrics/

* correctness
* latency
* hallucination detection

#### runner.py

* Executes evaluation pipelines

---

### 8. configs/

**Purpose:** Central configuration

* `agents.yaml` → Agent definitions
* `models.yaml` → LLM configs
* `rag.yaml` → Retrieval settings

---

### 9. tests/

**Purpose:** Quality assurance

* Unit tests
* Integration tests

---

### 10. observability/

**Purpose:** Monitoring & tracing

* Execution traces
* Debug callbacks

---

### 11. deployments/

**Purpose:** Infrastructure setup

* Docker configs
* Kubernetes manifests

---

### 12. scripts/

**Purpose:** Utility scripts

* Datasheet ingestion
* Index building

---

## 🔄 Workflow Example

1. User request: "Initialize ADC"
2. Planner Agent selects workflow
3. Datasheet Agent retrieves register info
4. Codegen Agent generates driver
5. Validation Agent checks compliance
6. Debug Agent (optional) analyzes issues
7. Final output returned

---

## 📊 Evaluation Strategy

The system includes a built-in evaluation framework:

* Benchmark tasks (ADC, SPI, UART)
* Metrics:

  * Register correctness
  * Code quality
  * Latency
  * Hallucination rate

---

## 🧪 Running the Project

### Install

```bash
pip install -r requirements.txt
```

### Run API

```bash
uvicorn apps.api.main:app --reload
```

### Run CLI

```bash
python apps/cli/main.py
```

---

## 🧱 Design Principles

* Modular agents (plug & play)
* Separation of concerns
* Retrieval-first reasoning (RAG)
* Deterministic + explainable outputs

---

## 🚀 Future Enhancements

* Hardware-in-the-loop validation
* AUTOSAR toolchain integration
* Real-time debugging agents
* CI/CD evaluation pipelines

---

## 💡 Key Value Proposition

This project enables:

* Faster MCAL development
* Reduced human error in register config
* Scalable embedded engineering workflows
* AI-assisted safety-critical software development

---

## 📌 Conclusion

AI MCAL Agent represents a next-generation approach to embedded systems development by combining:

* Low-level hardware expertise
* AI multi-agent systems
* Production-grade backend architecture

This makes it a **high-impact, rare, and technically deep project** suitable for top-tier engineering roles.


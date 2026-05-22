# 🚀 AI-Powered MCAL Agentic System
### Small LLM Fine-Tuning + Agentic Architecture for AUTOSAR Timer Driver Development

---

## 📌 Overview

This project builds a **production-grade AI system** for generating **AUTOSAR MCAL Timer (GPT) driver code** using **small, optimized LLMs (200–500 MB)**.

**🎯 Focus Module:** Timer/GPT (General Purpose Timer)

The system is designed for:
* Embedded constraints (low memory, CPU-only inference)
* Deterministic and compilable C code
* AUTOSAR-compliant Timer driver outputs
* Agent-based decomposition for reliability
* Single-module mastery before scaling

### Why Timer Module?

* ✅ **Well-defined scope:** initialization, configuration, start/stop, notification
* ✅ **Clear register mappings:** prescaler, reload, control registers
* ✅ **Measurable success criteria:** compilable code, correct timing calculations
* ✅ **Foundation pattern:** applicable to other time-critical modules (PWM, WDG)
* ✅ **Manageable complexity:** ideal for validating small LLM capabilities

---

## 🧭 Project Phases

The system is developed in **two major phases**:

---

# 🧪 Phase 1: Experimental (Colab-Based Research)

This phase focuses on **rapid experimentation, iteration, and validation** using notebooks.

### 📂 Structure

```
experimental/
├── colab-agents/        # Agent workflows for Timer generation
├── colab-finetuning/    # QLoRA / LoRA training notebooks
└── README.md
```

---

## 🔬 Objectives

* Validate small LLM capability for **Timer MCAL generation**
* Experiment with prompt engineering for Timer-specific tasks
* Build initial agent pipelines focused on Timer workflow
* Fine-tune models using Timer driver datasets
* Evaluate generation quality on Timer code

---

## 🧠 Experimental Components

### 1. Colab Finetuning

**Focus:** Train model on Timer-specific datasets

Implements:
* Timer driver dataset preparation (STM32, NXP, Infineon)
* Instruction tuning (Timer task → Timer code)
* QLoRA training pipeline

**Dataset Examples:**
```
[INPUT]
Generate Timer initialization for STM32 with 1ms period, prescaler 84

[OUTPUT]
void Gpt_Init(const Gpt_ConfigType* ConfigPtr) {
    TIM2->PSC = 84 - 1;
    TIM2->ARR = 1000 - 1;
    TIM2->CR1 |= TIM_CR1_CEN;
}
```

#### Output:
* LoRA adapters for Timer generation
* Evaluation metrics on Timer code quality

---

### 2. Colab Agents

**Focus:** Timer-specific agent system

Implements:
* **Planner** → breaks Timer tasks (init, start, stop, get elapsed time)
* **Generator** → produces Timer driver code
* **Validator** → checks Timer register correctness

**Example Tasks:**
* "Initialize Timer with 10ms period"
* "Configure Timer for interrupt notification"
* "Calculate prescaler for given frequency"

---

## ⚙️ Experimental Workflow

1. Prepare Timer driver dataset (AUTOSAR + vendor SDKs)
2. Train model using QLoRA on Timer examples
3. Run Timer agent pipeline inside notebook
4. Evaluate Timer code outputs
5. Iterate on Timer-specific prompts

---

## 📊 Experimental Metrics

* ✅ **Compilation success rate** (Timer code compiles)
* ✅ **Register correctness** (valid Timer registers)
* ✅ **Timing calculation accuracy** (prescaler, period)
* ✅ **Hallucination rate** (invalid Timer peripherals)
* ✅ **Token efficiency** (concise Timer code)

---

# 🏭 Phase 2: Production System

## 🚀 Overview

AI MCAL Agent is a production-grade multi-agent system designed to automate and accelerate **AUTOSAR Timer MCAL development**.

The system leverages LLM-powered agents to:
* Parse Timer peripheral datasheets
* Generate Timer MCAL-compliant driver code
* Validate against MISRA & AUTOSAR Timer specifications
* Debug Timer configuration issues

This project bridges **embedded systems engineering** and **AI agent orchestration**, focusing on **mastering Timer generation** before expanding.

---

## 🧠 System Architecture

The system follows a **multi-agent architecture** specialized for Timer development:

* **Planner Agent** → Decides Timer workflow (init, start, stop, notify)
* **Datasheet Agent** → Extracts Timer hardware knowledge (registers, modes)
* **Codegen Agent** → Generates Timer MCAL drivers
* **Validation Agent** → Ensures Timer AUTOSAR/MISRA compliance
* **Debug Agent** → Diagnoses Timer timing and configuration issues

All agents are orchestrated via a graph-based execution engine.

---

## ⚙️ Tech Stack

* **Python** - Core language
* **FastAPI** - API serving
* **LangGraph** - Multi-agent orchestration
* **LangChain** - LLM abstraction
* **Vector DB** (Qdrant / FAISS) - Timer datasheet embeddings
* **Docker + Kubernetes** - Deployment

---

## 📂 Project Structure

```
ai-mcal-agent/
├── agents
│   ├── codegen_agent
│   │   ├── agent.py
│   │   ├── prompts.py           # Timer-specific prompts
│   │   └── templates
│   │       └── timer_templates/  # Timer code templates
│   ├── datasheet_agent
│   │   ├── agent.py
│   │   ├── parser.py             # Timer register parser
│   │   └── prompts.py
│   ├── debug_agent
│   │   ├── agent.py
│   │   └── analyzers
│   │       ├── timer_timing_analysis.py
│   │       └── timer_register_analysis.py
│   ├── planner_agent
│   │   ├── agent.py
│   │   └── prompts.py            # Timer task planning
│   └── validation_agent
│       ├── agent.py
│       └── rules
│           ├── autosar_timer_rules.py
│           └── misra_rules.py
├── apps
│   ├── api
│   ├── cli
│   └── playground
├── configs
│   ├── agents.yaml
│   ├── models.yaml
│   └── rag.yaml
├── deployments
│   ├── docker
│   └── k8s
├── docs
│   ├── plan.md
│   └── setup.sh
├── evaluation
│   ├── benchmarks
│   │   └── timer_cases.json      # Timer-specific test cases
│   ├── metrics
│   │   ├── correctness.py        # Timer register validation
│   │   ├── timing_accuracy.py    # Prescaler/period checks
│   │   └── latency.py
│   └── runner.py
├── experimental
│   ├── colab-agents
│   ├── colab-finetuning
│   └── README.md
├── knowledge
│   ├── autosar
│   │   ├── guidelines
│   │   └── mcal_specs
│   │       └── timer_gpt_spec/   # Timer AUTOSAR specs
│   ├── datasheets
│   │   ├── infineon
│   │   │   └── timer_registers/
│   │   ├── nxp
│   │   │   └── timer_registers/
│   │   └── stm32
│   │       └── timer_registers/
│   └── examples
│       ├── configs
│       │   └── timer_configs/
│       └── drivers
│           └── timer_drivers/
├── memory
│   ├── long_term
│   └── short_term
├── observability
│   ├── callbacks.py
│   └── tracing.py
├── orchestration
│   ├── executor.py
│   ├── graph.py
│   ├── router.py
│   └── state.py
├── scripts
│   ├── build_index.py
│   └── ingest_timer_datasheets.py
├── tests
│   ├── agents
│   │   └── test_timer_codegen.py
│   ├── orchestration
│   └── tools
│       └── test_timer_validation.py
└── tools
    ├── code_tools
    │   ├── c_parser.py
    │   ├── formatter.py
    │   └── static_analysis.py
    ├── hardware
    │   ├── timer_models.py        # Timer peripheral models
    │   └── timer_register_map.py
    ├── rag
    │   ├── embeddings.py
    │   ├── retriever.py
    │   └── vectorstore.py
    └── utils
        ├── config.py
        └── logging.py
```

---

## 🔄 Timer-Focused Workflow Example

1. **User request:** "Initialize Timer2 with 1ms period on STM32F4"
2. **Planner Agent** identifies Timer initialization task
3. **Datasheet Agent** retrieves Timer2 register info (TIMx->PSC, TIMx->ARR)
4. **Codegen Agent** generates Timer driver code
5. **Validation Agent** checks AUTOSAR Timer compliance
6. **Debug Agent** (if needed) analyzes timing calculations
7. **Final Timer code** returned to user

---

## 📊 Evaluation Strategy

The system includes a Timer-focused evaluation framework:

**Benchmark Tasks:**
* Timer initialization (various periods: 1ms, 10ms, 100ms)
* Timer start/stop operations
* Timer overflow interrupt configuration
* Timer notification callbacks
* Prescaler calculation accuracy

**Metrics:**
* ✅ Timer register correctness
* ✅ Timing calculation accuracy (frequency, period)
* ✅ Code quality (MISRA compliance)
* ✅ Latency (generation time)
* ✅ Hallucination rate (invalid Timer peripherals)

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
python apps/cli/main.py "Generate Timer initialization with 1ms period"
```

---

## 🧱 Design Principles

* **Single module mastery** → Perfect Timer before expanding
* **Modular agents** → Plug & play architecture
* **Separation of concerns** → Each agent has clear Timer responsibility
* **Retrieval-first reasoning** → RAG with Timer datasheets
* **Deterministic outputs** → Reliable Timer code generation

---

## 🚀 Future Enhancements (After Timer Mastery)

* Expand to PWM module (Timer-related)
* Add Watchdog (WDG) module
* Hardware-in-the-loop Timer validation
* AUTOSAR toolchain integration
* Real-time Timer debugging agents
* CI/CD evaluation pipelines

---

## 💡 Key Value Proposition

This project enables:
* ✅ Faster Timer MCAL development
* ✅ Reduced human error in Timer register configuration
* ✅ Scalable approach to embedded engineering
* ✅ AI-assisted Timer driver generation
* ✅ **Focused, measurable progress** on one module

---

## 🏁 Conclusion

AI MCAL Agent represents a next-generation approach to embedded systems development by:

* **Starting small:** Master Timer module first
* **Proving value:** Demonstrate small LLM effectiveness
* **Building foundation:** Establish patterns for other modules
* **Achieving reliability:** Production-grade Timer code generation

This makes it a **high-impact, focused, and technically deep project** with clear success criteria.

---

## 📌 Next Steps

1. ✅ Complete Timer dataset collection
2. ✅ Fine-tune model on Timer examples
3. ✅ Build Timer-specific agent workflows
4. ✅ Validate Timer code generation quality
5. ⏳ Achieve >90% Timer compilation success
6. ⏳ Expand to next module (PWM)

# 🧪 Experimental Phase — AI MCAL Timer Agent

## 🚀 Overview

This directory contains the **experimental and research phase** of the AI MCAL Agent system, specifically focused on **Timer/GPT (General Purpose Timer) driver generation**.

### Goals of This Phase:

* Rapidly prototype Timer generation workflows using notebooks
* Validate small LLM capability (200MB–500MB) for **Timer code generation**
* Experiment with Timer-specific fine-tuning strategies (QLoRA / LoRA)
* Build early-stage Timer agent workflows
* Evaluate feasibility of Timer generation before productionization

**Focus:** Single module (Timer) mastery before scaling to other modules.

This phase prioritizes **speed, iteration, and learning**, not production stability.

---

## 📂 Structure

```
experimental/
├── colab-agents/        # Timer agent workflow prototypes
│   ├── timer_planner_agent.ipynb
│   ├── timer_generator_agent.ipynb
│   └── timer_validator_agent.ipynb
├── colab-finetuning/    # Timer LLM fine-tuning experiments
│   ├── timer_dataset_prep.ipynb
│   ├── timer_qlora_training.ipynb
│   └── timer_evaluation.ipynb
└── README.md
```

---

## 🎯 Objectives

### 1. Validate Small LLM Performance on Timer Tasks

* Test models under strict size constraints (200–500MB)
* Evaluate Timer code generation quality
* Measure latency on CPU environments
* Assess Timer register correctness

**Success Criteria:**
* ✅ Generate compilable Timer initialization code
* ✅ Correct prescaler/period calculations
* ✅ Valid Timer register usage
* ✅ < 2s generation time per Timer function

---

### 2. Fine-Tuning Research for Timer Domain

**Dataset Focus:** Timer-specific examples
* Timer initialization patterns
* Timer start/stop operations
* Timer interrupt configuration
* Timer notification handlers
* Prescaler/period calculations

**Compare:**
* LoRA vs QLoRA efficiency
* Different base models (Phi-2, CodeLlama-small, etc.)
* Instruction formats for Timer tasks

**Example Training Pairs:**

```python
[
  {
    "input": "Generate Timer initialization for STM32F4 with 1ms period at 84MHz",
    "output": """
void Gpt_Init(const Gpt_ConfigType* ConfigPtr) {
    /* Enable Timer2 clock */
    RCC->APB1ENR |= RCC_APB1ENR_TIM2EN;
    
    /* Configure prescaler for 1MHz (84MHz / 84) */
    TIM2->PSC = 84 - 1;
    
    /* Configure auto-reload for 1ms period (1000 counts) */
    TIM2->ARR = 1000 - 1;
    
    /* Enable Timer */
    TIM2->CR1 |= TIM_CR1_CEN;
}
"""
  },
  {
    "input": "Generate Timer start function for continuous mode",
    "output": """
void Gpt_StartTimer(Gpt_ChannelType Channel, Gpt_ValueType Value) {
    TIMx->ARR = Value;
    TIMx->CR1 |= TIM_CR1_CEN;
}
"""
  }
]
```

---

### 3. Agent Prototyping (Timer-Specific)

Build minimal versions of Timer agents:

#### **Planner Agent**
* Decomposes Timer tasks:
  * Init → Configure registers → Enable Timer
  * Start → Set reload value → Enable counter
  * Stop → Disable counter → Clear flags

#### **Generator Agent**
* Produces Timer driver code
* Uses Timer-specific templates
* Handles vendor variations (STM32 vs NXP vs Infineon)

#### **Validator Agent**
* Checks Timer register validity
* Verifies timing calculations
* Ensures AUTOSAR Timer API compliance

**Example Flow:**

```
Input: "Initialize Timer with 10ms period"
    ↓
Planner: [Calculate prescaler, Set ARR, Enable Timer]
    ↓
Generator: Produces Timer init code
    ↓
Validator: Checks register values & timing math
    ↓
Output: Validated Timer code
```

---

### 4. Prompt Engineering (Timer Domain)

**Timer-Specific Prompts:**

```
System: You are an expert AUTOSAR Timer driver developer.

Task: Generate Timer initialization code
Context:
- MCU: {vendor} {model}
- System Clock: {freq}
- Timer Peripheral: {timer_name}
- Desired Period: {period}

Constraints:
- Use only valid Timer registers
- Calculate prescaler correctly
- Follow AUTOSAR naming conventions
- No hardcoded magic numbers

Output: C code only, no explanations
```

**Techniques:**
* Structured prompts (task + context + constraints)
* Few-shot examples with Timer patterns
* Reduce hallucination through register constraints
* Improve determinism with explicit output format

---

### 5. Evaluation Experiments

#### Core Metrics:

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Compilation Success** | >90% | GCC compile test |
| **Register Correctness** | >95% | Valid Timer registers only |
| **Timing Accuracy** | >95% | Prescaler/period calculation |
| **Hallucination Rate** | <5% | Invalid registers/peripherals |
| **Token Efficiency** | <500 tokens | Concise Timer code |
| **Generation Latency** | <2s | CPU inference time |

---

## 🧠 Experimental Components

### 🔹 1. Colab Finetuning (`colab-finetuning/`)

**Purpose:** Train and adapt small LLMs for Timer-specific code generation.

#### What to Implement:

**Notebook 1: `timer_dataset_prep.ipynb`**
* Collect Timer examples from:
  * STM32 HAL Timer drivers
  * NXP SDK Timer modules
  * Infineon AURIX Timer code
  * AUTOSAR Timer specifications
* Format as instruction pairs
* Split train/val/test sets

**Notebook 2: `timer_qlora_training.ipynb`**
* Load base model (Phi-2, CodeLlama-7B)
* Configure QLoRA adapters
* Train on Timer dataset
* Monitor loss and perplexity
* Save LoRA adapters

**Notebook 3: `timer_evaluation.ipynb`**
* Load fine-tuned model
* Generate Timer code for test cases
* Evaluate metrics
* Compare with base model

#### Dataset Size Targets:
* **Training:** 500-1000 Timer examples
* **Validation:** 100 examples
* **Test:** 50 examples

#### Output:
* LoRA / QLoRA adapters for Timer generation
* Training logs and loss curves
* Evaluation metrics report

---

### 🔹 2. Colab Agents (`colab-agents/`)

**Purpose:** Prototype Timer agent workflows before building full orchestration.

#### What to Implement:

**Notebook 1: `timer_planner_agent.ipynb`**
* Simple rule-based or prompt-based planner
* Task decomposition logic:
  * Init task → [Enable clock, Config registers, Enable Timer]
  * Start task → [Set reload, Enable counter]
  * Stop task → [Disable counter, Clear flags]

**Notebook 2: `timer_generator_agent.ipynb`**
* Load fine-tuned Timer model
* Generate Timer code from subtasks
* Use Timer-specific templates
* Handle vendor variations

**Notebook 3: `timer_validator_agent.ipynb`**
* Basic syntax validation (C parser)
* Timer register whitelist checking
* Timing calculation verification
* AUTOSAR API naming check

#### Example Flow:

```python
# Input
task = "Generate Timer initialization for STM32F4, 1ms period"

# Planner
subtasks = planner.decompose(task)
# Output: ["Calculate prescaler", "Set ARR register", "Enable Timer"]

# Generator
code = generator.generate(subtasks, context={"mcu": "STM32F4", "period": "1ms"})

# Validator
is_valid, errors = validator.validate(code)

# Output
if is_valid:
    print(code)
else:
    print(f"Validation errors: {errors}")
```

---

## ⚙️ Experimental Workflow

### Step-by-Step Process:

1. **Prepare Timer Dataset** (Week 1)
   * Collect 500+ Timer examples
   * Format as instruction pairs
   * Split datasets

2. **Run Fine-tuning** (Week 2)
   * Train QLoRA on Timer examples
   * Monitor convergence
   * Save best checkpoint

3. **Load Model in Agent Notebook** (Week 3)
   * Import fine-tuned model
   * Test on sample Timer tasks

4. **Execute Agent Pipeline** (Week 3-4)
   * Implement planner logic
   * Generate Timer code
   * Validate outputs

5. **Evaluate Outputs** (Week 4)
   * Measure metrics
   * Analyze failure cases
   * Identify improvement areas

6. **Iterate Rapidly** (Week 5+)
   * Refine prompts
   * Improve dataset
   * Optimize generation

---

## 📊 Metrics & Evaluation

### Core Metrics:

#### ✅ **Compilability**
* Does Timer code compile with GCC?
* Test command: `gcc -c timer_code.c`

#### ✅ **Register Correctness**
* Are Timer registers valid?
* Check against Timer register whitelist (TIMx->CR1, PSC, ARR, etc.)

#### ✅ **Timing Accuracy**
* Is prescaler calculation correct?
* Formula: `prescaler = (system_clock / desired_freq) - 1`
* Is period calculation correct?
* Formula: `ARR = (period_ms * timer_freq / 1000) - 1`

#### ✅ **Hallucination Rate**
* Percentage of invalid registers/peripherals
* Example hallucinations: TIM99, invalid register names

#### ✅ **Token Efficiency**
* Average tokens per Timer function
* Target: <500 tokens for init, <200 for start/stop

#### ✅ **Latency**
* CPU inference time
* Target: <2s per generation

---

### ⚠️ Limitations (Expected in This Phase)

* No strict MISRA validation (added in production)
* Limited Timer peripheral coverage (focus on common timers)
* Unstable outputs (expected during iteration)
* Manual evaluation for some edge cases
* No hardware-in-the-loop testing yet

---

## 🧱 Design Philosophy

### Principles for Experimental Phase:

* ⚡ **Fast iteration > perfect design**
* 🧪 **Experimentation > optimization**
* 🎯 **Simplicity over abstraction**
* 📊 **Measure everything**
* 🔄 **Fail fast, learn faster**

---

## 🔄 Transition to Production

### Once Timer experiments are validated:

**Outputs migrate to:**
* Structured agent modules (`agents/codegen_agent/`)
* Production orchestration layer (`orchestration/`)
* Scalable API services (`apps/api/`)
* Comprehensive test suite (`tests/agents/`)

**Migration Checklist:**
- [ ] Timer generation achieves >90% compilation success
- [ ] Timing accuracy >95%
- [ ] Hallucination rate <5%
- [ ] Latency <2s
- [ ] 100+ validated Timer test cases

---

## 🚀 Next Steps

### Immediate (Week 1-2):
* [ ] Collect Timer dataset from STM32, NXP, Infineon
* [ ] Create `timer_dataset_prep.ipynb`
* [ ] Format 500+ Timer instruction pairs

### Near-term (Week 3-4):
* [ ] Implement `timer_qlora_training.ipynb`
* [ ] Train on Timer dataset
* [ ] Implement Timer agent notebooks

### Medium-term (Week 5-8):
* [ ] Evaluate Timer generation quality
* [ ] Iterate on prompts and dataset
* [ ] Achieve >90% compilation success
* [ ] Document lessons learned

### Long-term (Week 9+):
* [ ] Transition to production architecture
* [ ] Expand to PWM module (Timer-related)
* [ ] Add hardware-in-the-loop validation

---

## 📚 Resources

### Timer Documentation:
* AUTOSAR Timer/GPT Specification
* STM32 Timer Reference Manual
* NXP Timer User Guide
* Infineon AURIX Timer Documentation

### Code Examples:
* `knowledge/examples/drivers/timer_drivers/`
* STM32Cube HAL Timer implementations
* AUTOSAR MCAL Timer reference implementations

### Evaluation Datasets:
* `evaluation/benchmarks/timer_cases.json`

---

## 🏁 Summary

The **experimental phase** is the foundation of the Timer agent system.

It enables:
* ✅ Safe exploration of Timer generation approaches
* ✅ Validation of small LLM capabilities for Timer tasks
* ✅ Iterative improvement before production
* ✅ **Focused mastery** of one module (Timer)

**Without this phase, production design would be fragile and unreliable.**

By focusing on Timer first, we:
* Establish proven patterns
* Build confidence in the approach
* Create a blueprint for other modules
* Achieve measurable success quickly

---

## 💡 Success Criteria

The experimental phase is **complete** when:

1. ✅ Timer code compiles >90% of the time
2. ✅ Register correctness >95%
3. ✅ Timing calculations accurate >95%
4. ✅ Hallucination rate <5%
5. ✅ 100+ validated Timer test cases
6. ✅ Clear path to production identified

**Then proceed to Phase 2: Production System**

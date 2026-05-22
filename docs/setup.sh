#!/bin/bash

set -e

PROJECT_NAME="ai-mcal-agent"

echo "Creating project structure: $PROJECT_NAME"

# Root
mkdir -p $PROJECT_NAME
cd $PROJECT_NAME

# Apps
mkdir -p apps/{api,cli,playground}

# Agents
mkdir -p agents/datasheet_agent
mkdir -p agents/codegen_agent/templates
mkdir -p agents/validation_agent/rules
mkdir -p agents/debug_agent/analyzers
mkdir -p agents/planner_agent

touch agents/datasheet_agent/{agent.py,prompts.py,parser.py}
touch agents/codegen_agent/{agent.py,prompts.py}
touch agents/validation_agent/agent.py
touch agents/validation_agent/rules/{misra_rules.py,autosar_rules.py}
touch agents/debug_agent/agent.py
touch agents/debug_agent/analyzers/{register_analysis.py,timing_analysis.py}
touch agents/planner_agent/{agent.py,prompts.py}

# Orchestration
mkdir -p orchestration
touch orchestration/{graph.py,state.py,router.py,executor.py}

# Tools
mkdir -p tools/rag
mkdir -p tools/code_tools
mkdir -p tools/hardware
mkdir -p tools/utils

touch tools/rag/{retriever.py,embeddings.py,vectorstore.py}
touch tools/code_tools/{c_parser.py,formatter.py,static_analysis.py}
touch tools/hardware/{register_map.py,peripheral_models.py}
touch tools/utils/{logging.py,config.py}

# Knowledge
mkdir -p knowledge/datasheets/{stm32,nxp,infineon}
mkdir -p knowledge/autosar/{mcal_specs,guidelines}
mkdir -p knowledge/examples/{drivers,configs}

# Memory
mkdir -p memory/{short_term,long_term}

# Evaluation
mkdir -p evaluation/benchmarks
mkdir -p evaluation/metrics

touch evaluation/benchmarks/{adc_cases.json,spi_cases.json}
touch evaluation/metrics/{correctness.py,latency.py,hallucination.py}
touch evaluation/runner.py

# Configs
mkdir -p configs
touch configs/{agents.yaml,models.yaml,rag.yaml}

# Tests
mkdir -p tests/{agents,tools,orchestration}

# Observability
mkdir -p observability
touch observability/{tracing.py,callbacks.py}

# Deployments
mkdir -p deployments/{docker,k8s}

# Scripts
mkdir -p scripts
touch scripts/{ingest_datasheets.py,build_index.py}

# Root files
touch .env requirements.txt README.md pyproject.toml

echo "✅ Project structure created successfully!"

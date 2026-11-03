
# Project: HfO2 ReRAM TCAD and 1T1R Synaptic Cell

## Research objective
Master's thesis: From Device to Circuit: TCAD Modeling of Oxide-Based ReRAM and Evaluation of a Simple 1T1R Cell for Analog Synaptic Operation.

Research question: Can a physically modeled oxide-based ReRAM, when integrated into a simple 1T1R cell, provide controlled pulse-based conductance modulation suitable for elementary analog synaptic operation?

## Working environment
- All actual Synopsys Sentaurus simulations run on a university Linux server.
- The researcher connects to the university network through an authorized VPN.
- The researcher uses MobaXterm for SSH and graphical access.
- The researcher starts Sentaurus Workbench using the `swb` command from the remote terminal.
- Codex Cloud does not have access to the VPN, server, Sentaurus installation, licenses, or Workbench execution environment.
- Do not attempt to install Sentaurus, request credentials, or connect to the university server.
- Never claim to have executed Sentaurus or validated a simulation unless actual evidence is provided.

## Scope
1. HfO2 ReRAM structure and meshing using Sentaurus Structure Editor and Sentaurus Mesh.
2. Sentaurus Device modeling of forming, SET, RESET, and pulse response.
3. Physical analysis of oxygen vacancies, resistive switching, and relevant transport models.
4. Extraction of current-voltage, HRS/LRS, and conductance behavior.
5. Future behavioral modeling and 1T1R circuit-level evaluation.

## Documentation
- Use the provided Sentaurus manual chapters 36 and 37 only after verifying the manual title, version, and exact chapter scope.
- Do not invent command syntax, model options, citations, or physical parameter values.
- Distinguish documented commands from assumptions and hypotheses.
- If a reference is unavailable, explicitly say so and request the relevant excerpt or log.
- Do not upload or reproduce proprietary manuals or licensed material in this public repository.

## Code review rules
- Inspect all relevant `.cmd`, `.par`, and `.txt` files before proposing changes.
- Preserve existing project structure, naming conventions, node dependencies, and Workbench macros.
- Check command syntax, file references, parameter definitions, physical consistency, solver settings, and likely convergence issues.
- Distinguish SDE, SMesh, SDevice, SVisual, Workbench, and Data Explorer contexts.
- Do not assume that a `.txt` file is directly executable by Sentaurus.
- Never invent simulation outputs, switching curves, convergence results, or validated device parameters.
- Do not silently replace a calibrated model or change physical parameters.
- Prefer small, traceable changes and explain the rationale for each.
- For any suggested correction, state the affected file, original issue, proposed change, and verification procedure.

## Workflow
1. First perform a read-only repository audit.
2. Report missing files, unclear dependencies, and suspected errors.
3. Propose a plan and obtain approval before modifying numerical models or physics parameters.
4. Make changes in a separate branch and provide a diff or pull request.
5. Supply reproducible instructions for the researcher to test on the university server.
6. Analyze the resulting `.log`, `.out`, `.plt`, or `.tdr` evidence when provided.
7. Keep unverified changes clearly marked as unvalidated.

## Security
- Never commit VPN configurations, credentials, SSH keys, server tokens, license files, or confidential data.
- This repository may be public; treat all additions as publicly visible.
- Respond in Spanish to the researcher. Preserve Sentaurus commands and technical identifiers in their original language.
  

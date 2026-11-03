# From Device to Circuit: TCAD Modeling of Oxide-Based ReRAM and Evaluation of a Simple 1T1R Cell for Analog Synaptic Operation

**Master's Thesis | Electronic Engineering**

**Author:** Edson B. Amaguana Moreta  
**Institutions:** University of Calabria (UNICAL), Italy | Universidad San Francisco de Quito (USFQ), Ecuador  
**Research Area:** Semiconductor Devices, Resistive Memories, Nanoelectronics, Neuromorphic Computing

**Status:** Research and Development — Ongoing

---

## Overview

This repository documents the development of a physics-based Technology Computer-Aided Design (TCAD) model of an oxide-based Resistive Random Access Memory (ReRAM) device and its subsequent evaluation within a simple one-transistor–one-resistor (1T1R) memory cell.

The research focuses on hafnium oxide (HfO₂) ReRAM devices, investigating resistive switching mechanisms, electrical characteristics, and pulse-driven conductance modulation for potential applications in analog synaptic operation.

The project aims to establish a connection between device-level physical modeling and circuit-level behavior, providing a foundation for evaluating ReRAM devices as programmable synaptic elements.

## Research Question

**Can a physically modeled oxide-based ReRAM, when integrated into a simple 1T1R cell, provide controlled pulse-based conductance modulation suitable for elementary analog synaptic operation?**

## Research Objectives

The main objectives of this thesis are:

1. Develop and validate a physics-based TCAD model of an HfO₂ ReRAM device.
2. Reproduce the fundamental resistive switching operations: forming, SET, and RESET.
3. Investigate the physical mechanisms governing switching behavior, including oxygen vacancy dynamics and conductive filament formation.
4. Characterize the electrical response under DC voltage sweeps and programming pulses.
5. Extract device-level characteristics suitable for circuit-level representation.
6. Evaluate the behavior of a simple 1T1R cell under pulse-based programming conditions.
7. Analyze conductance modulation and its suitability for elementary analog synaptic operation.

## Research Methodology

The project is structured into three main stages.

### Stage 1 — TCAD Device Modeling

Development of a physics-based HfO₂ ReRAM model using Synopsys Sentaurus TCAD.

The device-level investigation includes:

- Device geometry and material definition.
- Oxide-based resistive switching mechanisms.
- Oxygen vacancy generation and migration.
- Conductive filament formation and rupture.
- Electroforming process.
- SET and RESET operations.
- High Resistance State (HRS) and Low Resistance State (LRS).
- Current–voltage characteristics and switching hysteresis.
- Transient response to applied voltage pulses.

**Expected outcome:** A validated TCAD model capable of reproducing the fundamental switching behavior of an HfO₂-based ReRAM device.

### Stage 2 — Electrical Characterization and Behavioral Extraction

Analysis of simulated device characteristics to identify the parameters required for circuit-level evaluation.

The investigation includes:

- HRS and LRS resistance extraction.
- SET and RESET switching voltages.
- Programming current and compliance conditions.
- Conductance evolution under voltage pulses.
- Pulse amplitude and duration dependence.
- Switching variability and repeatability.
- Development of a simplified behavioral representation based on TCAD results.

**Expected outcome:** A device-level behavioral representation suitable for evaluating ReRAM operation in a simple circuit environment.

### Stage 3 — 1T1R Cell Evaluation

Integration of the extracted ReRAM behavior into a one-transistor–one-resistor (1T1R) cell.

The transistor acts as a selection and current-control element, while the ReRAM device provides programmable resistance states.

The circuit-level investigation focuses on:

- 1T1R cell configuration.
- Transistor-controlled programming current.
- SET and RESET pulse application.
- Read operations and conductance extraction.
- Incremental conductance modulation.
- Potentiation and depression behavior.
- Conductance update linearity and symmetry.
- Evaluation of elementary analog synaptic functionality.

**Expected outcome:** An assessment of whether the modeled HfO₂ ReRAM can support controlled, pulse-based conductance updates within a simple 1T1R cell.

## Simulation Tools

| Tool | Application |
|---|---|
| Synopsys Sentaurus TCAD | Physical device modeling and electrical simulation |
| Sentaurus Structure Editor (SDE) | Device geometry and material definition |
| Sentaurus Mesh (SMesh) | Device meshing |
| Sentaurus Device (SDevice) | Electrical and transient simulations |
| Sentaurus Visual (SVisual) | Visualization of device characteristics |
| Python / MATLAB | Data processing, characterization and visualization |
| SPICE-compatible simulator | Circuit-level evaluation of the 1T1R cell |

The final circuit simulation environment and behavioral modeling approach will be selected during project development.

## Project Roadmap

- [ ] Literature review and state-of-the-art analysis
- [ ] HfO₂ ReRAM device structure definition
- [ ] TCAD model calibration and validation
- [ ] Electroforming simulation
- [ ] SET and RESET switching characterization
- [ ] HRS/LRS electrical analysis
- [ ] Pulse-based switching simulation
- [ ] Device parameter extraction
- [ ] Behavioral model development
- [ ] 1T1R cell implementation
- [ ] Pulse-based conductance modulation analysis
- [ ] Analog synaptic performance evaluation
- [ ] Final thesis documentation

## Expected Contributions

This research seeks to provide:

- A physically motivated TCAD model of an oxide-based ReRAM device.
- A systematic characterization of resistive switching behavior.
- A methodology for transferring device-level characteristics to a simplified circuit-level representation.
- An evaluation of pulse-controlled conductance modulation in a 1T1R configuration.
- An initial assessment of the suitability of HfO₂ ReRAM for analog synaptic applications.

## Research Scope

The thesis focuses on device-to-circuit modeling and elementary analog synaptic functionality.

The objective is not to implement a complete neuromorphic computing architecture or train a neural network, but rather to investigate whether the physical and electrical characteristics of a modeled ReRAM device can support controlled conductance updates at the single-cell level.

## References

The scientific background will be developed through a literature review covering:

- HfO₂-based resistive switching devices.
- Oxygen vacancy and conductive filament models.
- TCAD modeling of ReRAM.
- Compact and behavioral modeling of resistive memories.
- 1T1R memory cell architectures.
- Analog synaptic devices and pulse-based conductance programming.

Relevant scientific publications will be added as the literature review progresses.

## License and Academic Use

This repository is intended for academic and research purposes.

Synopsys Sentaurus TCAD is proprietary software. Its use requires appropriate institutional licensing. No proprietary software binaries or licensed materials are distributed through this repository.

Research results, simulation scripts, and supporting documentation will be shared according to applicable institutional and licensing restrictions.

---

**Keywords:** ReRAM, HfO₂, Resistive Switching, TCAD, Sentaurus, Oxygen Vacancies, 1T1R, Analog Synapses, Neuromorphic Computing, Semiconductor Devices.

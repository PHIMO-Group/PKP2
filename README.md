# PKP2: PHIMO-enhanced Peking University Predictive PDK (BSPDN Version)

[![License: BSD-3-Clause](https://img.shields.io/badge/License-BSD--3--Clause-blue.svg)](LICENSE)
![Technology Node](https://img.shields.io/badge/Node-Predictive%202nm%20GAA-green.svg)
![Power Delivery](https://img.shields.io/badge/Power%20Delivery-Backside%20%28BSPDN%29-blueviolet.svg)
![Purpose](https://img.shields.io/badge/Purpose-Academic%20Research-orange.svg)

PKP2 is an open-source predictive process design kit for academic research on gate-all-around (GAA) technology with a **backside power delivery network (BSPDN)**. It scales the GAAFET device parameters of the PKP series to the 2 nm technology node and adds a BSPDN based on direct backside contacts (BSC), together with a 4.5-track standard-cell library, SRAM bit-cells, and the PHIMO-series compact models.

[Official PKP website](https://pkp.pkueda.org.cn/) · [PKP3 (3 nm GAA) repository](https://github.com/PHIMO-Group/PKP3) · [Design Rule Manual](docs/PKP2_DRM_V1.0.pdf) · [Installation guide](docs/README_PKP2_INSTALL.txt)

> [!NOTE]
> PKP2 is intended for academic and research purposes only. The designs, technology assumptions, and rule definitions in this PDK are predictive and are **not manufacturable in any foundry**.

---

## Overview

The PKP project, short for **PHIMO-enhanced Peking University Predictive PDK**, aims to provide an open research platform for advanced technology-node exploration. At the center of the PDK is the PHIMO compact modeling framework, which supports GAA device modeling and circuit-level design studies.

PKP2 is the backside-interconnect member of the PKP family. It follows [PKP3](https://github.com/PHIMO-Group/PKP3), the predictive 3 nm nanosheet GAAFET PDK, and targets a predictive **2 nm GAAFET technology node with a backside power delivery network based on direct backside contacts**. It integrates technology files, a design rule manual, parameterized cells, a 4.5-track standard-cell library, SRAM bit-cell designs, and parasitic-extraction collateral for the GAAFET and backside interconnect stack. It is designed to support research in compact modeling, design-technology co-optimization, backside power delivery, standard-cell design, and parasitic-aware implementation.

Please note that the **Calibre DRC/LVS runsets and the StarRC extraction files are not included in this repository**. Users who need access to the rule decks should visit the official PKP website and submit an application.

For more information and application details, please visit the official PKP website:

[https://pkp.pkueda.org.cn/](https://pkp.pkueda.org.cn/)

---

## Main Features

- **Backside power delivery network (BSPDN) with direct backside contacts (BSC)**: supports a backside power delivery network based on direct backside contacts, with GAAFET device parameters equivalently scaled to the 2 nm technology node
- **4.5-track (4.5T) standard-cell library**: 32 cell types and 56 cell variants across multiple drive strengths, with BSC-enabled layouts
- **Backside-aware PDK collateral**: PCells, standard cells, technology files, and the Design Rule Manual (DRM) extended to support BSC and the backside interconnect layers (BSM0 to BSM3)
- **BSC-enabled SRAM bit-cells**: 6T SRAM layouts with a dedicated SRAM backside contact layer, and refined design rules for backside interconnect integration
- **Parasitic extraction for the GAAFET and backside interconnect stack**: standard-cell (SDC) parasitics are incorporated into the Liberty (.lib) files for timing and power characterization
- **PHIMO-NN compact models** in Verilog-A for eight device flavors, with five process-corner modelcards
- Technology LEF and standard-cell LEF at 1x and 4x scale for place-and-route

---

## Repository Structure

```text
PKP2/
├── Stdcells/               # Standard-cell and SRAM library collateral
│   ├── PKP2_SDC_4p5T/      #   OpenAccess 4.5-track standard-cell library
│   ├── PKP2_MEM/           #   OpenAccess SRAM bit-cell library
│   ├── PKP2_GDS/           #   GDSII for standard cells and SRAM bit-cells
│   ├── PKP2_LEF/           #   Standard-cell abstract LEF (1x and 4x)
│   ├── PKP2_LIB/           #   Liberty timing and power (ECSM, NLDM)
│   ├── PKP2_CDL/           #   CDL netlist and extracted SPF netlists
│   └── TECHLEF/            #   Technology LEF (1x and 4x)
├── cdslib/
│   ├── setup/              # PDK path and run-directory setup scripts
│   └── tech/               # Technology file, display file, layer map, PCell library
├── docs/                   # Design Rule Manual, PEX manual, model user guide, install guide
├── models/
│   ├── PHIMO/              # Verilog-A models and process-corner modelcards
│   └── include.sp          # Top-level Spectre/SPICE model include file
├── LICENSE
└── README.md
```

The setup scripts also expect a `runsets/` directory (`DRC/`, `LVS/`, `RCX/`) in the PDK root. It holds the Calibre rule decks and StarRC extraction files, which are distributed separately. See [Rule Decks](#rule-decks).

---

## Version Information

### Version 1.0

Version 1.0 is the initial PKP2 release. This repository corresponds to the `PKP2_V1.0` package on the official PKP website.

- Supports a backside power delivery network based on direct backside contacts, with GAAFET device parameters equivalently scaled to the 2 nm technology node
- Extends PCells, standard cells, technology files, the Design Rule Manual (DRM), and DRC/LVS rule decks to support BSC and backside interconnect layers
- Includes BSC-enabled standard-cell and SRAM layouts and refined design rules for backside interconnect integration. The 4.5-track standard-cell library comprises 32 cell types and 56 cell variants across multiple drive strengths
- Provides parasitic-extraction collateral for the GAAFET and backside interconnect stack, with SDC parasitics incorporated into the standard-cell Liberty (.lib) files for timing and power characterization

---

## Intended Use

PKP2 can be used for:

- Academic research on backside power delivery and backside contacts in GAA technology
- Predictive PDK-based DTCO exploration across devices, backside interconnect, standard cells, and SRAM
- Compact model validation and circuit simulation
- Standard-cell layout and characterization studies at 4.5-track cell height
- Parasitic-aware circuit implementation including the backside interconnect stack
- RTL-to-GDS flow experiments
- Educational demonstrations of advanced-node PDK structure and design flows

---

## Requirements

The PDK is designed for advanced-node academic design-flow research and may require commercial EDA tools for layout design, verification, simulation, and parasitic extraction.

Depending on the specific flow, users may need tools such as:

- Cadence Virtuoso for schematic and layout design
- A SPICE-compatible simulator with Verilog-A support
- Calibre for DRC and LVS, with the PKP2 rule decks
- StarRC for parasitic extraction, version G-2012.06 or later (the current PEX flow does not support Calibre xACT)
- Liberty-based timing analysis and place-and-route tools

> Tool availability, environment setup, and license configuration are not included in this repository.

---

## Getting Started

The full procedure is described in [`docs/README_PKP2_INSTALL.txt`](docs/README_PKP2_INSTALL.txt). In short:

1. Clone the repository to the install area.

   ```csh
   git clone https://github.com/PHIMO-Group/PKP2.git
   ```

2. Edit `cdslib/setup/set_pdk_path.csh` and replace the string `PDKDirectory` with the absolute path of the PKP2 directory.

3. Create a run directory, load the PDK paths, and initialize the run directory.

   ```csh
   mkdir ~/pkp2_rundir ; cd ~/pkp2_rundir
   source /absolute/path/to/PKP2/cdslib/setup/set_pdk_path.csh
   tcsh $PDK_ROOT/cdslib/setup/setup_pkp.csh
   ```

   The script generates `cds.lib`, links `display.drf`, and creates the local work directories.

4. Start Virtuoso from the run directory.

   ```csh
   virtuoso &
   ```

For circuit simulation outside Virtuoso, include [`models/include.sp`](models/include.sp) in the netlist. It loads the eight Verilog-A models and the TT modelcard; select another corner by changing the active `.include` line. The device instance parameters are `L` (channel length), `W` (nanosheet width), and `NF` (number of fingers). See [`docs/PKP_model_userguide_1.0.pdf`](docs/PKP_model_userguide_1.0.pdf) for details.

### Rule Decks

The Calibre DRC/LVS rule decks and the StarRC extraction files are application-based and are not part of this repository. After obtaining the rule-deck package from the [official PKP website](https://pkp.pkueda.org.cn/), place its `DRC/`, `LVS/`, and `RCX/` directories under `runsets/` in the PDK root. `setup_pkp.csh` then links them into the run directory. The extraction flow is described in [`docs/PKP2_PEX_manual_V1.0.pdf`](docs/PKP2_PEX_manual_V1.0.pdf).

---

## Recent Publications

The following publications are related to the PHIMO-series compact models, PKP, and advanced GAA device modeling.

[1] B. Peng, F. Teng, G. Cheng, H. Wu, L. Zhang, R. Wang, R. Huang, "PKP: Open-source Compact Models and Predictive PDK for GAA Technology," *Science China Information Sciences*, 2026. DOI: [10.1007/s11432-025-4805-5](https://doi.org/10.1007/s11432-025-4805-5)

[2] G. Cheng, B. Peng, S. Chen, J. Lin, R. Wang, L. Zhang, "Invited: PKP: A Predictive Open PDK in the Era of GAA and Backside Interconnect," in *Proceedings of the ACM/IEEE International Symposium on Machine Learning for CAD (MLCAD)*, 2026.

[3] S. Chen, B. Lin, J. Lin, Y. Zhang, U. Schlichtmann, L. Zhang, R. Wang, "Parasitic-aware SRAM Designs with 2nm Predictive Technology Incorporating Backside Contact," in *Proceedings of the International Symposium of Electronics Design Automation (ISEDA)*, 2026.

[4] B. Peng, F. Zhang, W. Dai, H. Wu, G. Cheng, R. Wang, M. Chan, L. Zhang, "PHIMO-NN: Compact Modeling by Fusing Device Physics and Neural Networks for One-Shot Parameterization," *IEEE Transactions on Computer-Aided Design of Integrated Circuits and Systems*, vol. 45, no. 2, pp. 795–805, Feb. 2026.

[5] S. Chen, B. Peng, Y. Jiao, Y. Li, L. Zhang, Z. Sun, Y. Xue, Z. Ji, R. Wang, R. Huang, "Self-heating effects of vertical gate-all-around transistors: analysis and modeling," *IEEE Transactions on Electron Devices*, vol. 71, no. 11, pp. 6478–6485, Nov. 2024.

[6] B. Peng, Y. Jiao, H. Zhong, Z. Rong, Z. Wang, Y. Xiao, W. Wong, L. Zhang, R. Wang, R. Huang, "Compact modeling of quantum confinements in nanoscale gate-all-around MOSFETs," *Fundamental Research*, vol. 4, no. 5, pp. 1306–1313, Sept. 2024.

[7] B. Peng, S. Chen, Y. Li, L. Zhang, H. Wu, M. Li, R. Wang, R. Huang, "Modeling the parasitic resistances and capacitances of advanced vertical gate-all-around transistors," *IEEE Transactions on Electron Devices*, vol. 71, no. 1, pp. 461–467, Jan. 2024.

---

## Citation

If you use PKP2 in academic publications, please cite:

```text
G. Cheng, B. Peng, S. Chen, J. Lin, R. Wang, L. Zhang,
"Invited: PKP: A Predictive Open PDK in the Era of GAA and Backside Interconnect,"
in Proceedings of the ACM/IEEE International Symposium on Machine Learning for CAD (MLCAD), 2026.
```

If you use the PHIMO-NN model in publication work, please also cite:

```text
B. Peng, F. Zhang, W. Dai, H. Wu, G. Cheng, R. Wang, M. Chan, L. Zhang,
"PHIMO-NN: Compact Modeling by Fusing Device Physics and Neural Networks for One-Shot Parameterization,"
IEEE Transactions on Computer-Aided Design of Integrated Circuits and Systems,
vol. 45, no. 2, pp. 795–805, Feb. 2026.
```

---

## Contributors

The PKP and PHIMO-related work is developed by the research team from Peking University and collaborators.

### Core Contributors

**Profs.** Lining Zhang, Heng Wu, Runsheng Wang, Ru Huang

**PKP2:** Jie Lin, Sihao Chen, Baicheng Lin, Guoyao Cheng, Yafei Ma, Baokang Peng, Qiyuan Su

### Academic Collaborators

- Prof. Mansun Chan, Hong Kong University of Science and Technology
- Prof. Zhigang Ji, Shanghai Jiao Tong University
- Prof. Jun Yang, Southeast University, and National Center of Technology Innovation for EDA
- Prof. Zhiang Wang, Fudan University

---

## Contact

For questions, applications, or collaboration requests, please contact:

```text
digital_eda@pkueda.org.cn
```

---

## License

This repository is released under the **BSD-3-Clause License**. Please refer to the [`LICENSE`](LICENSE) file for details.

---

## Disclaimer

PKP2 is a predictive and research-oriented PDK. It does not represent any commercial foundry process and should not be used for manufacturing. The technology rules, device parameters, layout assumptions, and design examples are provided for academic exploration, teaching, and research validation only.

Users are responsible for ensuring that their use of the PDK complies with applicable licenses, institutional policies, and EDA tool agreements.

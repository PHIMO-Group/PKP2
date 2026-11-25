*--------------------------------------------------------------------------
* PKP2
*--------------------------------------------------------------------------

* Readme File Author : PHIMO Group
* Last Modified On   : October 15, 2026
* Description        : This file describes the PKP2 directory structure
*                      and the steps required to install and use the PDK.
*--------------------------------------------------------------------------

*--------------------------
* PDK Installation Guide
*--------------------------

* Instructions for administrator/instructor
*--------------------------------------------------------------------------

1. Copy the untarred PKP2 directory to the desired install area.

2. Edit the environment variable in the following script by replacing
   the string 'PDKDirectory' with the absolute path to the PDK directory
   (including the PKP2 folder name):

   ./cdslib/setup/set_pdk_path.csh


* Instructions for end-users to setup a local PDK run directory
*--------------------------------------------------------------------------

NOTE: Ask your administrator/instructor for the absolute path where
      the PKP2 is located. This path must replace the placeholder
      string 'PDKDirectory' and becomes the value of the environmental
      variable 'PDK_ROOT'.

NOTE: Once the run directory has been setup, users only need to repeat
      steps 2. and 3. below to start Cadence Virtuoso.

1. Create a local run directory under your home directory, e.g.:

   cd ~ ; mkdir pkp2_rundir ; cd pkp2_rundir

2. Source the path setup script using the absolute PDK path supplied by
   your administrator/instructor:

   source /absolute/path/to/PKP2/cdslib/setup/set_pdk_path.csh

3. Run the initialization script:

   tcsh $PDK_ROOT/cdslib/setup/setup_pkp.csh

   This script will create the necessary files and directories, such as
   Calibre rule links, cds.lib, display.drf, and local work directories,
   in the local run directory.

4. Start Virtuoso by typing:

   virtuoso &


*--------------------------
* PDK Directory Structure
*--------------------------

PKP2/
|-- Stdcells                         : Standard-cell and SRAM library collateral
|   |-- PKP2_CDL                     : CDL netlists for LVS and characterization
|   |   |-- PKP2_CDL.cdl             : Combined standard-cell CDL netlist
|   |   `-- PKP2_CDL_Extracted       : Extracted standard-cell SPF netlists
|   |
|   |-- PKP2_GDS                     : GDSII files for standard cells and SRAM bitcells
|   |   |-- PKP2_GDS_4p5T            : 4.5-track standard-cell GDSII files
|   |   `-- PKP2_GDS_MEM             : SRAM bitcell GDSII files
|   |
|   |-- PKP2_LEF                     : Abstract LEF views for P&R
|   |   |-- PKP2_SDC_4p5T.lef        : 1x standard-cell abstract LEF
|   |   `-- scaled
|   |       `-- PKP2_SDC_4p5T_4x.lef : 4x standard-cell abstract LEF
|   |
|   |-- PKP2_LIB                     : Liberty timing/power data by PVT corner
|   |   |-- ecsm
|   |   |   `-- PKP2_SVT_TT_ecsm.lib  : TT/SVT ECSM Liberty file
|   |   `-- nldm
|   |       `-- PKP2_SVT_TT_nldm.lib  : TT/SVT NLDM Liberty file
|   |
|   |-- PKP2_MEM                     : OpenAccess SRAM bitcell library
|   |-- PKP2_SDC_4p5T                : OpenAccess 4.5-track standard-cell library
|   `-- TECHLEF                      : Technology LEF files for P&R tools
|       |-- PKP2_tech_1x.lef         : 1x technology LEF
|       `-- PKP2_tech_4x.lef         : 4x technology LEF
|
|-- cdslib
|   |-- setup
|   |   |-- set_pdk_path.csh         : C-shell script to set PDK path variables
|   |   `-- setup_pkp.csh            : Script to initialize local run directory
|   |
|   `-- tech
|       |-- PKP2_Pcell               : Parameterized cell (PCell) library
|       |-- cds.lib                  : Cadence library definition file
|       |-- display.drf              : Display resource file for Virtuoso
|       |-- gaabsc.layermap          : Layer mapping file
|       |-- tech.db                  : Technology database
|       `-- techfile.tf              : Technology file for Cadence
|
|-- docs
|   |-- PKP2_DRM_V1.0.pdf            : Design Rule Manual (DRM)
|   |-- PKP2_PEX_manual_V1.0.pdf     : StarRC parasitic extraction user manual
|   |-- PKP_model_userguide_1.0.pdf  : Device model user guide
|   |-- README_PKP2_INSTALL.txt      : Installation and directory guide for PKP2
|   `-- cite_info                    : Citation and acknowledgement information
|
|-- models
|   |-- PHIMO                        : Device model library
|   |   |-- MODELCARD                : Process-corner model cards
|   |   `-- VERILOG-A                : NMOS and PMOS Verilog-A models
|   `-- include.sp                   : Top-level Spectre/SPICE model include file
|
`-- runsets
    |-- DRC                          : Calibre DRC rule files
    |-- LVS                          : Calibre LVS rule files
    `-- RCX
        `-- StarRC                   : StarRC parasitic extraction files
            `-- ITF                  : StarRC interconnect technology files


*--------------------------
* Notes
*--------------------------

1. Well and substrate pins (VDD/VSS) may be used as substitutes for LVS
   at the standard-cell level.

2. StarRC parasitic extraction files are under runsets/RCX/StarRC.

3. The 1x and 4x standard-cell LEFs omit CT obstructions because the
   supplied technology LEFs do not define CT.

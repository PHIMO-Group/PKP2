#!/bin/tcsh -f
# ============================================================
# Create a local PKP2 user/project run directory
#
# Usage:
#     source /path/to/set_pdk_path.csh
#     mkdir my_project
#     cd my_project
#     /path/to/setup_pkp.csh
# ============================================================

set force = 0

if ( $#argv > 0 ) then
    if ( "$argv[1]" == "--force" || "$argv[1]" == "-f" ) then
        set force = 1
    else
        echo "[ERROR] Unknown option: $argv[1]"
        echo "[TIP] Supported option: --force"
        exit 2
    endif
endif

# ============================================================
# Check required environment variables
# ============================================================
set missing_env = 0

if ( ! $?PDK_ROOT ) then
    echo "[ERROR] PDK_ROOT is not defined."
    set missing_env = 1
endif

if ( ! $?PDK_TECHLIBNAME ) then
    echo "[ERROR] PDK_TECHLIBNAME is not defined."
    set missing_env = 1
endif

if ( ! $?PDK_TECHDIR ) then
    echo "[ERROR] PDK_TECHDIR is not defined."
    set missing_env = 1
endif

if ( ! $?PDK_DISPLAY_DRF ) then
    echo "[ERROR] PDK_DISPLAY_DRF is not defined."
    set missing_env = 1
endif

if ( ! $?PDK_LIBNAME_4P5T ) then
    echo "[ERROR] PDK_LIBNAME_4P5T is not defined."
    set missing_env = 1
endif

if ( ! $?PDK_LIBNAME_MEM ) then
    echo "[ERROR] PDK_LIBNAME_MEM is not defined."
    set missing_env = 1
endif

if ( ! $?PDK_CELLROOT_4P5T ) then
    echo "[ERROR] PDK_CELLROOT_4P5T is not defined."
    set missing_env = 1
endif

if ( ! $?PDK_CELLROOT_MEM ) then
    echo "[ERROR] PDK_CELLROOT_MEM is not defined."
    set missing_env = 1
endif

if ( ! $?PHIMO_CALIBRE_DRC ) then
    echo "[ERROR] PHIMO_CALIBRE_DRC is not defined."
    set missing_env = 1
endif

if ( ! $?PHIMO_CALIBRE_LVS ) then
    echo "[ERROR] PHIMO_CALIBRE_LVS is not defined."
    set missing_env = 1
endif

if ( ! $?PHIMO_CALIBRE_PEX ) then
    echo "[ERROR] PHIMO_CALIBRE_PEX is not defined."
    set missing_env = 1
endif

if ( ${missing_env} ) then
    echo ""
    echo "[ERROR] PKP2 environment is incomplete."
    echo "[TIP] First run:"
    echo "      source /path/to/set_pdk_path.csh"
    exit 2
endif

unset missing_env

# ============================================================
# Validate library paths
# ============================================================
if ( ! -d "${PDK_TECHDIR}" ) then
    echo "[ERROR] Technology library not found:"
    echo "        ${PDK_TECHDIR}"
    exit 2
endif

if ( ! -d "${PDK_CELLROOT_4P5T}" ) then
    echo "[ERROR] 4.5T standard-cell library not found:"
    echo "        ${PDK_CELLROOT_4P5T}"
    exit 2
endif

if ( ! -d "${PDK_CELLROOT_MEM}" ) then
    echo "[ERROR] SRAM bitcell library not found:"
    echo "        ${PDK_CELLROOT_MEM}"
    exit 2
endif

# ============================================================
# File names
# ============================================================
set cds_lib       = "cds.lib"
set cds_lib_local = "cds.lib.local"
set cdsenv=".cdsenv"
set cdsinit=".cdsinit"

# ============================================================
# Resolve Cadence installation root
# ============================================================
set cds_root = ""
set cadence_cds_lib = ""

# Prefer the existing CDS environment variable.
if ( $?CDS ) then
    if ( -f "${CDS}/share/cdssetup/cds.lib" ) then
        set cds_root = "${CDS}"
        set cadence_cds_lib = "${CDS}/share/cdssetup/cds.lib"

        echo "[OK] Using CDS from environment:"
        echo "     ${cds_root}"
    else
        echo "[WARNING] CDS is defined, but the default cds.lib was not found:"
        echo "          ${CDS}/share/cdssetup/cds.lib"
    endif
endif

# If CDS is missing or invalid, ask the user.
if ( "${cadence_cds_lib}" == "" ) then
    echo ""
    echo "[INFO] Cadence installation root is required to include"
    echo "       the Cadence default cds.lib."
    echo -n "Enter Cadence installation root, or press Enter to skip: "

    set cds_input = "$<"

    if ( "${cds_input}" != "" ) then
        if ( -f "${cds_input}/share/cdssetup/cds.lib" ) then
            set cds_root = "${cds_input}"
            set cadence_cds_lib = "${cds_input}/share/cdssetup/cds.lib"

            # Also define CDS for the remainder of this script.
            setenv CDS "${cds_root}"

            echo "[OK] Cadence installation root accepted:"
            echo "     ${cds_root}"
        else
            echo "[WARNING] Cadence default cds.lib was not found:"
            echo "          ${cds_input}/share/cdssetup/cds.lib"
            echo "[WARNING] Cadence default library setup will be skipped."
        endif
    else
        echo "[WARNING] No Cadence installation root entered."
        echo "[WARNING] Cadence default library setup will be skipped."
    endif

    unset cds_input
endif

# ============================================================
# Generate cds.lib
# ============================================================
# Include the Cadence default cds.lib only when a valid path exists.
if ( "${cadence_cds_lib}" != "" ) then
    echo "" >> "${cds_lib}"
    echo "SOFTINCLUDE ${cadence_cds_lib}" >> "${cds_lib}"
endif

/bin/cat >> "${cds_lib}" << EOF


DEFINE ${PDK_TECHLIBNAME} ${PDK_PCELL_DIR}
DEFINE ${PDK_LIBNAME_4P5T} ${PDK_CELLROOT_4P5T}

DEFINE ${PDK_LIBNAME_MEM} ${PDK_CELLROOT_MEM}

SOFTINCLUDE ${cds_lib_local}
EOF

unset cds_root
unset cadence_cds_lib

# ============================================================
# Create local cds.lib extension
# ============================================================
if ( ! -e "${cds_lib_local}" ) then
    /bin/cat >! "${cds_lib_local}" << EOF
DEFINE worklib ${PWD}
EOF
endif


# ============================================================
# Create local display.drf link
# ============================================================
if ( -e "${PWD}/display.drf" || -l "${PWD}/display.drf" ) then
    if ( ${force} ) then
        rm -f "${PWD}/display.drf"
    endif
endif

if ( ! -e "${PWD}/display.drf" && ! -l "${PWD}/display.drf" ) then
    if ( -f "${PDK_DISPLAY_DRF}" ) then
        ln -s "${PDK_DISPLAY_DRF}" "${PWD}/display.drf"
    else
        echo "[WARNING] display.drf source not found:"
        echo "          ${PDK_DISPLAY_DRF}"
    endif
endif

# ============================================================
# Create local run directories
# ============================================================
foreach d ( drc lvs pex simulation results docs )
    if ( ! -d "${d}" ) then
        mkdir -p "${d}"
    endif
end

# ============================================================
# Create DRC rule-deck link
# ============================================================
if ( -e rules_drc || -l rules_drc ) then
    if ( ${force} ) then
        rm -rf rules_drc
    endif
endif

if ( ! -e rules_drc && ! -l rules_drc ) then
    if ( -d "${PHIMO_CALIBRE_DRC}" ) then
        ln -s "${PHIMO_CALIBRE_DRC}" rules_drc
    else
        echo "[WARNING] DRC rule directory not found:"
        echo "          ${PHIMO_CALIBRE_DRC}"
    endif
endif

# ============================================================
# Create LVS rule-deck link
# ============================================================
if ( -e rules_lvs || -l rules_lvs ) then
    if ( ${force} ) then
        rm -rf rules_lvs
    endif
endif

if ( ! -e rules_lvs && ! -l rules_lvs ) then
    if ( -d "${PHIMO_CALIBRE_LVS}" ) then
        ln -s "${PHIMO_CALIBRE_LVS}" rules_lvs
    else
        echo "[WARNING] LVS rule directory not found:"
        echo "          ${PHIMO_CALIBRE_LVS}"
    endif
endif

# ============================================================
# Create PEX rule-deck link
# ============================================================
if ( -e rules_pex || -l rules_pex ) then
    if ( ${force} ) then
        rm -rf rules_pex
    endif
endif

if ( ! -e rules_pex && ! -l rules_pex ) then
    if ( -d "${PHIMO_CALIBRE_PEX}" ) then
        ln -s "${PHIMO_CALIBRE_PEX}" rules_pex
    else
        echo "[WARNING] PEX rule directory not found:"
        echo "          ${PHIMO_CALIBRE_PEX}"
    endif
endif

# ============================================================
# Copy documentation locally
# ============================================================
if ( $?PHIMO_docs ) then
    if ( -d "${PHIMO_docs}" ) then
        cp -R "${PHIMO_docs}/." docs/
        echo "[OK] Documentation copied to ${PWD}/docs"
    else
        echo "[WARNING] Documentation directory not found:"
        echo "          ${PHIMO_docs}"
        echo "[WARNING] Skipping documentation copy."
    endif
else
    echo "[WARNING] PHIMO_docs is not defined."
    echo "[WARNING] Skipping documentation copy."
endif

# ============================================================
# Final message
# ============================================================
echo ""
echo "[OK] PKP2 project setup completed."
echo ""
echo "[OK] Generated:"
echo "     ${PWD}/${cds_lib}"
echo "     ${PWD}/${cds_lib_local}"
echo ""
echo "[OK] Loaded Cadence libraries:"
echo "     ${PDK_TECHLIBNAME}"
echo "     ${PDK_LIBNAME_4P5T}"
echo "     ${PDK_LIBNAME_MEM}"
echo ""
echo "[TIP] Add your local design library to cds.lib.local."
echo "[TIP] Start Virtuoso from this directory:"
echo "      virtuoso &"

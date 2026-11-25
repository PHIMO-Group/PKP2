#!/bin/tcsh
# === Minimal PDK path config ===

setenv PDK_ROOT "PDKDirectory"

# ------------------------------------------------------------
# Cadence technology library
# ------------------------------------------------------------
setenv PDK_TECHLIBNAME "PKP2_Pcell"
setenv PDK_TECHDIR     "${PDK_ROOT}/cdslib/tech"

setenv PDK_TECHFILE    "${PDK_TECHDIR}/techfile.tf"
setenv PDK_TECHDB      "${PDK_TECHDIR}/tech.db"
setenv PDK_DISPLAY_DRF "${PDK_TECHDIR}/display.drf"
setenv PDK_LAYERMAP    "${PDK_TECHDIR}/gaabsc.layermap"

# PCell SKILL source directory.
# This is not a Cadence library and must not be DEFINE'd in cds.lib.
setenv PDK_PCELL_DIR "${PDK_TECHDIR}/PKP2_Pcell"

# ------------------------------------------------------------
# Standard-cell and SRAM bitcell libraries
# ------------------------------------------------------------
setenv PDK_CELL_FLAVOR_ROOT "${PDK_ROOT}/Stdcells"

setenv PDK_LIBNAME_4P5T "PKP2_SDC_4p5T"
setenv PDK_LIBNAME_MEM  "PKP2_MEM"

setenv PDK_CELLROOT_4P5T \
    "${PDK_CELL_FLAVOR_ROOT}/${PDK_LIBNAME_4P5T}"

setenv PDK_CELLROOT_MEM \
    "${PDK_CELL_FLAVOR_ROOT}/${PDK_LIBNAME_MEM}"

# ------------------------------------------------------------
# Calibre rule decks
# ------------------------------------------------------------
setenv PDK_CALIBRE_RULES "${PDK_ROOT}/runsets"
# Customize rule deck names as needed
setenv PHIMO_CALIBRE_DRC "${PDK_CALIBRE_RULES}/DRC"
setenv PHIMO_CALIBRE_LVS "${PDK_CALIBRE_RULES}/LVS"
setenv PHIMO_CALIBRE_PEX "${PDK_CALIBRE_RULES}/RCX"

# ------------------------------------------------------------
# Documentation
# ------------------------------------------------------------
setenv PHIMO_DRM	"${PDK_ROOT}/docs/PKP2_DRM_V1.0.pdf"
setenv PHIMO_docs	"${PDK_ROOT}/docs"
setenv PHIMO_PEXM	"${PDK_ROOT}/docs/PKP2_PEX_manual_V1.0.pdf"

# ------------------------------------------------------------
# Cadence display resource
# ------------------------------------------------------------
setenv CDS_DISPLAY_RESOURCE_FILE "${PDK_DISPLAY_DRF}"

# ------------------------------------------------------------
# Basic validation
# Do not use "exit" because this file is sourced.
# ------------------------------------------------------------
set pdk_config_error = 0

if ( ! -d "${PDK_ROOT}" ) then
    echo "[ERROR] PDK_ROOT not found:"
    echo "        ${PDK_ROOT}"
    set pdk_config_error = 1
endif

# Technology library
if ( ! -d "${PDK_TECHDIR}" ) then
    echo "[ERROR] Technology library directory not found:"
    echo "        ${PDK_TECHDIR}"
    set pdk_config_error = 1
endif

if ( ! -f "${PDK_TECHDB}" ) then
    echo "[WARNING] Compiled technology database not found:"
    echo "          ${PDK_TECHDB}"
endif

if ( ! -f "${PDK_TECHFILE}" ) then
    echo "[WARNING] ASCII technology file not found:"
    echo "          ${PDK_TECHFILE}"
endif

if ( ! -f "${PDK_DISPLAY_DRF}" ) then
    echo "[WARNING] Display resource file not found:"
    echo "          ${PDK_DISPLAY_DRF}"
endif

if ( ! -f "${PDK_LAYERMAP}" ) then
    echo "[WARNING] Stream layer map not found:"
    echo "          ${PDK_LAYERMAP}"
endif

if ( ! -d "${PDK_PCELL_DIR}" ) then
    echo "[WARNING] PCell SKILL directory not found:"
    echo "          ${PDK_PCELL_DIR}"
endif

# 4.5T standard-cell library
if ( ! -d "${PDK_CELLROOT_4P5T}" ) then
    echo "[ERROR] 4.5T standard-cell library not found:"
    echo "        ${PDK_CELLROOT_4P5T}"
    set pdk_config_error = 1
endif

# SRAM bitcell library
if ( ! -d "${PDK_CELLROOT_MEM}" ) then
    echo "[ERROR] SRAM bitcell library not found:"
    echo "        ${PDK_CELLROOT_MEM}"
    set pdk_config_error = 1
endif

# Rule-deck directories
if ( ! -d "${PHIMO_CALIBRE_DRC}" ) then
    echo "[WARNING] DRC rule directory not found:"
    echo "          ${PHIMO_CALIBRE_DRC}"
endif

if ( ! -d "${PHIMO_CALIBRE_LVS}" ) then
    echo "[WARNING] LVS rule directory not found:"
    echo "          ${PHIMO_CALIBRE_LVS}"
endif

if ( ! -d "${PHIMO_CALIBRE_PEX}" ) then
    echo "[WARNING] PEX rule directory not found:"
    echo "          ${PHIMO_CALIBRE_PEX}"
endif

# ------------------------------------------------------------
# Final status
# ------------------------------------------------------------
if ( ${pdk_config_error} ) then
    echo ""
    echo "[ERROR] PKP2 PDK configuration failed."

    # Prevent setup_project.csh from using an invalid configuration.
    unsetenv PDK_ROOT
else
    echo ""
    echo "[OK] PKP2 PDK configured."
    echo "     PDK_ROOT     = ${PDK_ROOT}"
    echo "     Tech library = ${PDK_TECHDIR}"
    echo "     4.5T library = ${PDK_CELLROOT_4P5T}"
    echo "     SRAM library = ${PDK_CELLROOT_MEM}"
endif

unset pdk_config_error

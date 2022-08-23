BUILDDIR := ${current_dir}/build
OBJDIR := ${current_dir}/obj_dir
TOP := $(strip ${TOP})
BIT := ${BUILDDIR}/${TOP}.bit
SIM := ${current_dir}/${TOP}.sim

DEVICE := xc7a100t_test
BITSTREAM_DEVICE := artix7
PARTNAME := xc7a100tcsg324-1
OFL_BOARD := arty_a7_100t

.DELETE_ON_ERROR:

.PHONY: build clean load sim synth

bit: ${BIT}

clean:
	rm -rf ${BUILDDIR} ${OBJDIR} ${TOP}.sim

load: ${BUILDDIR}/${TOP}.bit
	openFPGALoader -b ${OFL_BOARD} ${BIT}

sim: ${SIM}
	${SIM}

synth: ${BUILDDIR}/${TOP}.eblif


# FPGA targets

${BUILDDIR}:
	mkdir -p ${BUILDDIR}

${BUILDDIR}/${TOP}.eblif: ${SOURCES} ${XDC} | ${BUILDDIR}
	cd ${BUILDDIR} && symbiflow_synth -t ${TOP} -v ${SOURCES} -d ${BITSTREAM_DEVICE} -p ${PARTNAME} -x ${XDC}

${BUILDDIR}/${TOP}.net: ${BUILDDIR}/${TOP}.eblif
	cd ${BUILDDIR} && symbiflow_pack -e ${TOP}.eblif -d ${DEVICE} 2>&1 > /dev/null

${BUILDDIR}/${TOP}.place: ${BUILDDIR}/${TOP}.net
	cd ${BUILDDIR} && symbiflow_place -e ${TOP}.eblif -d ${DEVICE} -n ${TOP}.net -P ${PARTNAME} 2>&1 > /dev/null

${BUILDDIR}/${TOP}.route: ${BUILDDIR}/${TOP}.place
	cd ${BUILDDIR} && symbiflow_route -e ${TOP}.eblif -d ${DEVICE} 2>&1 > /dev/null

${BUILDDIR}/${TOP}.fasm: ${BUILDDIR}/${TOP}.route
	cd ${BUILDDIR} && symbiflow_write_fasm -e ${TOP}.eblif -d ${DEVICE}

${BUILDDIR}/${TOP}.bit: ${BUILDDIR}/${TOP}.fasm
	cd ${BUILDDIR} && symbiflow_write_bitstream -d ${BITSTREAM_DEVICE} -f ${TOP}.fasm -p ${PARTNAME} -b ${TOP}.bit


# SIM targets

${SIM}: ${OBJDIR}/V${TOP}__ALL.a
	g++ -I /usr/share/verilator/include -I ${OBJDIR} /usr/share/verilator/include/verilated.cpp ${TOP}.cpp ${OBJDIR}/V${TOP}__ALL.a -o ${TOP}.sim

${OBJDIR}/V${TOP}__ALL.a: ${SOURCES} ${XDC} ${current_dir}/${TOP}.cpp
	verilator -Wall -cc ${TOP}.v
	make -C ${OBJDIR} -f V${TOP}.mk


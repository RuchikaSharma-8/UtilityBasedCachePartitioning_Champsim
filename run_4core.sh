#!/bin/bash



if [ "$#" -lt 6 ] || [ "$#" -gt 13 ]; then

    echo "Illegal number of parameters"

    echo "Usage: ./run_4core.sh [BINARY] [N_WARM] [N_SIM] [N_MIX] [TRACE0] [TRACE1] [TRACE2] [TRACE3] [TRACE4] [TRACE5] [TRACE6] [TRACE7] [OPTION]"

    exit 1

fi
 
TRACE_DIR=$PWD/dpc3_traces

BINARY=${1}

N_WARM=${2}

N_SIM=${3}

N_MIX=${4}

TRACE0=${5}

TRACE1=${6}

# Sanity check

if [ -z $TRACE_DIR ] || [ ! -d "$TRACE_DIR" ] ; then

    echo "[ERROR] Cannot find a trace directory: $TRACE_DIR"

    exit 1

fi



if [ ! -f "bin/$BINARY" ] ; then

    echo "[ERROR] Cannot find a ChampSim binary: bin/$BINARY"

    exit 1

fi

re='^[0-9]+$'

if ! [[ $N_WARM =~ $re ]] || [ -z $N_WARM ] ; then

    echo "[ERROR]: Number of warmup instructions is NOT a number" >&2;

    exit 1

fi

re='^[0-9]+$'

if ! [[ $N_SIM =~ $re ]] || [ -z $N_SIM ] ; then

    echo "[ERROR]: Number of simulation instructions is NOT a number" >&2;

    exit 1

fi

if [ ! -f "$TRACE_DIR/$TRACE0" ] ; then

    echo "[ERROR] Cannot find a trace0 file: $TRACE_DIR/$TRACE0"

    exit 1

fi

if [ ! -f "$TRACE_DIR/$TRACE1" ] ; then

    echo "[ERROR] Cannot find a trace1 file: $TRACE_DIR/$TRACE1"

    exit 1

fi

if [ "$#" -eq 6 ] || [ "$#" -eq 7 ]; then
	OPTION=${7}
	mkdir -p results_4core_${N_SIM}M

(./bin/${BINARY} -warmup_instructions ${N_WARM}000000 -simulation_instructions ${N_SIM}000000 ${OPTION} -traces ${TRACE_DIR}/${TRACE0} ${TRACE_DIR}/${TRACE1}) &> results_4core_${N_SIM}M/mix${N_MIX}-${BINARY}${OPTION}.txt

elif [ "$#" -eq 8 ] || [ "$#" -eq 9 ] ; then
	TRACE2=${7}
	TRACE3=${8}
	OPTION=${9}
	if [ ! -f "$TRACE_DIR/$TRACE2" ] ; then

	    echo "[ERROR] Cannot find a trace0 file: $TRACE_DIR/$TRACE2"

	    exit 1

	fi

	if [ ! -f "$TRACE_DIR/$TRACE3" ] ; then

	    echo "[ERROR] Cannot find a trace1 file: $TRACE_DIR/$TRACE3"

	    exit 1

	fi
	mkdir -p results_4core_${N_SIM}M

	(./bin/${BINARY} -warmup_instructions ${N_WARM}000000 -simulation_instructions ${N_SIM}000000 ${OPTION} -traces ${TRACE_DIR}/${TRACE0} ${TRACE_DIR}/${TRACE1} ${TRACE_DIR}/${TRACE2} ${TRACE_DIR}/${TRACE3})&> results_4core_${N_SIM}M/mix${N_MIX}-${BINARY}${OPTION}.txt

elif [ "$#" -eq  12 ] || [ "$#" -eq 13 ] ; then
	TRACE2=${7}
	TRACE3=${8}
	TRACE4=${9}
	shift
	TRACE5=${9}
	shift
	TRACE6=${9}
	shift
	TRACE7=${9}
	shift
	OPTION=${9}
	if [ ! -f "$TRACE_DIR/$TRACE2" ] ; then

	    echo "[ERROR] Cannot find a trace0 file: $TRACE_DIR/$TRACE2"

	    exit 1

	fi

	if [ ! -f "$TRACE_DIR/$TRACE3" ] ; then

	    echo "[ERROR] Cannot find a trace1 file: $TRACE_DIR/$TRACE3"

	    exit 1

	fi
	if [ ! -f "$TRACE_DIR/$TRACE4" ] ; then

	    echo "[ERROR] Cannot find a trace0 file: $TRACE_DIR/$TRACE4"

	    exit 1

	fi

	if [ ! -f "$TRACE_DIR/$TRACE5" ] ; then

	    echo "[ERROR] Cannot find a trace1 file: $TRACE_DIR/$TRACE5"

	    exit 1

	fi
	if [ ! -f "$TRACE_DIR/$TRACE6" ] ; then

	    echo "[ERROR] Cannot find a trace0 file: $TRACE_DIR/$TRACE6"

	    exit 1

	fi

	if [ ! -f "$TRACE_DIR/$TRACE7" ] ; then

	    echo "[ERROR] Cannot find a trace1 file: $TRACE_DIR/$TRACE7"

	    exit 1

	fi
	mkdir -p results_4core_${N_SIM}M

	(./bin/${BINARY} -warmup_instructions ${N_WARM}000000 -simulation_instructions ${N_SIM}000000 ${OPTION} -traces ${TRACE_DIR}/${TRACE0} ${TRACE_DIR}/${TRACE1} ${TRACE_DIR}/${TRACE2} ${TRACE_DIR}/${TRACE3} ${TRACE_DIR}/${TRACE4} ${TRACE_DIR}/${TRACE5} ${TRACE_DIR}/${TRACE6} ${TRACE_DIR}/${TRACE7})&> results_4core_${N_SIM}M/mix${N_MIX}-${BINARY}${OPTION}.txt

else
	echo "[ERROR]"
	exit 1
fi


#!/bin/sh
#
# scrip para avalair o desempenho de AutoCellCouner_Global_v127.ijm
#
# Mauro Morais, 2018-07-04
INDIR=/home/mauromorais/R/imgAnalysis/scripts
OUTDIR=/home/mauromorais/R/imgAnalysis/results/2018-08-09/AutoCount_fromCleanV13/performance

# loop para o n de vezes que o script será executado
for j in run01 run02 run03 run04 run05
do
	# loop para os métodos de threhsolding
	for i in Default Huang Intermodes IsoData IJ_IsoData Li MaxEntropy Mean MinError Minimum Moments Otsu Percentile RenyiEntropy Shanbhag Triangle Yen
	do
		/usr/bin/time -v --output=${OUTDIR}/time_results_${j}_${i}.txt ${HOME}/Fiji.app/ImageJ-linux64 --headless -macro ${INDIR}/AutoCellCounter_Global_v127.ijm ${i} > ${OUTDIR}/performance_${i}.txt
		echo "-----------"
		echo "$j $i DONE!"
		echo "-----------"
	done
	
	echo "--------"
	echo "$j DONE!"
	echo "--------"
done
	
echo "-------"
echo "Finish!"
echo "-------"
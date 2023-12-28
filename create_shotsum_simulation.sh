#!/bin/bash

# crea una simulazione fittizia per aggirare il bug in swarm_pos
# quando si tenta di leggere il file dai ritardi

# ***** inutili per il test ma solo per bug
tstart=0
length=6.00
shot_rate=10
shot_time_length=2
shot_start_time=2
avgTau_decay=1e-2
avgTau_raise=1e-3
bkg=1.6
rate=12
timedel=1e-4
# ***** 

ra_src=$(grep RA true_position.dat | awk '{print $2}')
de_src=$(grep Dec true_position.dat | awk '{print $2}')
n_bees=3
forbit="pos_n_pointing_3sateq.dat"

rm output_data.fits

swarm_sim --tstart ${tstart} --length ${length} --shot_rate ${shot_rate} \
	--shot_time_length ${shot_time_length} --shot_start_time ${shot_start_time} --avgTau_decay ${avgTau_decay} \
	--avgTau_raise ${avgTau_raise} --ra_src ${ra_src} --de_src ${de_src} --bkg ${bkg} \
	--rate ${rate} --n_bees ${n_bees} --timedel ${timedel} --forbit ${forbit}

rm HERMES*.arf 
rm swarmsim_results.dat
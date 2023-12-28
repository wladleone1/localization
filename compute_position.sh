#!/bin/bash

# indice delay da passare come parametro allo script
i_delay=$1

rm bee_*_${i_delay}.dat
rm best_position*_${i_delay}.dat
rm aitoff*_${i_delay}.pdf
rm best_fit_confidence_region_*_${i_delay}.dat

swarm_pos --forbit pos_n_pointing_3sateq.dat --use_ext_delays delays_${i_delay}.dat --calc_confidence_region
rm sky_chisq_mat_*.dat


./aitoff_plot.sh

mv aitoff.pdf aitoff_${i_delay}.pdf

mv best_position.dat best_position_${i_delay}.dat

mv bee_000_fov_region.dat bee_000_fov_region_${i_delay}.dat
mv bee_001_fov_region.dat bee_001_fov_region_${i_delay}.dat
mv bee_002_fov_region.dat bee_002_fov_region_${i_delay}.dat

mv best_fit_confidence_region_0.683.dat best_fit_confidence_region_0.683_${i_delay}.dat
mv best_fit_confidence_region_0.900.dat best_fit_confidence_region_0.900_${i_delay}.dat
mv best_fit_confidence_region_0.997.dat best_fit_confidence_region_0.997_${i_delay}.dat
mv best_fit_confidence_region_0.500.dat best_fit_confidence_region_0.500_${i_delay}.dat

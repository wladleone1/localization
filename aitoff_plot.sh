#!/usr/bin/gnuplot

prj_file = "projections.gnu"
mer_file = "worldmer15.dat"
par_file = "worldpar15.dat"

# Load projection function definitions
load prj_file

folder = "."

data_cr_1s = sprintf("%s/best_fit_confidence_region_0.683.dat", folder);
data_cr_3s = sprintf("%s/best_fit_confidence_region_0.997.dat", folder);


ra_src = system("grep RA true_position.dat | awk '{print $2}'")
de_src = system("grep Dec true_position.dat | awk '{print $2}'")
n_bees = system("grep n_bees create_shotsum_simulation.sh | head -1 | awk -F '=' '{print $2}'")


scale_factor = 0.2
p=AitoffInit(scale_factor)

set object ellipse at 0,0 size scale_factor * 360, scale_factor * 180

k = 25.0

# fa(ra, de) = -AitoffYC(de, ra <= 180 ? ra : ra - 360)
# fb(ra, de) = AitoffXC(de, ra <= 180 ? ra : ra - 360)

fa(ra, de) = AitoffYC(de, ra <= 180 ? ra : ra - 360)
fb(ra, de) = AitoffXC(de, ra <= 180 ? ra : ra - 360)

# Labels
do for [i=0:12] {
    _ra = 180
    _de = (1.0 * i - 6) * 15
    _a_x = fa(_ra, _de)
    _a_y = fb(_ra, _de)
    set label i+1 sprintf("%.0f°", _de) at _a_x, _a_y center \
	offset scale_factor * _a_x / 3, scale_factor * _a_y / 3
}

do for [i=0:11] {
    _ra = -180
    _de = (1.0 * i - 6) * 15
    _a_x = fa(_ra, _de)
    _a_y = fb(_ra, _de)
    set label i+20 sprintf("%.0f°", _de) at _a_x, _a_y center \
	offset scale_factor * _a_x / 3, scale_factor * _a_y / 3
}

do for [i=1:11] {
    _ra = (1.0 * i - 6.0) * 30
    _de = 0
    # print _ra,_de
    _a_x = fa(_ra, _de)
    _a_y = fb(_ra, _de)
    set label i+50 sprintf("%.0f°", _ra) at _a_x, _a_y center offset 0, -0.5
}

set term pdf enhan color size 21cm,15cm font ",10"
set output sprintf("%s/aitoff.pdf", folder);

set title "Confidence Regions" noenhanced offset 0,-5
set size ratio -1



# Main plot
 # prima il reticolo
  # poi i campi di vista
   # Poi le regioni di confidenza
plot mer_file using (fa($1,$2)):(fb($1,$2)) notit w l ls 2, \
     par_file using (fa($1,$2)):(fb($1,$2)) notit w l ls 3, \
     for [i=0:n_bees-1] folder.'/bee_00'.i.'_fov_region.dat' using (fa($1, $2)):(fb($1, $2)) with filledcurve fs transparent solid 0.25 lc "gray50" lw 2 title "B00".i." FoV", \
     data_cr_3s using (fa($1,$2)):(fb($1,$2)) with filledcurve fs transparent solid 0.5 title "CR 99.7\%", \
     data_cr_1s using (fa($1,$2)):(fb($1,$2)) with filledcurve fs transparent solid 0.5 title "CR 68.3\%", \
      "+" using (fa(ra_src,de_src)):(fb(ra_src,de_src)) with points pt 7 ps 0.2 lc "#00FFFF" title "true position"


unset output


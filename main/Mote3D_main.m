## Copyright (C) 2016 Henning Richter
##
## This is the main script of the 'Mote3D' toolbox for microstructure modelling.
##
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program. If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @ifnottex
## Mote3D is an interactive toolbox for modelling random particulate microstructures.
## @sp 1
## @noindent
## Copyright @copyright{} 2016 Henning Richter
## @sp 1
## @noindent
## The toolbox creates periodic particulate microstructure models by generating 
## random configurations of sphere-shaped particles within a predefined cubical
## domain based on a modified Random Sequential Addition algorithm.
## @sp 1
## @noindent
## Run Mote3D from the Octave editor or with the commands @code{run Mote3D_main} 
## or @code{Mote3D_main} (if the file Mote3D_main.m is located in the current 
## working directory) from the Octave workspace.
##
## @deftypefn Mote3D_main
##
## The following input variables need to be specified at start-up:@*
## @var{box_length} : edge length of the cubical domain@*
## @var{n_total}    : total number of particles@*
## @var{D_mean}     : mean of particle diameter distribution@*
## @var{D_sdev}     : standard deviation of particle diameter distribution@*
## @var{o_f}        : particle overlap factor@*
## @var{maxtrials}  : maximum number of positioning trials@*
## @var{sortstr}    : request sorting of the list of particle diameters@*
## @var{plotstr}    : request plotting of the generated microstructure@*
## @sp 1
## The following variables are required for voxel meshing:@*
## @var{el_number}  : number of elements on each edge of the cubical domain@*
## @var{el_type}    : Abaqus(TM) CAE element type (C3D8(R) or C3D20(R))@*
## @end deftypefn
##
## @noindent
## The positions and radii of the spherical particles are output to the text files 
## @cite{Positions.txt} and @cite{Radii.txt}.  The user-specified input variables 
## and statistical information about the generated microstructure are stored in the 
## text file @cite{Statistics.txt}.  Mote3D allows for an export of the generated 
## microstructure to Abaqus(TM) CAE software for further analysis.  The generated
## microstructure can be output as input script @cite{Abq_input_script.py} for 
## reconstruction in Abaqus(TM) CAE. Alternatively, a voxel mesh file 
## @cite{Abq_voxel_mesh.py} can be generated for import into Abaqus(TM) CAE software.  
## Abaqus(TM) is a registered trademark of Dassault Systemes or its subsidiaries 
## in the United States and/or other countries.
## @sp 1
## @noindent
## If you use Mote3D, please cite the following publication:@*
## @cite{Richter, Henning (2017) Mote3D: an open-source toolbox for modelling 
## periodic random particulate microstructures. Modelling and Simulation in 
## Materials Science and Engineering, Volume 25(3), 035011,
## @uref{http://doi.org/10.1088/1361-651X/aa629a}.}
## @end ifnottex
## @cindex Mote3D_main

## Author: Henning Richter <henning.richter@dlr.de>
## The development of Mote3D is supported by Deutsches Zentrum fuer Luft- und Raumfahrt e.V.
## License: GNU GPLv3+
## Created: April 2016
## Version: 2.1
## Keywords: random periodic microstructure

close all;
clear all;
clc;
format long;

## Specify input variables:
invar = {"Edge length of cubical domain:",
         "Total number of particles:",
         "Mean of particle diameter distribution:",
         "Standard deviation of particle diameter distribution:",
         "Particle overlap factor from the interval [0, 1]:\n(0 = full overlap, 1 = no overlap)",
         "Maximum number of trials to position particles:",
         "Sort particle diameters in descending order?:\n(y = yes, n = no)",
         "Plot particulate microstructure?:\n(y = yes, n = no)"};
default = {"5.0", "8", "1.0", "0.5", "0.9", "10000", "n", "n"};
instr = cell(8,1);
instr = inputdlg(invar, "Mote3D input variables", 1, default);

if (isempty(instr))
  disp("Program cancelled.");
  return;
endif

defstr = {instr{1}, instr{2}, instr{3}, instr{4}, instr{5}, instr{6}, instr{7}, instr{8}};

while ((sum(cellfun("isempty", defstr)) > 0) || ...
       (str2num(defstr{2}) < 2) || ...
       (sum(cellfun("str2num", defstr(1:6)) < 0) > 0) || ...
       (str2num(defstr{3}) >= str2num(defstr{1})) || ...
       (sum(strcmp(defstr{7}, {'y', 'n'})) == 0) || ...
       (sum(strcmp(defstr{8}, {'y', 'n'})) == 0))
  warndlg("Please check input!", "Warning");
  instr = inputdlg(invar, "Mote3D input variables", 1, defstr);
  defstr = {instr{1}, instr{2}, instr{3}, instr{4}, instr{5}, instr{6}, instr{7}, instr{8}};
endwhile

## Input variables:
box_length = str2num(defstr{1});
n_total = uint32(str2num(defstr{2}));
D_mean = str2num(defstr{3});
D_sdev = str2num(defstr{4});
o_f = str2num(defstr{5});
maxtrials = uint32(str2num(defstr{6}));
sortstr = defstr{7};
plotstr = defstr{8};

## Save input variables to text file:
fi1 = fopen("Statistics.txt", "wt");
fprintf(fi1,"\n");
fprintf(fi1,"Statistics of the microstructure generated by Mote3D:\n");
fprintf(fi1,"-----------------------------------------------------\n");
fprintf(fi1,"\n");
fprintf(fi1,"\n");
fprintf(fi1,"List of user-defined input variables:\n");
fprintf(fi1,"\n");
fprintf(fi1,"Edge length of cubical domain: %4.5f\n", box_length);
fprintf(fi1,"Total number of particles: %i\n", n_total);
fprintf(fi1,"Mean of particle diameter distribution: %4.5f\n", D_mean);
fprintf(fi1,"Standard deviation of particle diameter distribution: %4.5f\n", D_sdev);
fprintf(fi1,"Particle overlap factor: %4.5f\n", o_f);
fprintf(fi1,"Maximum number of trials to position particles: %i\n", maxtrials);
fprintf(fi1,"Sort particle diameters in descending order?: %s\n", sortstr);
fprintf(fi1,"\n");
fclose(fi1);

## Generate normal distribution of particle diameters:
D_gen(n_total,1) = 0;

if (D_sdev == 0)
  D_gen(1:n_total,1) = D_mean;
elseif (D_sdev > 0)
  D_gen(1:n_total,1) = normrnd(D_mean, D_sdev, [n_total,1]);
  D_gen = abs(D_gen);
  if (sortstr == 'y')
    D_gen = sort(D_gen, "descend");
  endif
endif

# If the list of particle diameters is to be read from an external text
# file "filename.txt", please uncomment the following line:
# D_gen = dlmread("filename.txt");

## Generate list of particle radii:
R_gen = 0.5.*D_gen;
R_gen(:,2) = vertcat(R_gen);
R_gen(:,1) = (1:1:length(R_gen))';

## Initialize data structure:
[P_mat, R_vec] = m3d_datastruct(n_total, box_length, R_gen, sortstr);
i = 9;
counter = 1;
w = waitbar(0, "Initializing particle positioning...", "Name", "Mote3D progress");
pause(1);

## Generate random particle positions:
[P_mat, R_vec, w, i] = m3d_randpack(P_mat, R_vec, R_gen, i, n_total, box_length, o_f, counter, maxtrials, w);

if ((i-1) < n_total)
  waitbar((single(i-1)/single(n_total)), w, "Maximum number of trials reached. Saving to text files...");
  n_plot = n_total-(i-1);
  n_total = (i-1);
else
  waitbar(1, w, "Particle positioning finished. Saving to text files...");
  n_plot = 0;
endif

pause(2);
close(w);

## Evaluate statistics of generated microstructure:
D_vec = 2.*R_vec(1:n_total,2);
nnlist(n_total,3) = 0;

## Compute nearest neighbour distances of all particles in the cubical domain:
for (i = 1:1:n_total)
  nn_dxdydz = bsxfun(@minus, P_mat(1:n_total,2:4), P_mat(i,2:4));
  nn_dist = sqrt(sum(nn_dxdydz.*nn_dxdydz, 2));
  nearest_dist = min(nn_dist(nn_dist > 0));
  nnlist(i,1:3) = [i, find(nn_dist == nearest_dist, 1, "first"), nearest_dist];
endfor

nnlist = sortrows(nnlist, 2);
ind_min = find(nnlist(:,3) == min(nnlist(:,3)), 1, "first");
ind_max = find(nnlist(:,3) == max(nnlist(:,3)), 1, "first");
o_f_min = min(nnlist(:,3))/(R_vec(nnlist(ind_min,1),2)+R_vec(nnlist(ind_min,2),2));

## Save particle positions and radii to text files:
dlmwrite("Positions.txt", P_mat(1:n_total,:), "precision", 12);
dlmwrite("Radii.txt", R_vec(1:n_total,:), "precision", 12);

fi1 = fopen("Statistics.txt", "at");
fprintf(fi1,"\n");
fprintf(fi1,"\n");
fprintf(fi1,"Actual distribution of particle diameters:\n");
fprintf(fi1,"\n");
fprintf(fi1,"Arithmetic mean: %4.5f\n", mean(D_vec));
fprintf(fi1,"Standard deviation: %4.5f\n", std(D_vec));
fprintf(fi1,"Minimum diameter: %4.5f\n", min(D_vec));
fprintf(fi1,"Maximum diameter: %4.5f\n", max(D_vec));
fprintf(fi1,"\n");
fprintf(fi1,"\n");
fprintf(fi1,"\n");
fprintf(fi1,"Actual distribution of nearest-neighbour distances:\n");
fprintf(fi1,"\n");
fprintf(fi1,"Arithmetic mean: %4.5f\n", mean(nnlist(:,3)));
fprintf(fi1,"Standard deviation: %4.5f\n", std(nnlist(:,3)));
fprintf(fi1,"Minimum nn distance: %4.5f for particles %i and %i\n", min(nnlist(:,3)), nnlist(ind_min,1), nnlist(ind_min,2));
fprintf(fi1,"Maximum nn distance: %4.5f for particles %i and %i\n", max(nnlist(:,3)), nnlist(ind_max,1), nnlist(ind_max,2));
fprintf(fi1,"\n");
fprintf(fi1,"Actual total number of particles: %i\n", n_total);
fprintf(fi1,"Actual minimum particle overlap factor: %4.5f\n", o_f_min);
fprintf(fi1,"\n");
fclose(fi1);

## Generate input file for external CAE-based analyses:
dbound = 2*max(R_vec(:,2));
P_ind = P_mat(P_mat(:,2) > (box_length-dbound) & P_mat(:,3) > (box_length-dbound) & P_mat(:,4) > (box_length-dbound) & ...
              P_mat(:,2) < (2*box_length+dbound) & P_mat(:,3) < (2*box_length+dbound) & P_mat(:,4) < (2*box_length+dbound), 1);

P_ind(n_total+1,1) = 0;
P_ind = [P_ind(P_ind(:,1) > 0)];
PR_mat = [P_mat(P_ind,2:4), R_vec(P_ind,2)];
PR_mat = unique(PR_mat, "rows");
P_mat_ind(length(PR_mat(:,1)),4) = 0;
P_mat_ind(:,2:4) = PR_mat(:,1:3);
P_mat_ind(:,1) = (1:1:length(PR_mat(:,1)))';
R_vec_ind(:,2) = PR_mat(:,4);
R_vec_ind(:,1) = (1:1:length(PR_mat(:,1)))';

## Define output format:
usprom = sprintf("Please choose an output format for the export to external CAE software!\n'Input script': Create Abaqus(TM) CAE input script.\n'Voxel mesh': Create Abaqus(TM) CAE voxel mesh.");
uschc = questdlg(usprom, "Mote3D output format", "Voxel mesh", "Input script", "Cancel", "Cancel");

termflag = 0;
switch (uschc)
  case "Input script"
    disp("Generating input script...");
    [termflag] = m3d_inputgen(P_mat_ind, R_vec_ind, box_length, termflag);
    if (termflag == 1)
      disp("Input script generated.");
    endif
  case "Voxel mesh"
    vxvar = {"Number of elements on each edge:",
             "Abaqus(TM) CAE element type:\n(C3D8, C3D8R, C3D20 or C3D20R)"};
    vxdflt = {"50", "C3D8"};
    vxstr = cell(2,1);
    vxstr = inputdlg(vxvar, "Mote3D voxel mesh generation", 1, vxdflt);
    if (isempty(vxstr))
      disp("Program cancelled.");
      return;
    endif
    while ((sum(cellfun("isempty", vxstr)) > 0) || ...
           (isscalar(str2num(vxstr{1})) == 0) || ...
           (sum(strcmp(vxstr{2}, {'C3D8', 'C3D8R', 'C3D20', 'C3D20R'})) == 0))
      warndlg("Please check input!", "Warning");
      vxstr = inputdlg(vxvar, "Mote3D voxel mesh generation", 1, vxdflt);
    endwhile
    el_number = uint32(str2num(vxstr{1}));
    el_type = vxstr{2};
    disp("Generating voxel mesh...");
    [termflag] = m3d_vxmesh(P_mat_ind, R_vec_ind, box_length, el_number, el_type, termflag);
    if (termflag == 1)
      disp("Voxel mesh generated.");
    endif
  otherwise
    disp("Program terminated.");
endswitch

## Plot particulate microstructure:
if (plotstr == 'y')
  disp("Creating plot...");
  figure("name", "Mote3D particulate microstructure", "numbertitle", "off");
  [XS_k, YS_k, ZS_k] = sphere(16);
  hold on;
  stvar = n_total+n_plot+1;
  endvar = 2*(n_total+n_plot);
  for (k = stvar:1:endvar)
    surf(XS_k*R_vec(k,2)+P_mat(k,2), YS_k*R_vec(k,2)+P_mat(k,3), ZS_k*R_vec(k,2)+P_mat(k,4), "facecolor", [0.749, 0.796, 0.851]);
  endfor
  hold off;
  axis([0, box_length, 0, box_length, 0, box_length], "square");
  xlabel("X"), ylabel("Y"), zlabel("Z");
  box on, view(-37.5, 17);
  disp("Plot created.");
endif

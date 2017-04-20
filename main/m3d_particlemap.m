## Copyright (C) 2016 Henning Richter
##
## This function file is part of the 'Mote3D' toolbox for microstructure modelling.
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
## @deftypefn {Function File} {@var{P_mat}, @var{R_vec} =} m3d_particlemap(@var{P_mat}, @var{R_vec},
## @var{i}, @var{n_total}, @var{box_length})
##
## Generate additional particles to assure periodicity of the microstructure.
##
## Create additional particles with radii @var{R_vec} for each particle @var{i}
## of the @var{n_total} particles at opposing positions @var{P_mat} around the
## cubical domain with edge length @var{box_length} in order to assure periodicity
## of the random particulate microstructure.
## @end deftypefn
## @cindex m3d_particlemap

## Author: Henning Richter <henning.richter@dlr.de>
## Created: April 2016
## Keywords: particle mapping, random periodic microstructure

function [P_mat, R_vec] = m3d_particlemap(P_mat, R_vec, i, n_total, box_length)

  ## Map particles:
  P_mat((n_total+i),2:4) = P_mat(i,2:4)-box_length;
  R_vec((n_total+i),2) = R_vec(i,2);
  P_mat((2*n_total+i),2) = P_mat(i,2);
  P_mat((2*n_total+i),3:4) = P_mat(i,3:4)-box_length;
  R_vec((2*n_total+i),2) = R_vec(i,2);
  P_mat((3*n_total+i),2) = P_mat(i,2)+box_length;
  P_mat((3*n_total+i),3:4) = P_mat(i,3:4)-box_length;
  R_vec((3*n_total+i),2) = R_vec(i,2);
  P_mat((4*n_total+i),2) = P_mat(i,2)-box_length;
  P_mat((4*n_total+i),3) = P_mat(i,3);
  P_mat((4*n_total+i),4) = P_mat(i,4)-box_length;
  R_vec((4*n_total+i),2) = R_vec(i,2);
  P_mat((5*n_total+i),2:3) = P_mat(i,2:3);
  P_mat((5*n_total+i),4) = P_mat(i,4)-box_length;
  R_vec((5*n_total+i),2) = R_vec(i,2);
  P_mat((6*n_total+i),2) = P_mat(i,2)+box_length;
  P_mat((6*n_total+i),3) = P_mat(i,3);
  P_mat((6*n_total+i),4) = P_mat(i,4)-box_length;
  R_vec((6*n_total+i),2) = R_vec(i,2);
  P_mat((7*n_total+i),2) = P_mat(i,2)-box_length;
  P_mat((7*n_total+i),3) = P_mat(i,3)+box_length;
  P_mat((7*n_total+i),4) = P_mat(i,4)-box_length;
  R_vec((7*n_total+i),2) = R_vec(i,2);
  P_mat((8*n_total+i),2) = P_mat(i,2);
  P_mat((8*n_total+i),3) = P_mat(i,3)+box_length;
  P_mat((8*n_total+i),4) = P_mat(i,4)-box_length;
  R_vec((8*n_total+i),2) = R_vec(i,2);
  P_mat((9*n_total+i),2:3) = P_mat(i,2:3)+box_length;
  P_mat((9*n_total+i),4) = P_mat(i,4)-box_length;
  R_vec((9*n_total+i),2) = R_vec(i,2);
  P_mat((10*n_total+i),2:3) = P_mat(i,2:3)-box_length;
  P_mat((10*n_total+i),4) = P_mat(i,4);
  R_vec((10*n_total+i),2) = R_vec(i,2);
  P_mat((11*n_total+i),2) = P_mat(i,2);
  P_mat((11*n_total+i),3) = P_mat(i,3)-box_length;
  P_mat((11*n_total+i),4) = P_mat(i,4);
  R_vec((11*n_total+i),2) = R_vec(i,2);
  P_mat((12*n_total+i),2) = P_mat(i,2)+box_length;
  P_mat((12*n_total+i),3) = P_mat(i,3)-box_length;
  P_mat((12*n_total+i),4) = P_mat(i,4);
  R_vec((12*n_total+i),2) = R_vec(i,2);
  P_mat((13*n_total+i),2) = P_mat(i,2)-box_length;
  P_mat((13*n_total+i),3:4) = P_mat(i,3:4);
  R_vec((13*n_total+i),2) = R_vec(i,2);
  P_mat((14*n_total+i),2) = P_mat(i,2)+box_length;
  P_mat((14*n_total+i),3:4) = P_mat(i,3:4);
  R_vec((14*n_total+i),2) = R_vec(i,2);
  P_mat((15*n_total+i),2) = P_mat(i,2)-box_length;
  P_mat((15*n_total+i),3) = P_mat(i,3)+box_length;
  P_mat((15*n_total+i),4) = P_mat(i,4);
  R_vec((15*n_total+i),2) = R_vec(i,2);
  P_mat((16*n_total+i),2) = P_mat(i,2);
  P_mat((16*n_total+i),3) = P_mat(i,3)+box_length;
  P_mat((16*n_total+i),4) = P_mat(i,4);
  R_vec((16*n_total+i),2) = R_vec(i,2);
  P_mat((17*n_total+i),2:3) = P_mat(i,2:3)+box_length;
  P_mat((17*n_total+i),4) = P_mat(i,4);
  R_vec((17*n_total+i),2) = R_vec(i,2);
  P_mat((18*n_total+i),2:3) = P_mat(i,2:3)-box_length;
  P_mat((18*n_total+i),4) = P_mat(i,4)+box_length;
  R_vec((18*n_total+i),2) = R_vec(i,2);
  P_mat((19*n_total+i),2) = P_mat(i,2);
  P_mat((19*n_total+i),3) = P_mat(i,3)-box_length;
  P_mat((19*n_total+i),4) = P_mat(i,4)+box_length;
  R_vec((19*n_total+i),2) = R_vec(i,2);
  P_mat((20*n_total+i),2) = P_mat(i,2)+box_length;
  P_mat((20*n_total+i),3) = P_mat(i,3)-box_length;
  P_mat((20*n_total+i),4) = P_mat(i,4)+box_length;
  R_vec((20*n_total+i),2) = R_vec(i,2);
  P_mat((21*n_total+i),2) = P_mat(i,2)-box_length;
  P_mat((21*n_total+i),3) = P_mat(i,3);
  P_mat((21*n_total+i),4) = P_mat(i,4)+box_length;
  R_vec((21*n_total+i),2) = R_vec(i,2);
  P_mat((22*n_total+i),2:3) = P_mat(i,2:3);
  P_mat((22*n_total+i),4) = P_mat(i,4)+box_length;
  R_vec((22*n_total+i),2) = R_vec(i,2);
  P_mat((23*n_total+i),2) = P_mat(i,2)+box_length;
  P_mat((23*n_total+i),3) = P_mat(i,3);
  P_mat((23*n_total+i),4) = P_mat(i,4)+box_length;
  R_vec((23*n_total+i),2) = R_vec(i,2);
  P_mat((24*n_total+i),2) = P_mat(i,2)-box_length;
  P_mat((24*n_total+i),3:4) = P_mat(i,3:4)+box_length;
  R_vec((24*n_total+i),2) = R_vec(i,2);
  P_mat((25*n_total+i),2) = P_mat(i,2);
  P_mat((25*n_total+i),3:4) = P_mat(i,3:4)+box_length;
  R_vec((25*n_total+i),2) = R_vec(i,2);
  P_mat((26*n_total+i),2) = P_mat(i,2)+box_length;
  P_mat((26*n_total+i),3:4) = P_mat(i,3:4)+box_length;
  R_vec((26*n_total+i),2) = R_vec(i,2);

  P_mat((n_total+1):27*n_total,1) = ((n_total+1):1:27*n_total)';
  R_vec((n_total+1):27*n_total,1) = ((n_total+1):1:27*n_total)';

endfunction

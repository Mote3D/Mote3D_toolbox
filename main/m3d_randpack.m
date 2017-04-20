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
## @deftypefn {Function File} {@var{P_mat}, @var{R_vec}, @var{w}, @var{i} =} m3d_randpack(@var{P_mat}, @var{R_vec},
## @var{R_gen}, @var{i}, @var{n_total}, @var{box_length}, @var{o_f}, @var{counter}, @var{maxtrials}, @var{w})
##
## Create a random particle packing.
##
## Sequentially generate @var{n_total} random positions @var{P_mat} of spherical
## particles in a cubical domain with edge length @var{box_length} and randomly
## assign particle radii @var{R_vec} from the predefined radius list @var{R_gen}.
## Overlap between adjacent particles is controlled via the particle overlap
## factor @var{o_f}.
##
## Each failed positioning trial @var{i} is stored in @var{counter}, and if the
## user-specified maximum number of trials @var{maxtrials} has been reached,
## execution of the function is terminated.  The variable @var{w} is the handle to
## the @code{waitbar} object.
## @end deftypefn
## @cindex m3d_randpack

## Author: Henning Richter <henning.richter@dlr.de>
## Created: April 2016
## Keywords: particle packing, random periodic microstructure

function [P_mat, R_vec, w, i] = m3d_randpack(P_mat, R_vec, R_gen, i, n_total, box_length, o_f, counter, maxtrials, w)

  ## Choose positioning algorithm:
  if (max(R_gen(:,2))-min(R_gen(:,2)) == 0)

    ## Generate random particle positions for mono-sized particles:
    while (i <= n_total && counter <= maxtrials)
      R_vec(i,:) = R_gen(i,:);
      P_mat(i,:) = [i, box_length+box_length.*rand(1,3)];

      ## Compute inter-particle distances:
      N_mat = P_mat;
      dxdydz = bsxfun(@minus, N_mat(:,2:4), P_mat(i,2:4));
      dist_trans = sqrt(sum(dxdydz.*dxdydz, 2));
      dist_nearest = min(dist_trans(dist_trans > 0));
      ind_nearest = find(dist_trans == dist_nearest);
      ind_nearest_dxdydz = ind_nearest(1);
      ind_nearest = N_mat(ind_nearest_dxdydz,1);
      R_trans = o_f*(R_vec(i,2)+R_vec(ind_nearest,2));
      dist_eff_nearest = dist_nearest-R_trans;

      ## Check position of particle i:
      if (dist_eff_nearest < 0)
        ++counter;
        continue;
      elseif (dist_eff_nearest >= 0)
        exeyez = dxdydz(ind_nearest_dxdydz,:);
        exeyez = bsxfun(@rdivide, exeyez, dist_nearest);

        ## Translate particle i:
        P_mat(i,2:4) = P_mat(i,2:4)+dist_eff_nearest.*exeyez;

        ## Update particle positions:
        [P_mat, R_vec] = m3d_particlemap(P_mat, R_vec, i, n_total, box_length);
        waitbar((single(i)/single(n_total)), w, "Generating particle positions...");
        i = i+1;
      endif
    endwhile

  elseif (max(R_gen(:,2))-min(R_gen(:,2)) > 0)

    ## Generate random particle positions for distributed particle diameters:
    while (i <= n_total && counter <= maxtrials)
      R_vec(i,:) = R_gen(i,:);
      P_mat(i,:) = [i, box_length+box_length.*rand(1,3)];

      ## Compute inter-particle distances:
      N_mat = P_mat;
      dxdydz = bsxfun(@minus, N_mat(:,2:4), P_mat(i,2:4));
      dist_trans = sqrt(sum(dxdydz.*dxdydz, 2));
      R_trans = o_f.*bsxfun(@plus, R_vec(i,2), R_vec(:,2));
      dist_eff = dist_trans-R_trans;
      dist_eff_nearest = min(dist_eff(dist_eff > 0));
      ind_nearest = find(dist_eff == dist_eff_nearest);
      ind_nearest_dxdydz = ind_nearest(1);

      ## Check position of particle i:
      if (sum(dist_eff < 0) > 1)
        ++counter;
        continue;
      elseif (sum(dist_eff < 0) <= 1)
        exeyez = dxdydz(ind_nearest_dxdydz,:);
        exeyez = bsxfun(@rdivide, exeyez, dist_trans(ind_nearest_dxdydz));

        ## Translate particle i:
        P_mat(i,2:4) = P_mat(i,2:4)+dist_eff_nearest.*exeyez;

        ## Update particle positions:
        [P_mat, R_vec] = m3d_particlemap(P_mat, R_vec, i, n_total, box_length);
        waitbar((single(i)/single(n_total)), w, "Generating particle positions...");
        i = i+1;
      endif
    endwhile

  endif

endfunction

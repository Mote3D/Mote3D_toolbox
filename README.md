## Mote3D

[![doi](https://img.shields.io/badge/doi-10.1088%2F1361--651X%2Faa629a-blue.svg)](http://doi.org/10.1088/1361-651X/aa629a)
[![latest release](https://img.shields.io/github/release/Mote3D/Mote3D_toolbox.svg)](http://github.com/Mote3D/Mote3D_toolbox/releases/tag/v2.1)

##### Update: the current release is [version 2.1](https://github.com/Mote3D/Mote3D_toolbox/releases/tag/v2.1), a new release is coming soon.

#### Description

Mote3D is an adaptable, easy-to-use open-source software toolbox for the generation of random particulate 
microstructure models with periodic boundaries. Mote3D can be used to generate virtual models 
that represent the microstructure of various inhomogeneous engineering materials such 
as particle-reinforced composites, partially sintered ceramics, powders, open-cell foams or 
concrete aggregates, as well as of certain nanomaterials, biomaterials or scaffolds. These models can be 
employed, for example, to analyse the relation between microstructure and overall mechanical, 
electrical or thermal properties by virtual materials testing.

![Exemplary microstructure models](docs/examples/microstructures.jpg "Exemplary microstructure models")

The Mote3D toolbox works by randomly positioning spherical particles with user-defined 
minimum inter-particle distance in a cubical computational domain. The generated 
microstructure models can be exported in different formats, either as lists of particle 
centre coordinates and radii or as input scripts for generating solid geometric models 
or regular hexahedral meshes (*voxel meshes*) in the commercial finite-element software
Abaqus&#8482; or similar preprocessors. Mote3D reports basic statistical information on the generated 
microstructure models such as particle diameter distribution and nearest neighbour inter-particle distances.

![Mesh options](docs/examples/meshes.jpg "Mesh options")

#### References

Richter, Henning (2017) *Mote3D: an open-source toolbox for modelling periodic random particulate microstructures.* Modelling Simul. Mater. Sci. Eng. 25 (3), 035011, [doi: 10.1088/1361-651X/aa629a](https://doi.org/10.1088/1361-651X/aa629a) ([DLR elib entry](https://elib.dlr.de/111667/)).

Richter, Henning (2019) *Random porous microstructure modelling with the Mote3D toolbox – approach and applications.* Sitzung des Arbeitskreises Mikrostrukturmechanik im DGM-Fachausschuss Computersimulation, Mai 2019, DLR Köln.

#### Installation

Mote3D requires [GNU Octave](http://www.gnu.org/software/octave/download.html) version 4.2.0 or earlier. If a later version is used, additional installation of the [GNU Octave statistics package](https://octave.sourceforge.io/statistics/index.html) may be required for some features. Download the [latest release](https://github.com/Mote3D/Mote3D_toolbox/releases) of Mote3D and unpack the folder to the [GNU Octave](http://www.gnu.org/software/octave/download.html) working directory. Additional information on how to set up and run Mote3D can be found in the [Mote3D User Guide](docs/Mote3D%20User%20Guide.pdf).

#### Documentation

Further details on the implementation and some case studies are outlined in [this paper](https://doi.org/10.1088/1361-651X/aa629a). Additional examples are given in the Mote3D [wiki](https://github.com/Mote3D/Mote3D_toolbox/wiki).

#### License

Mote3D is licensed under the [GNU General Public License](https://github.com/Mote3D/Mote3D_toolbox/blob/master/LICENSE.txt).


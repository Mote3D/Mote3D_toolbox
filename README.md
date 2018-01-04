## Mote3D

[![doi](https://img.shields.io/badge/doi-10.1088%2F1361--651X%2Faa629a-blue.svg)](http://doi.org/10.1088/1361-651X/aa629a)
[![latest release](https://img.shields.io/github/release/Mote3D/Mote3D_toolbox.svg)](http://github.com/Mote3D/Mote3D_toolbox/releases/tag/v2.1)
[![downloads](https://img.shields.io/github/downloads/Mote3D/Mote3D_toolbox/latest/total.svg)](http://github.com/Mote3D/Mote3D_toolbox/releases/tag/v2.1)
[![counter](https://img.shields.io/github/search/Mote3D/Mote3D_toolbox/goto.svg)](http://github.com/Mote3D/Mote3D_toolbox)

Update: Interface for geometry export to Ansys&#8482; DesignModeler as well as STEP and IGES is available, please inquire for details.

Mote3D is an adaptable, easy-to-use, open-source software toolbox for the generation of random particulate 
microstructure models with periodic boundaries. Mote3D can be used to generate models 
that represent the microstructure of various inhomogeneous engineering materials such 
as particle-reinforced composites, partially sintered ceramics, powders, open-cell foams or 
concrete aggregates as well as of certain biomaterials or scaffolds. These models can be 
employed, for example, to analyse the relation between microstructure and overall mechanical, 
electrical or thermal properties by virtual material testing.

![Exemplary microstructure models](docs/examples/microstructures.jpg "Exemplary microstructure models")

The Mote3D toolbox works by randomly positioning spherical particles with user-defined 
minimum inter-particle distance in a cubical computational domain. The generated 
microstructure models can be exported in different formats, either as lists of particle 
centre coordinates and radii or as input scripts for generating solid geometric models 
or regular hexahedral meshes (*voxel meshes*) in the commercial finite-element software
Abaqus&#8482; or similar preprocessors. Mote3D reports basic statistical information on the generated 
microstructure models such as particle diameter distribution and nearest neighbour inter-particle distances.

![Mesh options](docs/examples/meshes.jpg "Mesh options")

Mote3D requires [GNU Octave](http://www.gnu.org/software/octave/download.html). Additional
information on how to set up and run Mote3D can be found in the [Mote3D User Guide](docs/Mote3D%20User%20Guide.pdf). 
Further details on the implementation and some case studies are outlined in [this paper](https://doi.org/10.1088/1361-651X/aa629a).

Mote3D is licensed under the [GNU General Public License](LICENSE.txt).

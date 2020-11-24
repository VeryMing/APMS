% Cellular automata: 3D (2D compatable) burning algrithm in percolation analysis
% Programmer: Mingzhi Wang
% Date: 11/24/2020
% Modified Version: v1.0
% Environment: Octave-5.2.0
% Description: The burning algrithm in percolation analysis

clear 
load Example_matrix_I %One of the two examples(_I, _II)
%Assign the nerwork matrix
Network=samples;
%Extract the size of matrix
[ny,nx,nz]=size(samples);
%define the intial 'fire' matrix
fire=zeros(ny,nx,nz);
fire(ceil(ny/2),:,:)=1;
%Neighbouring array:3D Moore neighbourhood
e_y=[0,0,1,-1,0,0,1,-1,0,0,1,1,1,-1,0,0,-1,-1,1,-1,1,1,-1,-1,1,-1];
e_x=[1,-1,0,0,0,0,1,1,1,1,0,0,-1,-1,-1,-1,0,0,1,1,-1,1,-1,1,-1,-1];
e_z=[0,0,0,0,1,-1,0,0,1,-1,1,-1,0,0,1,-1,1,-1,1,1,1,-1,1,-1,-1,-1];
%Set fire on the y boundary network
Network_burnt=fire.*Network;
temp=zeros(ny,nx,nz);
%Let it be fire
 while sum(sum(sum(Network_burnt-temp)))~=0
    %previous fire
     temp=Network_burnt;
     for jj=1:26
       Network_burnt=Network_burnt+circshift(temp,[e_y(jj),e_x(jj),e_z(jj)]);
     end
     Network_burnt=Network_burnt>0;
     %current fire
     Network_burnt=Network_burnt.*Network;
 end%end of while
 %Calculate the volumetric fraction of the network (network/volume)
 x_VF=sum(sum(sum(Network)))/(ny*nx*nz)
 %Calculate the fraction of connection in the network (connected network/netwrok)
 y_FC=sum(sum(sum(Network_burnt)))/sum(sum(sum(Network)))

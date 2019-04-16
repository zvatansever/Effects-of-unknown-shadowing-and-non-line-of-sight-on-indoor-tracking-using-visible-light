%==========================================================================
% SMC demos [Sequential Monte Carlo demos]
%--------------------------------------------------------------------------
%  (C) Fabien Campillo
%  Fabien.Campillo@inria.fr                                   
%  INRIA                                    
%  version 1.0 - March 2009               
%--------------------------------------------------------------------------
% This set of matlab codes proposes some basic applications of sequential
% Monte Carlo (particle filtering). 
%--------------------------------------------------------------------------
% See LEGAL NOTICE (LEGAL-NOTICE.txt) in this directory.
%==========================================================================



function indices = f_resample_indices(ftable)
% =========================================================================
% function indices = f_resample_indices(ftable)
% to be used after a reseampling algo
% INPUT a table [i1 i2 ... in]
%        ij : means that point #j has been drawn ij times
% OUTPUT  [1*ones(1,i1) 2*ones(1,i2) ... n*ones(1;in)]
% ex.   mult([0   2   0   2   1   1])
%     gives  [2   2   4   4   5   6]
% solution proposed by Zhang Qinghua (Irisa)
% =========================================================================
fftable    = cumsum(ftable+1);
a          = zeros(1,fftable(end));
a(fftable) = 1;
aa         = cumsum(a);
indices    = aa(~a)+1;
% =========================================================================
% Author: Fabien Campillo Fabien.Campillo@inria.fr 
% This source code is freely distributed for educational, research and 
% non-profit purposes. Permission to use it in commercial products may 
% be obtained from the author.
% =========================================================================

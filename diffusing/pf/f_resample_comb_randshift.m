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


function offsprings=f_resample_comb_randshift(weights)
% =========================================================================
% function offsprings=f_resample_comb(weights)
% the "comb" algo with a random shift
% Genshiro Kitagawa, Monte Carlo filter and smoother for
%    non-Gaussian nonlinear state space models, 
%    Journal of Computational and Graphical Statistics, 5(1), 1-25, 1996.
% =========================================================================
  n_weights     = length(weights);
  weights       = cumsum(weights)+rand/n_weights;
  weights       = weights/weights(end);
  weights       = floor(weights*n_weights);
  offsprings    = [weights(1) weights(2:n_weights)-weights(1:n_weights-1)];
% =========================================================================
% Author: Fabien Campillo. 
% This source code is freely distributed for educational, research and 
% non-profit purposes. Permission to use it in commercial products may 
% be obtained from the author.
% =========================================================================


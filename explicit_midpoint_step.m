%This function computes the value of X at the next time step
%using the explicit midpoint approximation
%INPUTS:
%rate_func_in: the function used to compute dXdt. rate_func_in will
% have the form: dXdt = rate_func_in(t,X) (t is before X)
%t: the value of time at the current step
%XA: the value of X(t)
%h: the time increment for a single step i.e. delta_t = t_{n+1} - t_{n}
%OUTPUTS:
%XB: the approximate value for X(t+h) (the next step)
% formula depends on the integration method used
%num_evals: A count of the number of times that you called
% rate_func_in when computing the next step
function [XB,num_evals] = explicit_midpoint_step(rate_func_in,t,XA,h)
    % num_evals starts at 0;
    num_evals = 0;

    % create rate function wrapper to track num_evals. add 1 each call
    function dXdt = rate_func_wrapper(a, b)
        dXdt = rate_func_in(a, b);
        num_evals = num_evals + 1;
    end

    
    % Midpoint method step 1
    X_half = XA + (h/2)*rate_func_wrapper(t, XA);
    XB = XA + h*rate_func_wrapper(t+h/2, X_half);
end
%This function computes the value of X at the next time step
%using the implicit midpoint approximation
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
function [XB,num_evals] = implicit_midpoint_step(rate_func_in,t,XA,h)

    % calculate N so step size is close/less than h_ref
    N = ceil((tspan(2)-tspan(1))/h_ref);
    % create t_list based on N
    t_list = linspace(tspan(1), tspan(2), N+1);
    h_avg = (tspan(2)-tspan(1))/N;

    % initialize variables
    X_list = zeros(N+1,length(X0));
    num_evals = 0;
    X = X0;
    X_list(1,:) = X0';

    for i = 1:N
        [X, evals] = explicit_midpoint_step(rate_func_in, t_list(i), X, h_avg);
        X_list(i+1,:) = X';
        num_evals = num_evals + evals;
    end
end
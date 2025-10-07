% Day 10 solving equation 5
close
clear all

tspan = [0 10]
figure()
[t_list,X_list,h_avg, num_evals] = forward_euler_fixed_step_integration(@rate_func01, tspan, 1, 0.5);

plot(t_list, X_list)
hold on
fplot(@(t) solution01(t), tspan)

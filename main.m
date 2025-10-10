% Day 10 solving equation 5
close
clear all


% ----------    IMPLEMENTING FORWARD EULER --------------------
tspan = [0 10];
figure()
[t_list_FE,X_list_FE,h_avg_FE, num_evals_FE] = forward_euler_fixed_step_integration(@rate_func01, tspan, 1, 0.2);
[t_list_MP,X_list_MP,h_avg_MP, num_evals_MP] = explicit_midpoint_fixed_step_integration(@rate_func01, tspan, 1, 0.2);

hold on
plot(t_list_FE, X_list_FE, 'DisplayName', 'Forward Euler')
plot(t_list_MP, X_list_MP, 'DisplayName', 'Explicit Midpoint')

fplot(@(t) solution01(t), tspan, 'DisplayName', 'analytical')
legend
xlabel("time")
ylabel("x(t)")

% ------------------ EXPLICIT MIDPOINT METHOD -----------------
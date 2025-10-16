clear
close all
% 
% % ------------------ IMPLEMENTING EXPLICIT METHODS ----------------------
% tspan = [0 10];
% h = 0.2;
% X0_01 = 1;
% 
% [t_list_FE,X_list_FE,h_avg_FE, num_evals_FE] = forward_euler_fixed_step_integration(@rate_func01, tspan, X0_01, h);
% [t_list_MP,X_list_MP,h_avg_MP, num_evals_MP] = explicit_midpoint_fixed_step_integration(@rate_func01, tspan, X0_01, h);
% 
% tlist_analytical1 = linspace(tspan(1),tspan(2),1000);
% solution_vals1 = solution01(tlist_analytical1);
% 
% figure(1);
% hold on
% plot(t_list_FE, X_list_FE, 'DisplayName', 'Forward Euler')
% plot(t_list_MP, X_list_MP, 'DisplayName', 'Explicit Midpoint')
% plot(tlist_analytical1,solution_vals1, 'DisplayName', 'analytical');
% legend
% xlabel("time")
% ylabel("x(t)")
% title('Function 01')
% 
% tspan = [0 10];
% h = 0.2;
% X0_02 = [1;0];
% 
% [t_list_FE,X_list_FE,h_avg_FE, num_evals_FE] = forward_euler_fixed_step_integration(@rate_func02, tspan, X0_02, h);
% [t_list_MP,X_list_MP,h_avg_MP, num_evals_MP] = explicit_midpoint_fixed_step_integration(@rate_func02, tspan, X0_02, h);
% 
% tlist_analytical2 = linspace(tspan(1),tspan(2),1000);
% solution_vals2 = solution02(tlist_analytical2);
% 
% 
% figure(2);
% 
% subplot(2,1,1)
% hold on
% plot(t_list_FE, X_list_FE(:,1), 'DisplayName', 'Forward Euler')
% plot(t_list_MP, X_list_MP(:,1), 'DisplayName', 'Explicit Midpoint')
% plot(tlist_analytical2,solution_vals2(1,:), 'DisplayName', 'analytical');
% legend
% xlabel('t')
% ylabel('x(t)')
% title('Function 02 x-values')
% 
% subplot(2,1,2)
% hold on
% plot(t_list_FE, X_list_FE(:,2), 'DisplayName', 'Forward Euler')
% plot(t_list_MP, X_list_MP(:,2), 'DisplayName', 'Explicit Midpoint')
% plot(tlist_analytical2,solution_vals2(2,:), 'DisplayName', 'analytical');
% legend
% xlabel('t')
% ylabel('x(t)')
% title('Function 02 y-values')
% 
% % ------------------ LOCAL TRUNCATION ERROR EXPLICIT -----------------
% 
% t_ref =  0.492;
% 
% filter_params = struct();
% filter_params.max_xval = 0.1;
% [h_list_01, analytical_difference_01, e_local_FE_01, e_local_MP_01] = local_truncation_error(@rate_func01, @solution01, t_ref);
% [p_FE_01,k_FE_01] = loglog_fit(h_list_01,e_local_FE_01, filter_params)
% [p_MP_01,k_MP_01] = loglog_fit(h_list_01,e_local_MP_01, filter_params)
% 
% [h_list_02, analytical_difference_02, e_local_FE_02, e_local_MP_02] = local_truncation_error(@rate_func02, @solution02, t_ref);
% [p_FE_02,k_FE_02] = loglog_fit(h_list_02,e_local_FE_02, filter_params)
% [p_MP_02,k_MP_02] = loglog_fit(h_list_02,e_local_MP_02, filter_params)
% 
% figure(3)
% loglog(h_list_01,analytical_difference_01, 'DisplayName', 'Analytical Difference');
% hold on
% loglog(h_list_01, e_local_FE_01, 'DisplayName', 'Forward Euler Error')
% loglog(h_list_01, e_local_MP_01, 'DisplayName', 'Explicit Midpoint Error')
% loglog(h_list_01, k_FE_01*h_list_01.^p_FE_01, 'DisplayName', 'FE linear')
% loglog(h_list_01, k_MP_01*h_list_01.^p_MP_01, 'DisplayName', 'MP linear')
% title("Local Truncation Error Function 01")
% legend
% 
% figure(4)
% loglog(h_list_02,analytical_difference_02, 'DisplayName', 'Analytical Difference');
% hold on
% loglog(h_list_02, e_local_FE_02, 'DisplayName', 'Forward Euler Error')
% loglog(h_list_02, e_local_MP_02, 'DisplayName', 'Explicit Midpoint Error')
% loglog(h_list_02, k_FE_02*h_list_01.^p_FE_02, 'DisplayName', 'FE linear')
% loglog(h_list_02, k_MP_02*h_list_01.^p_MP_02, 'DisplayName', 'MP linear')
% title("Local Truncation Error Function 02")
% legend
% 
% 
% % % ------------- GLOBAL TRUNCATION ERROR EXPLICIT----------------------
% 
% % Implementing for Function 01
% t0 = 0;
% tf = 10;
% t_span = [t0, tf];
% 
% [h_list_01, e_global_FE_01, e_global_MP_01, num_evals_FE_01, num_evals_MP_01] = global_truncation_error(@rate_func01, @solution01, t_span);
% 
% filter_params = struct();
% filter_params.max_xval = .1;
% [p_FE_01,k_FE_01] = loglog_fit(h_list_01,e_global_FE_01,filter_params)
% [p_MP_01,k_MP_01] = loglog_fit(h_list_01,e_global_MP_01,filter_params)
% 
% filter_params = struct();
% filter_params.min_xval = 80;
% [p_numevals_FE_01,k_numevals_FE_01] = loglog_fit(num_evals_FE_01,e_global_FE_01,filter_params)
% [p_numevals_MP_01,k_numevals_MP_01] = loglog_fit(num_evals_MP_01,e_global_MP_01,filter_params)
% 
% 
% 
% figure()
% loglog(h_list_01, e_global_FE_01, 'DisplayName', 'Forward Euler Error')
% hold on
% loglog(h_list_01, e_global_MP_01, 'DisplayName', 'Explicit Midpoint Error')
% loglog(h_list_01, k_FE_01*h_list_01.^p_FE_01, 'DisplayName', 'FE linear')
% loglog(h_list_01, k_MP_01*h_list_01.^p_MP_01, 'DisplayName', 'MP linear')
% title("Global Truncation Error Function 01")
% legend
% 
% 
% figure()
% loglog(num_evals_FE_01, e_global_FE_01, 'DisplayName', 'Forward Eurler')
% hold on
% loglog(num_evals_MP_01, e_global_MP_01, 'DisplayName', 'Explicit Midpoint')
% loglog(num_evals_FE_01, k_numevals_FE_01*num_evals_FE_01.^p_numevals_FE_01, 'DisplayName', 'FE linear')
% loglog(num_evals_MP_01, k_numevals_MP_01*num_evals_MP_01.^p_numevals_MP_01, 'DisplayName', 'MP linear')
% title('# Evaluations vs. Global Error Func 01')
% xlabel('# Evaluations')
% ylabel('Global Error')
% legend()
% 
% 
% % Implementing for Function 02
% 
% t0 = 0;
% tf = 10;
% t_span_02 = [t0, tf];
% 
% [h_list_02, e_global_FE_02, e_global_MP_02, num_evals_FE_02, num_evals_MP_02] = global_truncation_error(@rate_func02, @solution02, t_span_02);
% 
% filter_params = struct();
% filter_params.max_xval = .1;
% [p_FE_02,k_FE_02] = loglog_fit(h_list_02,e_global_FE_02,filter_params)
% [p_MP_02,k_MP_02] = loglog_fit(h_list_02,e_global_MP_02,filter_params)
% 
% filter_params = struct();
% filter_params.min_xval = 80;
% [p_numevals_FE_02,k_numevals_FE_02] = loglog_fit(num_evals_FE_02,e_global_FE_02,filter_params)
% [p_numevals_MP_02,k_numevals_MP_02] = loglog_fit(num_evals_MP_02,e_global_MP_02,filter_params)
% 
% 
% 
% figure()
% loglog(h_list_02, e_global_FE_02, 'DisplayName', 'Forward Euler Error')
% hold on
% loglog(h_list_02, e_global_MP_02, 'DisplayName', 'Explicit Midpoint Error')
% loglog(h_list_02, k_FE_02*h_list_02.^p_FE_02, 'DisplayName', 'FE linear')
% loglog(h_list_02, k_MP_02*h_list_02.^p_MP_02, 'DisplayName', 'MP linear')
% title("Global Truncation Error Function 02")
% legend()
% 
% 
% figure()
% loglog(num_evals_FE_02, e_global_FE_02, 'DisplayName', 'Forward Eurler')
% hold on
% loglog(num_evals_MP_02, e_global_MP_02, 'DisplayName', 'Explicit Midpoint')
% loglog(num_evals_FE_02, k_numevals_FE_02*num_evals_FE_02.^p_numevals_FE_02, 'DisplayName', 'FE linear')
% loglog(num_evals_MP_02, k_numevals_MP_02*num_evals_MP_02.^p_numevals_MP_02, 'DisplayName', 'MP linear')
% title('# Evaluations vs. Global Error Func 02')
% xlabel('# Evaluations')
% ylabel('Global Error')
% legend()

% ------------------ IMPLEMENTING IMPLICIT METHODS -----------------------

tspan = [0 10];
h = 0.1;
X0_01 = 1;

[t_list_BE,X_list_BE,h_avg_BE, num_evals_BE] = fixed_step_integration(@rate_func01, @backward_euler_step, tspan, X0_01, h);
[t_list_IMP,X_list_IMP,h_avg_IMP, num_evals_IMP] = fixed_step_integration(@rate_func01, @implicit_midpoint_step, tspan, X0_01, h);

tlist_analytical1 = linspace(tspan(1),tspan(2),1000);
solution_vals1 = solution01(tlist_analytical1);

figure(1);
hold on
plot(t_list_BE, X_list_BE, 'DisplayName', 'Backwards Euler')
plot(t_list_IMP, X_list_IMP, 'DisplayName', 'Implicit Midpoint')
plot(tlist_analytical1,solution_vals1, 'DisplayName', 'analytical');
legend
xlabel("time")
ylabel("x(t)")
title('Function 01')


tspan = [0 10];
h = 0.1;
X0_02 = [1;0];

[t_list_BE,X_list_BE,h_avg_BE, num_evals_BE] = fixed_step_integration(@rate_func02, @backward_euler_step, tspan, X0_02, h);
[t_list_IMP,X_list_IMP,h_avg_IMP, num_evals_IMP] = fixed_step_integration(@rate_func02, @implicit_midpoint_step, tspan, X0_02, h);

tlist_analytical2 = linspace(tspan(1),tspan(2),1000);
solution_vals2 = solution02(tlist_analytical2);


figure(2);

subplot(2,1,1)
hold on
plot(t_list_BE, X_list_BE(:,1), 'DisplayName', 'Backward Euler')
plot(t_list_IMP, X_list_IMP(:,1), 'DisplayName', 'Implicit Midpoint')
plot(tlist_analytical2,solution_vals2(1,:), 'DisplayName', 'analytical');
legend
xlabel('t')
ylabel('x(t)')
title('Function 02 x-values')

subplot(2,1,2)
hold on
plot(t_list_BE, X_list_BE(:,2), 'DisplayName', 'Backward Euler')
plot(t_list_IMP, X_list_IMP(:,2), 'DisplayName', 'Implicit Midpoint')
plot(tlist_analytical2,solution_vals2(2,:), 'DisplayName', 'analytical');
legend
xlabel('t')
ylabel('x(t)')
title('Function 02 y-values')

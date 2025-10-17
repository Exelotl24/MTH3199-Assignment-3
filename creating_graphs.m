clear
close all

tspan_01 = [0 10];
X0_01 = 1;
h = 0.38;

[t_list_FE,X_list_FE,h_avg_FE, num_evals_FE] = forward_euler_fixed_step_integration(@rate_func01, tspan_01, X0_01, h);
[t_list_MP,X_list_MP,h_avg_MP, num_evals_MP] = explicit_midpoint_fixed_step_integration(@rate_func01, tspan_01, X0_01, h);
[t_list_BE,X_list_BE,h_avg_BE, num_evals_BE] = fixed_step_integration(@rate_func01, @backward_euler_step, tspan_01, X0_01, h);
[t_list_IMP,X_list_IMP,h_avg_IMP, num_evals_IMP] = fixed_step_integration(@rate_func01, @implicit_midpoint_step, tspan_01, X0_01, h);


figure(1);
hold on
plot(t_list_FE, X_list_FE, '-*', 'DisplayName', 'Forward Euler')
plot(t_list_MP, X_list_MP, '-*', 'DisplayName', 'Explicit Midpoint')
plot(t_list_BE, X_list_BE, '-*', 'DisplayName', 'Backwards Euler')
plot(t_list_IMP, X_list_IMP, '-*', 'DisplayName', 'Implicit Midpoint')
legend
xlabel("time")
ylabel("x(t)")
title('Function 01 Method Comparison h=0.38')

h = 0.45;

[t_list_FE,X_list_FE,h_avg_FE, num_evals_FE] = forward_euler_fixed_step_integration(@rate_func01, tspan_01, X0_01, h);
[t_list_MP,X_list_MP,h_avg_MP, num_evals_MP] = explicit_midpoint_fixed_step_integration(@rate_func01, tspan_01, X0_01, h);
[t_list_BE,X_list_BE,h_avg_BE, num_evals_BE] = fixed_step_integration(@rate_func01, @backward_euler_step, tspan_01, X0_01, h);
[t_list_IMP,X_list_IMP,h_avg_IMP, num_evals_IMP] = fixed_step_integration(@rate_func01, @implicit_midpoint_step, tspan_01, X0_01, h);


figure(2);
hold on
plot(t_list_FE, X_list_FE, '-*', 'DisplayName', 'Forward Euler')
plot(t_list_MP, X_list_MP, '-*', 'DisplayName', 'Explicit Midpoint')
plot(t_list_BE, X_list_BE, '-*', 'DisplayName', 'Backwards Euler')
plot(t_list_IMP, X_list_IMP, '-*', 'DisplayName', 'Implicit Midpoint')
legend
xlabel("time")
ylabel("x(t)")
title('Function 01 Method Comparison h=0.45')


% comparing closed loop form numerical
h_list = [0.05, 0.2, 0.4];
tspan_01 = [0 10];
X0_01 = 1;
figure(3);
for i=1:4
    subplot(2,2,i)
    hold on
    for h=h_list
        switch i
            case 1
                [t_list,X_list,h_avg, num_evals] = forward_euler_fixed_step_integration(@rate_func01, tspan_01, X0_01, h);
                functionName = 'Forward Euler';
            case 2
                [t_list,X_list,h_avg, num_evals] = explicit_midpoint_fixed_step_integration(@rate_func01, tspan_01, X0_01, h);
                functionName = 'Explicit Midpoint';
            case 3
                [t_list,X_list,h_avg, num_evals] = fixed_step_integration(@rate_func01, @backward_euler_step, tspan_01, X0_01, h);
                functionName = 'Backward Euler';
            case 4
                [t_list,X_list,h_avg, num_evals] = fixed_step_integration(@rate_func01, @implicit_midpoint_step, tspan_01, X0_01, h);
                functionName = 'Implicit Midpoint';
        end
        displayNameText = sprintf('h = %g', h);
        plot(t_list, X_list, '-*', 'DisplayName', displayNameText)

    end
    displayTitleText = sprintf('Function 01 %s', functionName);
    xlabel("time")
    ylabel("x(t)")
    title(displayTitleText)
    legend()
end


% FINDING P VALUES 

% LOCAL TRUNCATION


t_ref =  0.492;

filter_params = struct();
filter_params.max_xval = 0.1;
[h_list_01, analytical_difference_01, e_local_FE_01, e_local_MP_01, e_local_BE_01, e_local_IMP_01] = local_truncation_error(@rate_func01, @solution01, t_ref);
[p_analytical_local_01,k_analytical_local_01] = loglog_fit(h_list_01,analytical_difference_01, filter_params)
[p_FE_local_01,k_FE_local_01] = loglog_fit(h_list_01,e_local_FE_01, filter_params)
[p_MP_local_01,k_MP_local_01] = loglog_fit(h_list_01, e_local_MP_01, filter_params)
[p_BE_local_01,k_BE_local_01] = loglog_fit(h_list_01,e_local_BE_01, filter_params)
[p_IMP_local_01,k_IMP_local_01] = loglog_fit(h_list_01, e_local_IMP_01, filter_params)


figure()
loglog(h_list_01,analytical_difference_01, '-*', 'DisplayName', 'Analytical Difference');
hold on
loglog(h_list_01, e_local_FE_01, '-*', 'DisplayName', 'Forward Euler Error')
loglog(h_list_01, e_local_MP_01, '-*', 'DisplayName', 'Explicit Midpoint Error')
loglog(h_list_01, k_FE_local_01*h_list_01.^p_FE_local_01, 'DisplayName', 'FE linear')
loglog(h_list_01, k_MP_local_01*h_list_01.^p_MP_local_01, 'DisplayName', 'MP linear')
xlabel('step size (h)')
ylabel('error')
title("Local Truncation Error Func01 (Explicit Methods)")
legend


figure()
loglog(h_list_01, e_local_FE_01, 'DisplayName', 'Forward Euler Error')
hold on
loglog(h_list_01, e_local_MP_01, 'DisplayName', 'Explicit Midpoint Error')
loglog(h_list_01, e_local_BE_01, 'DisplayName', 'Backward Euler Error')
loglog(h_list_01, e_local_IMP_01, 'DisplayName', 'Implicit Midpoint Error')
xlabel('step size (h)')
ylabel('error')
title("Local Truncation Error Func01 (All Methods)")
legend


[h_list_02, analytical_difference_02, e_local_FE_02, e_local_MP_02, e_local_BE_02, e_local_IMP_02] = local_truncation_error(@rate_func02, @solution02, t_ref);
[p_analytical_local_02,k_analytical_local_02] = loglog_fit(h_list_02,analytical_difference_02, filter_params)
[p_FE_local_02,k_FE_local_02] = loglog_fit(h_list_02,e_local_FE_02, filter_params)
[p_MP_local_02,k_MP_local_02] = loglog_fit(h_list_02, e_local_MP_02, filter_params)
[p_BE_local_02,k_BFE_local_02] = loglog_fit(h_list_02,e_local_BE_02, filter_params)
[p_IMP_local_02,k_IMP_local_02] = loglog_fit(h_list_02, e_local_IMP_02, filter_params)


% GLOBAL TRUNCATION

t0 = 0;
tf = 10;
t_span = [t0, tf];

[h_list_01, e_global_FE_01, e_global_MP_01, e_global_BE_01, e_global_IMP_01, num_evals_FE_01, num_evals_MP_01, num_evals_BE_01, num_evals_IMP_01] = global_truncation_error(@rate_func01, @solution01, t_span);

filter_params = struct();
filter_params.max_xval = .1;
[p_FE_global_01,k_FE_global_01] = loglog_fit(h_list_01,e_global_FE_01,filter_params)
[p_MP_global_01,k_MP_global_01] = loglog_fit(h_list_01,e_global_MP_01,filter_params)
[p_BE_global_01,k_BE_global_01] = loglog_fit(h_list_01,e_global_BE_01,filter_params)
[p_IMP_global_01,k_IMP_global_01] = loglog_fit(h_list_01,e_global_IMP_01,filter_params)

figure()
loglog(h_list_01, e_global_FE_01, '-*', 'DisplayName', 'Forward Euler Error')
hold on
loglog(h_list_01, e_global_MP_01, '-*', 'DisplayName', 'Explicit Midpoint Error')
loglog(h_list_01, k_FE_global_01*h_list_01.^p_FE_global_01, 'DisplayName', 'FE linear')
loglog(h_list_01, k_MP_global_01*h_list_01.^p_MP_global_01, 'DisplayName', 'MP linear')
xlabel('step size (h)')
ylabel('error')
title("Global Truncation Error Func 01 (Explicit Methods)")
legend()

figure()
loglog(h_list_01, e_global_FE_01, 'DisplayName', 'Forward Euler Error')
hold on
loglog(h_list_01, e_global_MP_01, 'DisplayName', 'Explicit Midpoint Error')
loglog(h_list_01, e_global_BE_01, 'DisplayName', 'Backward Euler Error')
loglog(h_list_01, e_global_IMP_01, 'DisplayName', 'Implicit Midpoint Error')
xlabel('step size (h)')
ylabel('error')
title("Global Truncation Error Func 01 (All Methods)")
legend()


filter_params = struct();
filter_params.min_xval = 80;
[p_numevals_FE_01,k_numevals_FE_01] = loglog_fit(num_evals_FE_01,e_global_FE_01,filter_params)
[p_numevals_MP_01,k_numevals_MP_01] = loglog_fit(num_evals_MP_01,e_global_MP_01,filter_params)
[p_numevals_BE_01,k_numevals_BE_01] = loglog_fit(num_evals_BE_01,e_global_BE_01,filter_params)
[p_numevals_IMP_01,k_numevals_IMP_01] = loglog_fit(num_evals_IMP_01,e_global_IMP_01,filter_params)

figure()
loglog(num_evals_FE_01, e_global_FE_01, '-*', 'DisplayName', 'Forward Euler Error')
hold on
loglog(num_evals_MP_01, e_global_MP_01, '-*', 'DisplayName', 'Explicit Midpoint Error')
loglog(num_evals_FE_01, k_numevals_FE_01*num_evals_FE_01.^p_numevals_FE_01, 'DisplayName', 'FE linear')
loglog(num_evals_MP_01, k_numevals_MP_01*num_evals_MP_01.^p_numevals_MP_01, 'DisplayName', 'MP linear')
xlabel('# evals')
ylabel('error')
title("Global Truncation Error # Evals Func 01 (Explicit Methods)")
legend()

figure()
loglog(num_evals_FE_01, e_global_FE_01, 'DisplayName', 'Forward Euler Error')
hold on
loglog(num_evals_MP_01, e_global_MP_01, 'DisplayName', 'Explicit Midpoint Error')
loglog(num_evals_BE_01, e_global_BE_01, 'DisplayName', 'Backward Euler Error')
loglog(num_evals_IMP_01, e_global_IMP_01, 'DisplayName', 'Implicit Midpoint Error')
xlabel('# evals')
ylabel('error')
title("Global Truncation Error # Evals Func 01 (All Methods)")
legend()
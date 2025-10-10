function [h_list, e_FE, e_MP, num_evals_FE, num_evals_MP] = global_truncation_error(rate_func_in, solution, t_span)

    h_list = logspace(-5, 1, 100);
    e_FE = zeros(size(h_list));
    e_MP = zeros(size(h_list));
    % analytical_difference = zeros(size(h_list));
    X0 = solution(t_span(1));
    Xf = solution(t_span(end));
    num_evals_FE = zeros(size(h_list));
    num_evals_MP = zeros(size(h_list));


    for i = 1:length(h_list)
        [~, X_FE, ~, evals_FE] = forward_euler_fixed_step_integration(rate_func_in, t_span, X0, h_list(i));
        [~, X_MP, ~, evals_MP] = explicit_midpoint_fixed_step_integration(rate_func_in, t_span, X0, h_list(i));
        e_FE(i) = norm(X_FE(end)-Xf);
        e_MP(i) = norm(X_MP(end)-Xf);
        num_evals_FE(i) = evals_FE;
        num_evals_MP(i) = evals_MP;
  
    end

end
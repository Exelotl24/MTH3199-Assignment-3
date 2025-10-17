function [h_list, e_FE, e_MP, e_BE, e_IMP, num_evals_FE, num_evals_MP, num_evals_BE, num_evals_IMP] = global_truncation_error(rate_func_in, solution, t_span)

    h_list = logspace(-5, 1, 25);
    e_FE = zeros(size(h_list));
    e_MP = zeros(size(h_list));
    e_BE = zeros(size(h_list));
    e_IMP = zeros(size(h_list));
    X0 = solution(t_span(1));
    Xf = solution(t_span(end));
    num_evals_FE = zeros(size(h_list));
    num_evals_MP = zeros(size(h_list));
    num_evals_BE = zeros(size(h_list));
    num_evals_IMP = zeros(size(h_list));


    for i = 1:length(h_list)
        [~, X_FE, ~, evals_FE] = forward_euler_fixed_step_integration(rate_func_in, t_span, X0, h_list(i));
        [~, X_MP, ~, evals_MP] = explicit_midpoint_fixed_step_integration(rate_func_in, t_span, X0, h_list(i));
        [~, X_BE, ~, evals_BE] = fixed_step_integration(rate_func_in, @backward_euler_step, t_span, X0, h_list(i));
        [~, X_IMP,~, evals_IMP] = fixed_step_integration(rate_func_in, @implicit_midpoint_step, t_span, X0, h_list(i));


        e_FE(i) = norm(X_FE(end)-Xf);
        e_MP(i) = norm(X_MP(end)-Xf);
        e_BE(i) = norm(X_BE(end)-Xf);
        e_IMP(i) = norm(X_IMP(end)-Xf);

        num_evals_FE(i) = evals_FE;
        num_evals_MP(i) = evals_MP;
        num_evals_BE(i) = evals_BE;
        num_evals_IMP(i) = evals_IMP;
  
    end

end
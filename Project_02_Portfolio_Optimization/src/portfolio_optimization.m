% ==================================================
% FINANCIAL MATHEMATICS - PORTFOLIO OPTIMIZATION
% Chapter 3: Markowitz Bullet and Efficient Frontier
% ==================================================
clear; clc; close all;

% 1. ASSETS (expected return, standard deviation, correlation)
mu = [0.10, 0.15, 0.20];
sigma = [0.28, 0.24, 0.25];
rho = [ 1.00, -0.10,  0.25;
       -0.10,  1.00,  0.20;
        0.25,  0.20,  1.00];

% Covariance matrix: C = D * R * D
C = diag(sigma) * rho * diag(sigma); 

% 2. MVL COEFFICIENTS (w = mu * a + b)
a = [-8.614, -2.769, 11.384];
b = [ 1.578,  0.845, -1.422];

% Expected returns (mu) range
mu_range = linspace(0.05, 0.30, 100)';

% Compute MVL Weights and Risk dynamically (No hardcoded polynomials!)
w_mvl = [mu_range * a(1) + b(1), mu_range * a(2) + b(2), mu_range * a(3) + b(3)];
sigma_mvl = sqrt(sum((w_mvl * C) .* w_mvl, 2)); % Efficient matrix row-wise variance

% Identify feasible MVL points for the "No Short Selling" part (all w >= 0)
is_feasible = (w_mvl(:,1) >= 0) & (w_mvl(:,2) >= 0) & (w_mvl(:,3) >= 0);

% =====================================================
% FIGURE 1: Weights plane (w2, w3) - WITH SHORT SELLING
% =====================================================
figure('Name', 'Weights Plane: Short Selling Allowed', 'Color', 'w');
hold on; grid on;

% Triangle (No short-selling region)
fill([0, 1, 0], [0, 0, 1], [0.9 0.9 0.9], 'FaceAlpha', 0.5, 'EdgeColor', 'none', 'DisplayName', 'No Short-Selling Region');

% Extended Budget Lines
x_ext = [-0.5, 1.5];
plot(x_ext, [0, 0], 'b-', 'LineWidth', 1.5, 'HandleVisibility', 'off');
plot([0, 0], x_ext, 'b-', 'LineWidth', 1.5, 'HandleVisibility', 'off');
plot(x_ext, 1 - x_ext, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Budget Limits');

% Minimum Variance Line (MVL)
plot(w_mvl(:,2), w_mvl(:,3), 'r-', 'LineWidth', 2.5, 'DisplayName', 'Theoretical MVL');

% Individual Assets
scatter([0, 1, 0], [0, 0, 1], 80, 'y', 'filled', 'MarkerEdgeColor', 'k', 'DisplayName', 'Assets');
text(-0.05, -0.05, 'S_1', 'FontWeight', 'bold');
text(1.05, -0.05, 'S_2', 'FontWeight', 'bold');
text(-0.05, 1.05, 'S_3', 'FontWeight', 'bold');

xlabel('Weight w_2', 'FontWeight', 'bold');
ylabel('Weight w_3', 'FontWeight', 'bold');
title('Feasible Portfolios on the w_2, w_3 plane (Short Selling Allowed)');
xlim([-0.5 1.5]); ylim([-0.5 1.5]); axis equal; legend('Location', 'best');

% ============================================================
% FIGURE 2: Risk-Return plane (sigma, mu) - WITH SHORT SELLING
% ============================================================
figure('Name', 'Risk-Return Plane : Short Selling Allowed', 'Color', 'w');
hold on; grid on;

N_pts = 30000;

% Random Portfolios (WITH short selling)
w_short = randn(N_pts, 3);
w_short = w_short ./ sum(w_short, 2);
mu_short = w_short * mu';
sigma_short = sqrt(sum((w_short * C) .* w_short, 2));
scatter(sigma_short, mu_short, 2, [0.85 0.93 1.00], 'filled', 'DisplayName', 'Short Selling Allowed');

% Random Portfolios (NO short selling)
w_noshort = rand(N_pts, 3);
w_noshort = w_noshort ./ sum(w_noshort, 2);
mu_noshort = w_noshort * mu';
sigma_noshort = sqrt(sum((w_noshort * C) .* w_noshort, 2));
scatter(sigma_noshort, mu_noshort, 2, [1.00 0.85 0.70], 'filled', 'DisplayName', 'No Short Selling Area');

% Two-security portfolio edges (Dynamic calculation)
w_ext = linspace(-0.5, 1.5, 200)';
w12 = [1-w_ext, w_ext, zeros(200,1)];
w23 = [zeros(200,1), 1-w_ext, w_ext];
w13 = [1-w_ext, zeros(200,1), w_ext];

plot(sqrt(sum((w12*C).*w12, 2)), w12*mu', 'r--', 'LineWidth', 2, 'DisplayName', 'S1-S2 Edge');
plot(sqrt(sum((w23*C).*w23, 2)), w23*mu', 'g--', 'LineWidth', 2, 'DisplayName', 'S2-S3 Edge');
plot(sqrt(sum((w13*C).*w13, 2)), w13*mu', 'b--', 'LineWidth', 2, 'DisplayName', 'S1-S3 Edge');

% Minimum Variance Line (The Markowitz Bullet)
plot(sigma_mvl, mu_range, '-', 'Color', [0.5 0 0.5], 'LineWidth', 3.5, 'DisplayName', 'MVL');

% Individual Assets
scatter(sigma, mu, 100, 'y', 'filled', 'MarkerEdgeColor', 'k', 'HandleVisibility', 'off');
text(sigma(1)+0.005, mu(1), 'S_1', 'FontWeight', 'bold');
text(sigma(2)+0.005, mu(2), 'S_2', 'FontWeight', 'bold');
text(sigma(3)+0.005, mu(3), 'S_3', 'FontWeight', 'bold');

xlabel('Standard Deviation (\sigma)', 'FontWeight', 'bold');
ylabel('Expected Return (\mu)', 'FontWeight', 'bold');
title('The Markowitz Bullet (\sigma, \mu plane)');
xlim([0.15 0.35]); ylim([0.05 0.25]);
legend('Location', 'northwest', 'AutoUpdate', 'off');

% =========================================================
% FIGURE 3: Weights plane (w2, w3) - NO SHORT SELLING
% =========================================================
figure('Name', 'Weights Plane: No Short Selling', 'Color', 'w');
hold on; grid on;

fill([0, 1, 0], [0, 0, 1], [0.9 0.9 0.9], 'FaceAlpha', 0.8, 'EdgeColor', 'b', 'LineWidth', 1.5, 'DisplayName', 'Feasible Triangle');
plot(w_mvl(:,2), w_mvl(:,3), 'r:', 'LineWidth', 1.5, 'DisplayName', 'Theoretical MVL');
plot(w_mvl(is_feasible, 2), w_mvl(is_feasible, 3), 'r-', 'LineWidth', 3, 'DisplayName', 'Feasible MVL');

scatter([0, 1, 0], [0, 0, 1], 100, 'y', 'filled', 'MarkerEdgeColor', 'k', 'DisplayName', 'Assets');
text(-0.05, -0.05, 'S_1', 'FontWeight', 'bold'); text(1.05, -0.05, 'S_2', 'FontWeight', 'bold'); text(-0.05, 1.05, 'S_3', 'FontWeight', 'bold');

xlabel('Weight w_2', 'FontWeight', 'bold'); ylabel('Weight w_3', 'FontWeight', 'bold');
title('Weights Plane: MVL inside No-Short-Selling Triangle');
xlim([-0.1 1.1]); ylim([-0.1 1.1]); axis equal; legend('Location', 'best');

% =========================================================
% FIGURE 4: Risk-Return plane (sigma, mu) - NO SHORT SELLING
% =========================================================
figure('Name', 'Risk-Return Plane: No Short Selling', 'Color', 'w');
hold on; grid on;

% Orange Area (Reused from Fig 2)
scatter(sigma_noshort, mu_noshort, 2, [1.00 0.85 0.70], 'filled', 'DisplayName', 'Long Only Portfolios');

% Constrained Edges (Weights strictly 0 to 1)
w_s = linspace(0, 1, 200)';
w12_ns = [1-w_s, w_s, zeros(200,1)]; w23_ns = [zeros(200,1), 1-w_s, w_s]; w13_ns = [1-w_s, zeros(200,1), w_s];
plot(sqrt(sum((w12_ns*C).*w12_ns, 2)), w12_ns*mu', 'r-', 'LineWidth', 2, 'DisplayName', 'S1-S2 Edge');
plot(sqrt(sum((w23_ns*C).*w23_ns, 2)), w23_ns*mu', 'g-', 'LineWidth', 2, 'DisplayName', 'S2-S3 Edge');
plot(sqrt(sum((w13_ns*C).*w13_ns, 2)), w13_ns*mu', 'b-', 'LineWidth', 2, 'DisplayName', 'S1-S3 Edge');

% Feasible Efficient Frontier
plot(sigma_mvl(is_feasible), mu_range(is_feasible), '-', 'Color', [0.5 0 0.5], 'LineWidth', 4, 'DisplayName', 'Efficient Frontier (Long only)');

scatter(sigma, mu, 100, 'y', 'filled', 'MarkerEdgeColor', 'k', 'HandleVisibility', 'off');
text(sigma(1)+0.005, mu(1), 'S_1', 'FontWeight', 'bold'); text(sigma(2)+0.005, mu(2), 'S_2', 'FontWeight', 'bold'); text(sigma(3)+0.005, mu(3), 'S_3', 'FontWeight', 'bold');

xlabel('Standard Deviation (\sigma)', 'FontWeight', 'bold'); ylabel('Expected Return (\mu)', 'FontWeight', 'bold');
title('Risk-Return: Frontier constrained by w_i \geq 0');
xlim([0.15 0.35]); ylim([0.05 0.25]); legend('Location', 'northwest');

% --- Auto-export to your specific images folder ---

if ~exist('../images', 'dir'), mkdir('../images'); end % Create 'images' if not exist

exportgraphics(figure(1), '../images/Figure1_Short_Weights.png', 'Resolution', 300);
exportgraphics(figure(2), '../images/Figure2_Short_Risk.png', 'Resolution', 300);
exportgraphics(figure(3), '../images/Figure3_NoShort_Weights.png', 'Resolution', 300);
exportgraphics(figure(4), '../images/Figure4_NoShort_Risk.png', 'Resolution', 300);
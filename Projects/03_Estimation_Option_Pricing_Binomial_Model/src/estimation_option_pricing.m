% =========================================================
% Monte Carlo Estimation of a European Call Option
% Binomial Model (N = 2 steps)
% =========================================================

% 1. Initialization of Data
S0 = 120;       % Initial stock price
U = 0.2;        % Upward return
D = -0.1;       % Downward return
R = 0.1;        % Risk-free rate
X = 120;        % Strike price
N = 2;          % Number of steps (T = 2)
M = 1000000;    % Number of Monte Carlo simulations

% 2. Calculate the Risk-Neutral Probabilities
p_star = (R - D) / (U - D);
q_star = 1 - p_star;    % or q_star = (U - R) / (U - D)

% 3. EXACT Theoretical Calculation (for comparison)
% Final stock prices for the 3 possible nodes at T = 2
Suu = S0 * (1 + U)^2;
Sud = S0 * (1 + U) * (1 + D);
Sdd = S0 * (1 + D)^2;

% Corresponding returns
Cuu = max(Suu - X, 0);  % Cuu = (Suu - X)^+
Cud = max(Sud - X, 0);  % Cud = (Sud - X)^+
Cdd = max(Sdd - X, 0);  % Cdd = (Sdd - X)^+

% Expected payoff under risk-neutral measure E*[C(2)]
Expected_Return_Exact = (p_star^2)*Cuu + (2*p_star*q_star)*Cud + (q_star^2)*Cdd;

% Discounted expected return
C0_exact = Expected_Return_Exact / (1 + R)^2;

% 4. Monte Carlo Simulation
% Simulate step 1 and step 2 for M paths using uniformly distributed random
% numbers
step1_is_up = rand(M, 1) < p_star;
step2_is_up = rand(M, 1) < p_star;

% Total number of 'Up' steps for each simulated path (can be 0 -> [dd], 1 ->
% [ud, du], or 2 -> [uu])
up_steps = step1_is_up + step2_is_up;
down_steps = N - up_steps;

% Calculate the final stock prices for all M paths simultaneously
ST = S0 * ((1 + U).^up_steps) .* ((1 + D).^down_steps);

% Calculate returns for all M paths
Returns = max(ST - X, 0);

% Estimate the expected return E*[C(2)]
Expected_Return_MC = mean(Returns);

% Discount back to time 0
C0_MC = Expected_Return_MC / (1 + R)^2;

% 5. Display Results
fprintf('--- Binomial Option Pricing (N=2) ---\n');
fprintf('Risk-neutral probability p*:   %.4f\n', p_star);
fprintf('Exact Analytical Price:        %.4f\n', C0_exact);
fprintf('Monte Carlo Estimate:          %.4f\n', C0_MC);
fprintf('Estimation Error:              %.4f\n', abs(C0_exact - C0_MC));
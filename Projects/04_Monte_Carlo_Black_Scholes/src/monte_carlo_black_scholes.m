% Parameters Selection
S0 = 100;       % Initial stock price
X = 100;        % Strike price
r = 0.05;       % Risk-free interest rate
sigma = 0.20;   % Volatility
T = 1;          % Time to maturity (years)
M = 1000000;    % Number of Monte Carlo simulations

% ---------------------------------------------------------
% 1. Black-Scholes Exact Formula
% ---------------------------------------------------------
d1 = (log(S0 / X) + (r + 0.5 * sigma^2) * T) / (sigma * sqrt(T));
d2 = d1 - sigma * sqrt(T);

% Calculate N(d1) and N(d2) using the built-in error function (erf)
N_d1 = 0.5 * (1 + erf(d1 / sqrt(2)));
N_d2 = 0.5 * (1 + erf(d2 / sqrt(2)));

% Calculate Black-Scholes Call Price
C_BS = S0 * N_d1 - X * exp(-r * T) * N_d2;

fprintf('Exact Black-Scholes Price: %.4f\n', C_BS);

% ---------------------------------------------------------
% 2. Monte Carlo Estimation
% ---------------------------------------------------------
% Generate M random numbers from standard normal distribution N(0,1)
Z = randn(M, 1);

% W*(T) has variance T, so we multiply Z by sqrt(T)
W_T = sqrt(T) * Z;

% Simulate the terminal stock prices S(T) under risk-neutral measure
S_T = S0 * exp((r - 0.5 * sigma^2) * T + sigma * W_T);

% Calculate the payoffs
Payoffs = max(S_T - X, 0);

% Calculate the Monte Carlo estimate (discounted average payoff)
C_MC = exp(-r * T) * mean(Payoffs);

% Calculate Standard Error for the Monte Carlo estimate
SE = std(exp(-r * T) * Payoffs) / sqrt(M);

fprintf('Monte Carlo Estimate: %.4f\n', C_MC);
fprintf('Monte Carlo Standard Error: %.4f\n', SE);
fprintf('Absolute Error: %.4f\n', abs(C_BS - C_MC));
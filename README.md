# Financial Mathematics - Computer Assignments

This repository contains the computer assignments and projects for the **Introductory Financial Mathematics (1MA521)** course at Linnaeus University.

The projects focus on mathematical modeling, financial simulations, and algorithm implementation using **MATLAB**, alnogside formal academic reports in **LaTeX**.

## 📚 Reference Material
All assignments, mathematical proofs, and theoretical models in this repository are based on the core textbook for the course:
* **Marek Capiński & Tomasz Zastawniak**, *Mathematics for Finance: An Introduction to Financial Engineering* (2nd Edition, Springer, 2011).

## 📁 Repository Structure
The repository is divided into two main directories to keep the source code and the final outputs organized:

* **`Projects/`**: Contains the working files for each assignment. Inside each subfolder, you will find the MATLAB scripts (`.m`), the LaTeX source files (`.tex`), and any generated figures or images used in the reports.
* **`Reports/`**: Contains the final, compiled PDF reports for quick reading and reference.

## 🚀 Assignments Overview

Here is a breakdown of the four main assignments included in this repository:

### 1. Compounding Convergence (Chapter 2)
* **Folder:** `01_Ch2_Compounding`
* **Description:** A numerical and graphical analysis comparing periodic (discrete) compounding with continuous compounding. The MATLAB simulation visually demonstrates how discrete compounding converges to the continuous exponential growth curve as the compounding frequency ($m$) approaches infinity.

### 2. Portfolio Optimization & Markowitz Bullet (Chapter 3)
* **Folder:** `02_Ch3_Portfolio_Optimization`
* **Description:** An implementation of Modern Portfolio Theory for a 3-asset market. The project computes the covariance matrix, determines the Minimum Variance Line (MVL) using the Two-Fund Theorem, and uses a Monte Carlo approach to map the feasible risk-return plane. It also analyzes how the Efficient Frontier changes when short-selling is strictly prohibited.

### 3. Estimation of Option Pricing in a Binomial Model (Chapter 6)
* **Folder:** `03_Ch6_Estimation_Option_Pricing`
* **Description:** Pricing a European Call option within a discrete-time 2-step binomial model. The project calculates the exact theoretical price using the risk-neutral valuation formula and compares it with an empirical estimation obtained through a Monte Carlo simulation of $1,000,000$ price paths.

### 4. Monte Carlo Estimation vs. Black-Scholes Formula (Chapter 8)
* **Folder:** `04_Ch8_Monte_Carlo_Black_Scholes`
* **Description:** A continuous-time financial simulation. This assignment estimates the price of a European Call option using Monte Carlo simulation under continuous Black-Scholes dynamics (log-normally distributed asset paths) and perfectly validates the result against the exact analytical continuous-time Black-Scholes pricing formula.

## 🛠️ Technologies & Tools
* **MATLAB:** Used for all numerical computations, Monte Carlo simulations, and data visualization/plotting.
* **LaTeX:** Used to write and compile all formal academic reports.
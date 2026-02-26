r = 0.10;           
m_list = [1, 2, 4, 12, 24];
figure;
hold on;
t_smooth = 0:0.001:5; 
V_cont = exp(r * t_smooth);
plot(t_smooth, V_cont, 'r--', 'LineWidth', 2);
for m = m_list
    t = 0:(1/m^2):5; 
    V_per = (1 + r/m).^(floor(t * m)); 
    plot(t, V_per, 'LineWidth', 1.5); 
end
grid on;
legend('Continuous', 'm=1', 'm=2', 'm=4', 'm=12', 'm=24', 'Location', 'best');
xlabel('Time (t)');
ylabel('Value of Investment');
title('Convergence to Continuous Compounding');
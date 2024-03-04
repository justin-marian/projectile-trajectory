% Projectile Trajectory Simulation
% <https://en.wikipedia.org/wiki/Projectile_motion>
% Author: Justin-Marian
% Date: 2024
% Description: This script simulates the trajectory of a projectile and
% computes relevant quantities such as flight time, range, maximum altitude,
% ascent and descent times, and heat produced. It also plots the trajectory
% and animates it.
%
% MIT License
%
% Copyright 2024 Justin-Marian
%
% Permission is hereby granted, free of charge, to any person obtaining a
% copy of this software and associated documentation files (the "Software"),
% to deal in the Software without restriction, including without limitation
% the rights to use, copy, modify, merge, publish, distribute, sublicense,
% and/or sell copies of the Software, and to permit persons to whom the
% Software is furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included
% in all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
% FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
% IN THE SOFTWARE.
%
function projectile_trajectory(v0, alpha0)
    % Simulate and analyze the trajectory of a projectile
    %
    % Inputs:
    %   - v0: Initial velocity (m/s)
    %   - alpha0: Launch angle (degrees)
    
    % Create output directory if it doesn't exist
    if ~exist('../output', 'dir')
        mkdir('../output');
    end
    if ~exist('../output/images', 'dir')
        mkdir('../output/images');
    end

    % Open log file for writing
    log_file = fopen('../output/log.txt', 'a');

    % Physical parameters
    g = 9.80665;                % gravitational acceleration (m/s^2)
    ro = 7850;                  % steel density (kg/m^3)
    r = 0.03;                   % projectile radius (m)
    m = 4/3 * pi * r^3 * ro;    % projectile mass (kg)

    % Initial conditions
    %-%v0 = 300;                        % initial velocity (m/s)
    %-%alpha0 = 20;                     % launch angle (degrees)
    eta = 1.81 * 1e-5;                  % viscosity coefficient
    b1 = 6 * pi * eta * r;              % linear term coefficient
    c = 0.469;                          % form coefficient
    ro0 = 1.22;                         % air density
    b2 = c * 4 * pi * r^2 * ro0 / 2;    % quadratic term coefficient

    % Compute trajectory
    [t, vx, vy, x, y] = compute_trajectory(v0, alpha0, b1, b2, g, m);

    % Plot results and save plots
    velocity_coordinates_position_folder = '../output/';
    if ~exist(velocity_coordinates_position_folder, 'dir')
        mkdir(velocity_coordinates_position_folder);
    end

    cd(velocity_coordinates_position_folder);
    plot_results(t, vx, vy, x, y);
    cd('../');

    % Compute and display relevant quantities
    [tf, b, h, tu, tc, Q] = compute_quantities(t, vx, vy, x, y, v0, m, g);

    % Animate trajectory
    plot_trajectory_animation(x, y, vx, vy);

    % Save outputs to log file
    fprintf(log_file, '============= PROJECTILE MOTION =============\n');
    fprintf(log_file, '         Flight Time: %f s\n', tf);
    fprintf(log_file, '         Range: %f km\n', b / 1e3);
    fprintf(log_file, '         Maximum Altitude: %f km\n', h / 1e3);
    fprintf(log_file, '         Ascent Time: %f s\n', tu);
    fprintf(log_file, '         Descent Time: %f s\n', tc);
    fprintf(log_file, '         Heat Produced: %f kJ\n', Q / 1e3);
    fprintf(log_file, '=============================================\n');
    fclose(log_file);
end

function [t, vx, vy, x, y] = compute_trajectory(v0, alpha0, b1, b2, g, m)
    % Computes the trajectory of a projectile
    %
    % Inputs:
    %   - v0: Initial velocity (m/s)
    %   - alpha0: Launch angle (degrees)
    %   - b1: Linear term coefficient
    %   - b2: Quadratic term coefficient
    %   - g: Gravitational acceleration (m/s^2)
    %   - m: Projectile mass (kg)
    %
    % Outputs:
    %   - t: Time vector (s)
    %   - vx: Velocity component along x-axis (m/s)
    %   - vy: Velocity component along y-axis (m/s)
    %   - x: Horizontal position (m)
    %   - y: Vertical position (m)
    
    t0 = 0; tf = 2 * v0 / g * sind(alpha0);
    N = 1000;   % number of time instances

    t = linspace(t0, tf, N);
    dt = t(2) - t(1);

    vx = zeros(1, N); vy = vx;
    x = zeros(1, N); y = x;

    vx(1) = v0 * cosd(alpha0);
    vy(1) = v0 * sind(alpha0);

    for i = 1 : N-1
        aux = 1 - dt * (b1 + b2 * sqrt(vx(i)^2 + vy(i)^2)) / m;

        vx(i + 1) = vx(i) * aux;
        vy(i + 1) = vy(i) * aux - g * dt;

        x(i + 1) = x(i) + vx(i) * dt;
        y(i + 1) = y(i) + vy(i) * dt;
        if y(i + 1) < 0
            break;
        end
    end

    t = t(1:i);
    vx = vx(1:i);
    vy = vy(1:i);
    x = x(1:i);
    y = y(1:i);
end

function plot_results(t, vx, vy, x, y)
    % Plots the results of projectile simulation
    %
    % Inputs:
    %   - t: Time vector (s)
    %   - vx: Velocity component along x-axis (m/s)
    %   - vy: Velocity component along y-axis (m/s)
    %   - x: Horizontal position (m)
    %   - y: Vertical position (m)
    figure('Position', [100, 100, 800, 600]);

    % Plot velocity components
    subplot(3, 1, 1);
    plot(t, vx, '-r', t, vy, '-b');
    xlabel('Time (s)');
    ylabel('Velocity (m/s)');
    grid;
    title('Velocity Components vs Time');
    legend('vx', 'vy');

    % Plot motion laws
    subplot(3, 1, 2);
    plot(t, x / 1e3, '-r', t, y / 1e3, '-b');
    xlabel('Time (s)');
    ylabel('Coordinates (km)');
    grid;
    title('Coordinates vs Time');
    legend('x', 'y', 'Location', 'northwest');

    % Plot trajectory
    subplot(3, 1, 3);
    plot(x / 1e3, y / 1e3, '-k', 'LineWidth', 2);
    xlabel('Horizontal Position (km)');
    ylabel('Vertical Position (km)');
    grid;
    title('Ballistic Curve');

    % Save the plot with larger spaces
    cd('./images');
    saveas(gcf, 'velocity_position_curve.png');
    cd('../');

    % Set axis to be equal and tight
    axis equal;
    axis tight;
end

function plot_trajectory_animation(x, y, vx, vy)
    % Animates the trajectory of a projectile
    %
    % Inputs:
    %   - x: Horizontal position (m)
    %   - y: Vertical position (m)
    %   - vx: Velocity component along x-axis (m/s)
    %   - vy: Velocity component along y-axis (m/s)
    
    % Create a figure with gradient sky background
    figure('Color', [0.7, 0.85, 1]);
    xlabel('Horizontal Position (km)');
    ylabel('Vertical Position (km)');
    grid;
    title('Projectile Trajectory');
    axis equal;
    axis tight;
    
    % Define colors for fading trail effect
    color_scale = linspace(0.99, 0.01, length(x));
    
    % Plot the trajectory line
    plot(x / 1e3, y / 1e3, '-k', 'LineWidth', 2);
    hold on;

    % Initialize plot with initial position (small filled circle)
    h = plot(x(1) / 1e3, y(1) / 1e3, 'o', 'MarkerSize', 7, 'MarkerFaceColor', 'r');

    % Initialize target
    target_x = x(end) / 1e3;
    target_y = y(end) / 1e3;
    target = plot(target_x, target_y, 'x', 'MarkerSize', 10, 'MarkerEdgeColor', 'g', 'LineWidth', 5);

    % Get the limits of the plot
    xlims = get(gca, 'XLim');
    ylims = get(gca, 'YLim');

    % Position text in the top-right corner
    pos_text_x = xlims(2) - 0.1 * diff(xlims);
    pos_text_y = ylims(2) - 0.05 * diff(ylims);
    pos_text = text(pos_text_x, pos_text_y, '', 'Color', 'blue', 'HorizontalAlignment', 'right');

    % Position velocity text below position text
    vel_text_x = pos_text_x;
    vel_text_y = pos_text_y - 0.05 * diff(ylims);
    vel_text = text(vel_text_x, vel_text_y, '', 'Color', 'red', 'HorizontalAlignment', 'right');

    % Initialize trail
    trail_length = 50;
    trail_x = zeros(trail_length, 1);
    trail_y = zeros(trail_length, 1);
    trail = plot(trail_x, trail_y, 'LineWidth', 3);

    for i = 2 : length(x)
        % Update plot with new position
        set(h, 'XData', x(i) / 1e3, 'YData', y(i) / 1e3);
        % Update position text
        set(pos_text, 'String', ['x = ', sprintf('%.2f', x(i) / 1e3), ' km, y = ', sprintf('%.2f', y(i) / 1e3), ' km']);
        % Update velocity text
        set(vel_text, 'String', ['vx = ', num2str(vx(i), '%.2f'), ' m/s, vy = ', num2str(vy(i), '%.2f'), ' m/s']);

        % Update target position
        if i == length(x)
            set(target, 'XData', target_x, 'YData', target_y);
        end

        % Update trail
        trail_x = [trail_x(2:end); x(i) / 1e3];
        trail_y = [trail_y(2:end); y(i) / 1e3];
        set(trail, 'XData', trail_x, 'YData', trail_y, 'Color', color_scale(i)*[1., 0.1, 0.01]);

        drawnow;
        pause(0.0001);
    end

    cd('./output/images/');
    saveas(gcf, 'trajectory_animation.png');
    cd('../../');
end

function [tf, b, h, tu, tc, Q] = compute_quantities(t, vx, vy, x, y, v0, m, ~)
    % Computes relevant quantities of projectile motion
    %
    % Inputs:
    %   - t: Time vector (s)
    %   - vx: Velocity component along x-axis (m/s)
    %   - vy: Velocity component along y-axis (m/s)
    %   - x: Horizontal position (m)
    %   - y: Vertical position (m)
    %   - v0: Initial velocity (m/s)
    %   - m: Projectile mass (kg)
    %
    % Outputs:
    %   - tf: Flight time (s)
    %   - b: Range (m)
    %   - h: Maximum altitude (m)
    %   - tu: Ascent time (s)
    %   - tc: Descent time (s)
    %   - Q: Heat produced (J)
    
    tf = t(end);                                  % flight time
    b = x(end);                                   % range
    h = max(y);                                   % maximum altitude
    tu = t(y == h);                               % ascent time
    tc = tf - tu;                                 % descent time
    Q = 1/2 * m * (v0^2 - vx(end)^2 - vy(end)^2); % heat produced

    % Display computed quantities
    disp('=============================================');
    disp(['     Flight Time: ', num2str(tf), ' s']);
    disp(['     Range: ', num2str(b / 1e3), ' km']);
    disp(['     Maximum Altitude: ', num2str(h / 1e3), ' km']);
    disp(['     Ascent Time: ', num2str(tu), ' s']);
    disp(['     Descent Time: ', num2str(tc), ' s']);
    disp(['     Heat Produced: ', num2str(Q / 1e3), ' kJ']);
    disp('=============================================');
    close(gcf);
end

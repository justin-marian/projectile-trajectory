# Projectile Trajectory

## Overview

The Projectile Trajectory is a `MATLAB/Octave` script designed to simulate the **trajectory of a projectile** launched into the air under the influence of *gravity* and *air resistance*. It is a computational model that provides insights into the motion of a projectile, computing various quantities and visualizing the trajectory for analysis and understanding.

![VELOCITY_POSTION_CURVE](./output/images/velocity_position_curve.png)

## Key Features

1). **Relevant Metrics**

- `Flight Time`: Computes the total time the projectile spends in the air.
- `Range`: Calculates the horizontal distance traveled by the projectile.
- `Maximum Altitude`: Determines the highest point reached by the projectile.
- `Ascent and Descent Times`: Identifies the time taken for the projectile to ascend and descend, respectively.
- `Heat Produced`: Estimates the heat generated during the motion of the projectile.

```output
============= PROJECTILE MOTION =============
         Flight Time: 18.406816 s
         Range: 0.235899 km
         Maximum Altitude: 0.407174 km
         Ascent Time: 6.908595 s
         Descent Time: 11.498221 s
         Heat Produced: 25.512452 kJ
=============================================
```

2). **Visualization**

- `Plotting`: Generates plots of velocity components, trajectory, and motion laws to visualize the projectile's motion over time.
- `Animation`: Creates an animated visualization of the trajectory, providing a dynamic representation of the projectile's path.

3). **Output and Analysis**

- `Log Files`: Logs the computed quantities and results for further analysis and reference.
- `Output Directory`: Organizes the generated plots and log files in an output directory for easy access and management.

## Intended Use Cases

- **Educational Purposes:** Provides a tool for students to explore the principles of projectile motion in physics courses.
- **Engineering Applications**: Offers insights for engineers working on projects involving projectile motion, such as ballistics and aerospace engineering.

## Additional Information

- **Animation:** The animation provides a dynamic representation of the projectile's trajectory, allowing users to observe its movement in real-time.
- **Result Files:** Alongside the `log.txt` file, the script generates `png images` depicting the ***trajectory**, **velocity**, and position **curve** as functions of time, providing visual aids for analysis and presentation.

## Usage

1. **Run Script:** Execute the `test_projectile.sh` script in your terminal.
**Options:**
   - `1` to **run** the projectile simulation.
   - `2` to **clean** up the log file.
   - `3` to **exit** the program.
2. **Call Function:** To simulate the trajectory of a projectile programmatically, use the `projectile_trajectory(v0, alpha0)` function, where `v0` is the **initial velocity** (*in m/s*) and `alpha0` is the **launch angle** (*in degrees*).

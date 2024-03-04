# Projectile Trajectory

## Overview

The Projectile Trajectory is a `MATLAB/Octave` script designed to simulate the **trajectory of a projectile** launched into the air under the influence of *gravity* and *air resistance*. It is a computational model that provides insights into the motion of a projectile, computing various quantities and visualizing the trajectory for analysis and understanding.

<img src="./output/images/velocity_position_curve.png" alt="VELOCITY_POSITION_CURVE" width="49%" /> <img src="./output/images/trajectory_animation.png" alt="TRAJECTORY_ANIMATION" width="49%" />

## Key Features

**Relevant Metrics:**

- `Flight Time`: Computes the total time the projectile spends in the air.
- `Range`: Calculates the horizontal distance traveled by the projectile.
- `Maximum Altitude`: Determines the highest point reached by the projectile.
- `Ascent and Descent Times`: Identifies the time taken for the projectile to ascend and descend, respectively.
- `Heat Produced`: Estimates the heat generated during the motion of the projectile.

```r
============= PROJECTILE MOTION =============
         Flight Time: 4.587242 s
         Range: 0.426711 km
         Maximum Altitude: 0.027452 km
         Ascent Time: 1.995086 s
         Descent Time: 2.592156 s
         Heat Produced: 21.942012 kJ
=============================================
============= PROJECTILE MOTION =============
         Flight Time: 16.925352 s
         Range: 0.652901 km
         Maximum Altitude: 0.371898 km
         Ascent Time: 5.946745 s
         Descent Time: 10.978606 s
         Heat Produced: 86.794148 kJ
=============================================
.......
```

**Visualization:**

- `Plotting`: Generates plots of velocity components, trajectory, and motion laws to visualize the projectile's motion over time.
- `Animation`: Creates an animated visualization of the trajectory, providing a dynamic representation of the projectile's path.

**Output and Analysis:**

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

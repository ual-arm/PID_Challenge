# PID Challenge

This program is an interactive game for control engineers, students, and general people interested in the subject of control systems. The tool is designed to challenge users to control different systems without knowing their characteristics beforehand. 

The challenge is to obtain the best closed-loop tuning in three escalated system levels, from the simplest to the most complex. The player can improve the PID controllers' performance by tuning them and adjusting their parameters (proportional, integral, and derivative gains).

The ranking is developed by classifying the smaller index as the average of the three levels among all players. The smallest, the best.

## Interactive tool instructions

The game is developed in the Matlab GUIDE platform. The codes are disclosed here. 

To edit the game windows, the user should open the GUIDE app in Matlab and then choose the files in the format .fig to adjust the game windows. 
There are a total of 10 windows, disclosed here by order of appearance in the game:

1) Main_Menu.fig
2) Instructions.fig
3) Register.fig
4) Level_1.fig
5) Level_1_end.fig
6) Level_2.fig
7) Level_2_end.fig
8) Level_3.fig
9) Level_3_end.fig
10) endChallenge.fig

Each .fig is associated with its respective code in .m format. The buttons, graphics, and calculations are all performed in callback functions in the .m file.

Obs: The game resolution is not optimized for all monitors. It was designed to be displayed on monitors with a 1080p, 21'' resolution. The Matlab program should be executed as the main desktop environment on this monitor. Please make sure the game is executed in these conditions. The programmer can edit the game windows using the GUIDE interface.

## Game instructions

The PID Challenge instructions are all displayed in the windows Instructions.fig. Herein, the main resume is available:

### Objective

As a Control Engineer, you need to tune 3 PID controllers applied in 3 different types of processes.
Sounds easy, right? But the challenge is:  you know NOTHING about the process.

### Instructions

- You need to define the 3 PID tuning parameters according to the formula:
- Modifying a parameter will automatically simulate the system in closed-loop with your designed controller.
- You can choose the parameter by moving the slide bar, clicking the arrows, or typing directly in the text box.
- The controller will be tested to track a unitary step change in the reference and to reject  a unitary step in the disturbance.
- The sum of the total error plus the control effort will evaluate your performance.
- The best and the current indices will be displayed during the experiment.
- You can always return to the starting parameters by clicking the Reset button.
- After 45 seconds, you move to the next level.
- Your final score will be the mean of the scores in each level.

# How to cite and use

This tool is available for users to edit and use without commercial intentions. Please cite this repository as detailed:

Pataro, I. M. L., Guzmán, J. L., Gil, J. D., Berenguel, M., González-Hernández, J., Cañadas-Aránega, F., Hoyo, Á., Otálora, P., PID Tuning Challenge, 2024, University of Almería (Spain), Available in: https://github.com/ual-arm/PID_Challenge

# Contact

Please, for any doubt or suggestions, contact:

igorpataro@ual.es
joguzman@ual.es

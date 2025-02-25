# ESCAPE ROOM

In this repository, the original questions from the article are listed [Insertar enlace publicación].

## Candado 1

1. ¿En qué número de en carta se encuentran los sensores?
2. ¿ En qué número de en carta se encuentran los actuadores?

## Candado 2

3. Para modelar la planta nuclear, se realizan 3 ensayos en bucle abierto donde se proporciona un cambio en la entrada del 15% en cada uno de ellos. Tras finalizar, se observa un comportamiento no lineal del reactor y lineal para el tanque ¿Qué cartas indican el comportamiento del reactor y del tanque, respectivamente?
4. ¡Oh no!, el reactor empezó a inestabilizarse. ¿Cuál de estas pantallas corresponde a esta respuesta?
5. Para intentar solucionar el problema del reactor, se tiene que actuar en la bomba de agua de refrigeración inmediatamente.  Sin embargo, es conocido que el sistema de bombas tiene retraso en la respuesta ¿Qué pantalla indica este comportamiento?
6. Gracias a la bomba de refrigeración el sistema comenzó a estabilizarse, pero comenzó a comportarse como un 2° orden. Primero presenta picos de oscilación, y luego un sistema con amortiguación pronunciada ¿Qué cartas corresponden a un sistema de 2° orden 
subamortiguado y sobreamortiguado, respectivamente?
7. Debido a los bruscos comportamientos de la bomba de refrigeración del reactor, la válvula de expulsión de residuos comenzó a comportarse como un sistema críticamente estable, ¿Cuál de estas cartas corresponde a este comportamiento?
8. Debido al comportamiento crítico de la válvula de expansión, la amplitud comenzó a crecer hasta llegar al punto de saturación del sensor ¿Qué pantalla corresponde a este sistema?

## Candado 3

9. En la ranura que se acaba de abrir podéis encontrar los resultados de los diferentes ensayos realizados para modelar el comportamiento de la temperatura del reactor al modificar distintos actuadores. En todos los actuadores se ha realizado un cambio de escalón unitario en el instante t=0. Para poder desvelar el código tendréis que analizar las características dinámicas de la respuesta de los ensayos y asociarlo según indica la pantalla: Dígito 1: Valor de la sobreoscilación más alta dividido entre 10 (Carta x1,x2); Dígito 2: Valor de la ganancia más elevada; Dígito 3: Valor de la constante de tiempo más rápida; Dígito 4: Valor del tiempo de retardo mayor.

## Candado 4

10. Para controlar el sistema, el primer paso es identificar los documentos que muestren un problema de regulación.
11. El tiempo sigue pasando, y la planta no se consigue estabilizar, quizás el tipo de problema de control identificado no sea el adecuado. El código está en buscar los documentos que mezclen control (seguimiento) y regulación:
PISTA: Introduzca el número de carta en orden creciente.
12. ¡Parece que nos acercamos a la solución, solo queda un último esfuerzo! El parámetro del PID problemático es el que hace que la salida del controlador sea proporcional al error, necesitamos resintonizarlo. Para ello, considere el tipo de problema de la pregunta anterior (control y regulación) y, de los documentos encontrados en la oficina, el valor de ganancia más elevada y la constante de tiempo más rápida, los cuales definen el comportamiento del sistema en bucle abierto. Introduzca el valor de las tres primeras cifras decimales

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

Pataro, I. M. L., Guzmán, J. L., Gil, J. D., Berenguel, M., González-Hernández, J., Cañadas-Aránega, F., Hoyo, Á., Otálora, P., PID Tuning Challenge, 2024, University of Almería (Spain), Available in: https://github.com/ual-arm/Gamification_In_Control_Engineering

# Contact

Please, for any doubt or suggestions, contact:

igorpataro@ual.es
joguzman@ual.es

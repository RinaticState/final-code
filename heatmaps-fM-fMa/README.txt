#fM/fMa heatmaps
2 July 2019 
The heatmap code was originally written by An Do, from Claremont Graduate University.
This is a much more modified version.
Eta function, with Ludewig trafficking rates.
All the code in this folder will generate a heatmap of the fM and fMa parameters (the two clearance rates) for the multicompartmental model of Type I Diabetes code.
The code is based off Gianna Wu's code from her thesis, but written by the undergrad team from the 2019 Data Science REU. There are some discrepancies, such as the insulin levels being a little off. 
I have added an eta_vary function to the parameters and ODE file, as Gianna's original code did not contain the eta_vary function, just a constant value for the eta parameter. The eta_vary function
was important to investigate the alpha_e and beta_e parameters. It does make some minor changes to the graphs as well.
To run the code, under the command window, first enter:
formLHS(50)
T1D_sim('LHS.csv')
heatmap('LHS.csv', 0)
You could change 50 to any number, but the higher, the longer it will take to run T1D_sim(). It will generate a matrix containing 2 columns of n^2 values.
formLHS will output an LHS.csv file. You pass that .csv file into T1D_sim(). Doing an LHS of sizemap = 50 will take approximately 1.5-2 hours. If you just
want to test the code, just do formLHS(2) then T1D_sim('LHS.csv'). 
Pass in 0, 0.5, or 1 as the second argument for the heatmap function if you want no apoptotic wave, apoptotic wave = 0.5, or apoptotic wave = 1, respectively.
The yellow regions for the heat map means diabetic.
The blue regions mean healthy.
The magenta line is a barrier between glycemic and healthy states.
The blue line is a barrier between diabetic and healthy (or glycemic, depending on your heatmap) states.
To prove that a certain region is diabetic/glycemic/healthy, run the dynamics function by picking a point in a certain region. Think of it as an (x, y) coordinate, with the x being the fMa, and fM.
dynamics(0.1, 7, 0)
Basically, the arguments you passed were fMa, fM, and the apoptotic wave (in this case, no wave.)
Feel free to change the eta-basal value in the parameter file to get something else.
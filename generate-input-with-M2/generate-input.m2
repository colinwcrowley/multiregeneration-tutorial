-- This file contain starter code for taking a system of Polynomials in M2,
-- and auto generating the input files that multiregeneration.py can use
-- to solve it. 

-- This is a helper function that adds commas in between
-- each pair of consequtive strings in a list. e.g. 
-- addCommas({"a","b","c"})
joinWithCommas = L -> (
    output = L;
    for i from 1 to length(L)-1 do 
        output = insert(2*i-1, ",", output);
    concatenate(output)
    )
    
-- Print complex numbers to a higher precision
printingPrecision = 64

-- STEP 1: Run whatever code you need to to get the system you want.
-- Here's an example system you might like to solve 
R = CC[x,y,z]
system = {x^2*y + y*z^2 + y*x + 2, y^2 + x^2 - z^2*y^2 + 1, x*y*z - 5}


-- STEP 2: Choose variable groups.
-- Here are some example variable groups. Variable group 0 is {x,z} and variable group 1 is {y}
-- Recall that choosing different variable groups could speed up or slow down the computation.
-- What you want to look for when choosing variable groups is for variables in the same group (e.g. x and z)
-- not to be in the same terms. You can see that in the system above, x and z are rarely in the same term, so
-- the grouping below is a good guess for the best variable grouping.
variableGroups = {{x,z}, {y}}

-- If you don't want to worry about variable groups, then just make one
-- group contining all the variables by uncommenting the following line.

-- variableGroups = {{x,y,z}}

-- STEP 3: Write the file "bertiniInput_variables"

-- First we remove the file "bertiniInput_variables" if it exists already,
-- and start freash.
removeFile "bertiniInput_variables"

-- The following loop write each line of our new "bertiniInput_variables"
-- file one at a time
for group in variableGroups do (
    -- convert our list of variables into a list of strings
    variableStringList = for variable in group list toString(variable);
    
    -- Concatenate our list of strings together into one string,
    -- with commas in the middle.
    variableString = joinWithCommas(variableStringList);
    
    -- Add a line to the "bertiniInput_variables" file corresponding
    -- to the current variable group. See the M2 documentation for more info
    -- on how to use "<<"
    "bertiniInput_variables" << "variable_group " << variableString << ";"<<endl;
)
-- Now that we're done writing to "bertiniInput_variables", let's close it.
"bertiniInput_variables" << close

-- STEP 4: Write the file "bertiniInput_equations"

-- Similar to before, we remove the "bertiniInput_equations" file if 
-- it already exists.

removeFile "bertiniInput_equations"

-- Creat a list of function names f1,f2,..."
functionNames = for i from 1 to length(system) list "f"|toString(i);

-- Write the first line of the "bertiniInput_equations" file, which declares
-- the functions f1,f2,...
"bertiniInput_equations" << "function " << joinWithCommas(functionNames) << ";" <<endl

-- Now we write a line defining each f0,f1,etc. to be the functions
-- in our system.

formattedSystem = for equation in system list replace("ii", "I", toString(equation))

for i from 0 to length(system)-1 do
    "bertiniInput_equations" << functionNames_i|" = "|formattedSystem_i|";\n";

-- Close the file now that we are done
"bertiniInput_equations" << close


-- STEP 5: Write the file "inputFile.py"

-- Remove "inputFile.py" if it exists
removeFile "inputFile.py"


-- For each funtion, we want to list it's multidegree vector.
multidegreesOfEquationsInSystem = for function in system list 
(
    for group in variableGroups list
    (
       -- The degree of the equation "function" in the variable group
       -- "group" is given as the maximum of ...
       max(
           -- for each momomial in "function"...
	   for monomial in terms(function) list 
	   (
	       -- the degree of the monomial in the variable group.
	       -- The degree of a monomial in a group of variables is the sum
	       -- of it's degree in each variable in the group.
	       sum(group, variable -> degree(variable, monomial))
	   )
       )
    )
)

-- The following code replaces "{" with "[" and "}" with "]". We need to do this
-- because M2 uses {} to define lists, whereas python uses [].
pythonFormattedMultidegrees = toString(multidegreesOfEquationsInSystem)
pythonFormattedMultidegrees = replace("\\{", "[",pythonFormattedMultidegrees)
pythonFormattedMultidegrees = replace("\\}", "]",pythonFormattedMultidegrees)

-- We now create the file "inputFile.py" as described in the tutorial.

-- This line adds the degree information
"inputFile.py" << "degrees = " << pythonFormattedMultidegrees << endl

"inputFile.py" << "verbose = 1" << endl

"inputFile.py" << "explorationOrder = \"depthFirst\"" << endl

"inputFile.py" << close

-- STEP 6: Tracking Options
-- The following code creates a single file called "bertiniInput_trackingOptions" which will
-- contain the single line "SECURITYLEVEL:1;"
-- This ensures that the numerical results are more acurate (i.e. that we find all solutions)
-- at the price of taking slightly longer
removeFile "bertiniInput_trackingOptions"
"bertiniInput_trackingOptions" << "SECURITYLEVEL:1;" << endl << close
	
-- STEP 6: Running multiregeneration

-- Now that we've generated the input exit emacs or M2 and, run the command
-- "python2 ../multiregeneration.py"
-- from this directory.








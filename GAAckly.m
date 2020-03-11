clc;
clear;

populationSize = 40;

pCO = 0.8;
pMU = 0.05;
lowerBound = -20;
higherBound = 5;

%fid = fopen('housing.txt', 'r');

%a = fscanf(fid, '%f %f', [2 inf]);

len = 307;
averageFitness = 0;

population = rand(populationSize , len)*(higherBound-lowerBound) + (lowerBound);

output = 0;

value = zeros(110);
iii = 1;

%%start iteration

for itterator = 1 : 20000
    roulet = zeros(1, populationSize);
    
    
    fitness = zeros(1, populationSize);
    for counter = 1 : populationSize
       
        fitness(counter) = Ackley(population(counter, :));
    end
     
    maxFittness = max(fitness);
    averageFitness = sum(fitness)/populationSize;
    oldPopulation = population;
    

    % roulet
    total = 0;
    for i = 1 : populationSize
        total = total + fitness(i);
    end

    for i = 1 : populationSize
        roulet(i) = round((fitness(i) / total)*populationSize);
    end
    index = 1;

    for j = 1 : populationSize
        for k = 1 : roulet(j)
            population(index, :) = population(j, :);
            index = index + 1;
        end
    end

    %crossOver
    for i = 1 : 2 : populationSize
        r = rand();
        if(r < pCO)
            r2 = floor(rand()*len)+1;
            temp1 = population(i, r2+1:len);
            population(i, r2+1:len) = population(i+1, r2+1:len);
            population(i+1 , r2+1:len) = temp1;
        end
    end

    %mutation
    for i = 1 : populationSize
        r = rand();
        if(r < pMU)
            r2 = floor(rand() * len)+1;
            population(i, r2) = population(i , r2) + (-1)^(floor(rand()*2)+1)*(rand()*population(i , r2));
            if population(i, r2) > 30
                population(i, r2) = 30;
            else if population(i, r2) < -15
                    population(i, r2) = -15;
                end
            end
                    
        end
    end

    averageFittnes = sum(fitness) / populationSize;
    output = Ackley(population)
    
    if mod(itterator , 1000) == 0
        value(iii) = output;
        iii = iii + 1;
    end
    fitness;
end
       

plot(value);

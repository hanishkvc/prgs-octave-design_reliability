# Calculate MTBF Related info
# Variables maintain info in hours

function print_times(msg, timeInHours)
  printf(msg)
  timeInDays = timeInHours/24;
  timeInYears = timeInHours/(24*365);
  printf("\n\t In Hours = %d\n\t In Days = %d \n\t In Years = %d\n",
    timeInHours, timeInDays, timeInYears)
endfunction

mtbf = input("Enter MTBF of product in hours: ");
print_times("\nProduct MTBF", mtbf)

totalTime = max(mtbf,10*365*24);
print_times("\nTotal time considered", totalTime)

timeX = [0:1:totalTime];
Reliability = e.^(-timeX/mtbf);

plot(timeX,Reliability)


timeConsidered = [24*365, 24*365*2, 24*365*3, 24*365*5, 24*365*6, 24*365*8, 24*365*10];
prodQuantities = [10, 50, 100, 1000, 5000, 10000];

disp("\nAssuming 24x7 i.e Continuous use of the product in the field")

for curTime = timeConsidered
  curTimeInYears = curTime/(24*365);
  relAtTime = Reliability(curTime);
  failureAtTime = 1 - relAtTime;
  printf("\nIn %d Years, Predicted Reliability is %d\n", curTimeInYears, relAtTime)

  for curQty = prodQuantities
    numOfFailures = failureAtTime * curQty;
    printf("\t if %8d units in field, \t number of failures could be %d\n",
      curQty, numOfFailures)
  endfor
endfor

input("Press any key to Quit...")


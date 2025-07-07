# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

it is convinient to use it because all the data evenly distributes between all of the boats.
however this approach slows down searching through the data that was collected.

## Partitioning by Hour

it is convinient to use it because all the data could be looked up quikly based on the hours.
however this approach may make one of the databases overflow and the other may stay empty simultaniously.

## Partitioning by Hash Value

same here as with Random Partitioning but it is easier to look up exact observation as now we know its hash.

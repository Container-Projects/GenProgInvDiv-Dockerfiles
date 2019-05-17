# How to run mutation testing on Defects4j bugs

1. Create a Docker image based on the Dockerfile and entrypoint script here. 
    On the squaresLab server, the Docker image is already made and named `thegrandtask:d4j-mut`.

2. `cd GenProgScripts`

3. `bash runGenProg.sh PROJECT BUGNUM`
    - PROJECT is the project name of the Defects4J bug to test (e.g: Lang, Math)
    - BUGNUM is the bug number of the Defects4J bug to test
    - e.g: `bash runGenProg.sh Math 30`
    - If running in the background for an extended period of time, I suggest using `nohup` to prevent interruptions.
        - `nohup bash runGenProg.sh PROJECT BUGNUM >& LOGOUTPUT &
        - e.g: `nohup bash runGenProg.sh Math 30 >& math30dump.out &`

4. Artifacts and output are located in `/home/user/defects4j/output/`.
   Each directory inside corresponds to a bug. For example, the output and artifacts of Math 30 are 
   located in `/home/user/defects4j/output/math30Buggy/`.
   Artifacts found within include:
   - `out.yaml`, containing mutation testing information.
      - `Invariants:` Set of invariants that Daikon inferred
          - `!!ylyu1.wean.PredGroup` a data structure for invariants
              - `line:` not working, ignore it
              - `location:` ENTER | EXIT | OBJECT (not supported) | ...
              - `method:` method that the invariants are a part of.
              - `negCover:` not working, ignore it
              - `posCover:` not working, ignore it
              - `statements:` list of invariants
     - `variantN:` Information regarding variant N
        - `Passing positive tests:` a list of passing positive tests
        - `Passing negative tests:`
        - `Failing positive tests:`
        - `Failing negative tests:`
        - `Invariant profile:` either `null` or an array of values n = 0 | 1 | 2.

# Todos:
- We are currently inferring invariants by sampling n tests, partitioning the sample into partitions of size k, and running Daikon n/k times. To reduce the number of program executions, do a one-pass run to collect program traces, then partition the traces before sending them to Daikon's back end analyzer.
- We are inferring a massive amount of invariants. I suspect that instrumentation of variant programs is taking forever (in the order of minutes). Consider invariant filtering.

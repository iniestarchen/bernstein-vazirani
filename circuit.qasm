OPENQASM 2.0;
include "qelib1.inc";
// Bernstein-Vazirani: hidden string s="101" (3 bits)
// f(x) = s.x mod 2 = x0 XOR x2
qreg q[3];
qreg a[1];
creg c[3];
// Prepare ancilla in |->
x a[0];
h a[0];
// Superpose input
h q[0]; h q[1]; h q[2];
// Oracle: f(x) = x0 XOR x2 (bits at positions where s[i]=1)
cx q[0],a[0];
// s[1]=0: skip q[1]
cx q[2],a[0];
// Hadamard on input reveals s
h q[0]; h q[1]; h q[2];
// Measure: should produce s = "101"
measure q[0] -> c[0];
measure q[1] -> c[1];
measure q[2] -> c[2];

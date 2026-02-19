# Bernstein-Vazirani Algorithm

> **Category**: search &nbsp;|&nbsp; **Difficulty**: beginner &nbsp;|&nbsp; **Qubits**: 4 &nbsp;|&nbsp; **Gates**: 8 &nbsp;|&nbsp; **Depth**: 5

The Bernstein-Vazirani algorithm recovers a secret string s ∈ {0,1}^n by evaluating f(x) = s·x (mod 2) exactly once, while the best classical algorithm requires n queries. The circuit is structurally identical to Deutsch-Jozsa, but the oracle is a CX on each bit position where s[i]=1. After the Hadamard at the output, measuring gives s exactly.

## Expected Output

c[0]=1, c[1]=0, c[2]=1 (secret string '101')

## Circuit

The OpenQASM 2.0 circuit is in [`circuit.qasm`](./circuit.qasm).

```
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
```

## Tags

`bernstein-vazirani` `oracle` `hidden-string` `linear-speedup`

## References

- [Bernstein & Vazirani (1997). Quantum Complexity Theory. SIAM J. Comput. 26(5)](https://doi.org/10.1137/S0097539796300921)

## License

MIT — part of the [OpenQC Algorithm Catalog](https://github.com/openqc-algorithms).

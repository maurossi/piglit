// [config]
// expect_result: fail
// glsl_version: 1.20
// [end config]

/* FAIL - bitwise operations aren't supported in 1.20. */

void main()
{
    int x = ~false;
}

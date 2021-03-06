// [config]
// expect_result: pass
// glsl_version: 1.00
//
// # NOTE: Config section was auto-generated from file
// # NOTE: 'glslparser.tests' at git revision
// # NOTE: 6cc17ae70b70d150aa1751f8e28db7b2a9bd50f0
// [end config]

/* PASS - built-in exp is outside the global scope
 *
 * See also redeclaration-04.vert.
 */

float exp(float x, float y)
{
    return x + y;
}

void main()
{
    gl_Position = vec4(0.0);
}

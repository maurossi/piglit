// [config]
// expect_result: fail
// glsl_version: 1.20
//
// # NOTE: Config section was auto-generated from file
// # NOTE: 'glslparser.tests' at git revision
// # NOTE: 6cc17ae70b70d150aa1751f8e28db7b2a9bd50f0
// [end config]


/* FAIL - attribute cannot have array type in GLSL 1.20 */
attribute vec4 i[10];

void main()
{
  gl_Position = vec4(1.0);
}

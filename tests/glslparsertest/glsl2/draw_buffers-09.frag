// [config]
// expect_result: fail
// glsl_version: 1.10
//
// # NOTE: Config section was auto-generated from file
// # NOTE: 'glslparser.tests' at git revision
// # NOTE: 6cc17ae70b70d150aa1751f8e28db7b2a9bd50f0
// [end config]

/* FAIL - out of bounds access of gl_FragData */


uniform vec4 a;

void main()
{
  gl_FragData[0] = a;
  gl_FragData[gl_MaxDrawBuffers] = a;
}

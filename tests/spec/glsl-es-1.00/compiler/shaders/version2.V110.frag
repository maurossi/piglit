// [config]
// expect_result: fail
// glsl_version: 1.00
//
// # NOTE: Config section was auto-generated from file
// # NOTE: 'glslparser.tests' at git revision
// # NOTE: 6cc17ae70b70d150aa1751f8e28db7b2a9bd50f0
// [end config]

#pragma debug(on)
#version 110  // error #version should be the first statement in the program


void main()
{
   gl_FragColor = vec4(1);    
}

// [config]
// expect_result: fail
// glsl_version: 1.00
//
// # NOTE: Config section was auto-generated from file
// # NOTE: 'glslparser.tests' at git revision
// # NOTE: 6cc17ae70b70d150aa1751f8e28db7b2a9bd50f0
// [end config]

/* FAIL - like redeclaration-06.vert, but now the other comes first */
void main()
{
    struct foo {
       bvec4 bs;
    };
    float foo;

    gl_Position = vec4(0.0);
}

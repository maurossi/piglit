// [config]
// expect_result: pass
// glsl_version: 1.00
//
// # NOTE: Config section was auto-generated from file
// # NOTE: 'glslparser.tests' at git revision
// # NOTE: 6cc17ae70b70d150aa1751f8e28db7b2a9bd50f0
// [end config]

int array[2];
varying vec4 gl_TexCoord[];
varying vec4 gl_TexCoord[2];

void main()
{
    {
        float array[];
        float array[2];
    }
    {
        vec2 array[];
        vec2 v = array[1];
        vec2 array[2];
    }
    int i = array[1];
}

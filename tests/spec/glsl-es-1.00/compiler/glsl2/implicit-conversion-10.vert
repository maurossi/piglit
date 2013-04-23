/* [config]
 * expect_result: fail
 * glsl_version: 1.20
 * [end config]
 */


void main()
{
  ivec4 i = bvec4(false);
  gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}

/* [config]
 * expect_result: fail
 * glsl_version: 1.20
 * [end config]
 */


void main()
{
  ivec2 i = bvec2(false);
  gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}

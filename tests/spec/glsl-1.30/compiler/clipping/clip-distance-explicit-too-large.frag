/* [config]
 * expect_result: fail
 * glsl_version: 1.30
 * check_link: true
 * [end config]
 *
 * From the GLSL 1.30 spec section 7.2 (Fragment Shader Special
 * Variables):
 *
 *   The built-in input variable gl_ClipDistance array contains
 *   linearly interpolated values for the vertex values written by the
 *   vertex shader to the gl_ClipDistance vertex output variable. This
 *   array must be sized in the fragment shader either implicitly or
 *   explicitly to be the same size as it was sized in the vertex
 *   shader.
 *
 * This test checks that the an error occurs when explicitly setting
 * the size of gl_ClipDistance to gl_MaxClipDistances+1, which should
 * generate an error.
 */
#version 130

out float gl_ClipDistance[gl_MaxClipDistances+1];

void main()
{
}

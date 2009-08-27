/*
 * Copyright © 2009 Intel Corporation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice (including the next
 * paragraph) shall be included in all copies or substantial portions of the
 * Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * Authors:
 *    Eric Anholt <eric@anholt.net>
 */

/** @file draw-elements-base-vertex.c
 * Tests ARB_draw_elements_base_vertex functionality by drawing a series of
 * pairs of quads using different base vertices, using the same vertex and
 * index buffers.
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <GL/glew.h>
#if defined(__APPLE__)
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif
#include "piglit-util.h"

/* GLEW hasn't added support for this yet. */

#ifndef APIENTRY
#define APIENTRY
#endif
#ifndef APIENTRYP
#define APIENTRYP APIENTRY *
#endif
#ifndef GL_ARB_draw_elements_base_vertex
#define GL_ARB_draw_elements_base_vertex
typedef void (APIENTRYP PFNGLDRAWELEMENTSBASEVERTEXPROC) (GLenum mode,
							  GLsizei count, GLenum type,
							  const GLvoid *indices,
							  GLint basevertex);
#endif

static PFNGLDRAWELEMENTSBASEVERTEXPROC pglDrawElementsBaseVertex = NULL;

static GLboolean Automatic = GL_FALSE;

#define WIN_WIDTH 300
#define WIN_HEIGHT 300
#define NUM_QUADS  10

static GLuint ib_offset;

static void
init()
{
	GLfloat *vb;
	GLuint *ib;
	GLuint vbo;
	int i;

	pglDrawElementsBaseVertex = (PFNGLDRAWELEMENTSBASEVERTEXPROC)
#if defined(_MSC_VER)
		wglGetProcAddress("glDrawElementsBaseVertex");
#else
		glutGetProcAddress("glDrawElementsBaseVertex");
#endif

	glewInit();
	piglit_require_extension("GL_ARB_vertex_buffer_object");
	piglit_require_extension("GL_ARB_draw_elements_base_vertex");

	glMatrixMode(GL_MODELVIEW);
	glPushMatrix();
	glLoadIdentity();

	glGenBuffersARB(1, &vbo);
	glBindBufferARB(GL_ARRAY_BUFFER_ARB, vbo);
	glBufferDataARB(GL_ARRAY_BUFFER_ARB,
			NUM_QUADS * 8 * sizeof(GLfloat) +
			2 * 4 * sizeof(GLuint),
			NULL, GL_DYNAMIC_DRAW);
	vb = glMapBufferARB(GL_ARRAY_BUFFER_ARB, GL_WRITE_ONLY_ARB);

	for (i = 0; i < NUM_QUADS; i++) {
		float x1 = 10;
		float y1 = 10 + i * 20;
		float x2 = 20;
		float y2 = 20 + i * 20;

		vb[i * 8 + 0] = x1; vb[i * 8 + 1] = y1;
		vb[i * 8 + 2] = x2; vb[i * 8 + 3] = y1;
		vb[i * 8 + 4] = x2; vb[i * 8 + 5] = y2;
		vb[i * 8 + 6] = x1; vb[i * 8 + 7] = y2;
	}
	ib_offset = NUM_QUADS * 8 * sizeof(GLfloat);
	ib = (GLuint *)((char *)vb + ib_offset);
	for (i = 0; i < 8; i++)
		ib[i] = i;

	glUnmapBufferARB(GL_ARRAY_BUFFER_ARB);

	glEnableClientState(GL_VERTEX_ARRAY);
	glVertexPointer(2, GL_FLOAT, 0, 0);

	glBindBufferARB(GL_ELEMENT_ARRAY_BUFFER_ARB, vbo);
}

static void
display()
{
	GLboolean pass = GL_TRUE;
	float white[3] = {1.0, 1.0, 1.0};
	float clear[3] = {0.0, 0.0, 0.0};
	int i, j;

	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	glColor3fv(white);
	/* Draw columns with each successive pair of the quads. */
	for (i = 0; i < NUM_QUADS - 1; i++) {
		glMatrixMode(GL_PROJECTION);
		glPushMatrix();
		glLoadIdentity();
		glOrtho(0, WIN_WIDTH, 0, WIN_HEIGHT, -1, 1);
		glTranslatef(i * 20, 0, 0);

		pglDrawElementsBaseVertex(GL_QUADS, 8, GL_UNSIGNED_INT,
					  (void *)(uintptr_t)ib_offset, i * 4);

		glPopMatrix();
	}

	for (i = 0; i < NUM_QUADS - 1; i++) {
		for (j = 0; j < NUM_QUADS; j++) {
			float *expected;

			int x = 15 + i * 20;
			int y = 15 + j * 20;

			if (j == i || j == i + 1)
				expected = white;
			else
				expected = clear;
			pass = piglit_probe_pixel_rgb(x, y, expected) && pass;
		}
	}

	glutSwapBuffers();

	if (Automatic)
		piglit_report_result(pass ? PIGLIT_SUCCESS : PIGLIT_FAILURE);
}

int main(int argc, char **argv)
{
	glutInit(&argc, argv);
	if (argc==2 && !strncmp(argv[1], "-auto", 5))
		Automatic=GL_TRUE;
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
	glutInitWindowSize(WIN_WIDTH, WIN_HEIGHT);
	glutCreateWindow("draw-elements-base-vertex");
	glutDisplayFunc(display);
	glutKeyboardFunc(piglit_escape_exit_key);

	init();

	glutMainLoop();

	return 0;

}

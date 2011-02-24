/*
 * Copyright © 2010 Marek Olšák <maraeo@gmail.com>
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
 *    Marek Olšák <maraeo@gmail.com>
 */

#include "piglit-util.h"

int piglit_width = 320, piglit_height = 80;
int piglit_window_mode = GLUT_RGB | GLUT_DOUBLE;

void piglit_init(int argc, char **argv)
{
	piglit_ortho_projection(piglit_width, piglit_height, GL_FALSE);

	if (!GLEW_VERSION_1_5) {
		printf("Requires OpenGL 1.5\n");
		piglit_report_result(PIGLIT_SKIP);
	}

	glShadeModel(GL_FLAT);
	glClearColor(0.2, 0.2, 0.2, 1.0);
}

static GLuint vboVertexPointer(GLint size, GLenum type, GLsizei stride,
                               const GLvoid *buf, GLsizei bufSize, intptr_t bufOffset)
{
	GLuint id;
	glGenBuffers(1, &id);
	glBindBuffer(GL_ARRAY_BUFFER, id);
	glBufferData(GL_ARRAY_BUFFER, bufSize, buf, GL_STATIC_DRAW);
	glVertexPointer(size, type, stride, (void*)bufOffset);
	return id;
}

static GLuint vboElementPointer(const GLvoid *buf, GLsizei bufSize)
{
	GLuint id;
	glGenBuffers(1, &id);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, id);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, bufSize, buf, GL_STATIC_DRAW);
	return id;
}

static void test_negative_index_offset(float x1, float y1, float x2, float y2, int index)
{
	float v2[] = {
		x1, y1,
		x1, y2,
		x2, y1
	};
	int indices[] = {
		index, index+1, index+2
	};
	GLuint vbo, ib;

	vbo = vboVertexPointer(2, GL_FLOAT, 0, v2, sizeof(v2), 0);
	ib = vboElementPointer(indices, sizeof(indices));
	glDrawElementsBaseVertex(GL_TRIANGLES, 3, GL_UNSIGNED_INT, NULL, -index);
	glDeleteBuffers(1, &vbo);
	glDeleteBuffers(1, &ib);
}

enum piglit_result piglit_display(void)
{
	GLboolean pass = GL_TRUE;
	unsigned i;
	float x = 0, y = 0;
	float expected[] = {1,1,1};

	glClear(GL_COLOR_BUFFER_BIT);
	glEnableClientState(GL_VERTEX_ARRAY);

	for (i = 0; i < 63; i++) {
		int index = (int)pow(i, 5.2)+1;
		glBindBuffer(GL_ARRAY_BUFFER, 0);
		glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);

		printf("BaseVertex = -%i\n", index);
		test_negative_index_offset(x, y, x+20, y+20, index);
		assert(glGetError() == 0);
		pass = piglit_probe_pixel_rgb(x+5, y+5, expected) && pass;

		x += 20;
		if (x > 300) {
			x = 0;
			y += 20;
		}
	}

	glFinish();
	glutSwapBuffers();

	return pass ? PIGLIT_SUCCESS : PIGLIT_FAILURE;
}
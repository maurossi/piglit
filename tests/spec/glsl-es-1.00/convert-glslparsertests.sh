#!/bin/bash
# This script converts the headers of various frag and vert tests so that they are usuable 
# by glslparsertest_glesXa
# This primarily is achieved through the modification of glsl_version.
# command line params:
# $1 source dir
# $2 target dir
# $3 target version
#
#  // [config]
#  // expect_result: fail
#  // glsl_version: 1.10
#  //
#  // # NOTE: Config section was auto-generated from file
#  // # NOTE: 'glslparser.tests' at git revision
#  // # NOTE: 6cc17ae70b70d150aa1751f8e28db7b2a9bd50f0
#  // [end config]
#

find ${1} -regex ".*\.\(vert\|frag\)" -print0 | while read -d $'\0' file
do
   outfile=${file}
   outfile=${outfile##*/}
   sed 's/glsl_version: 1.10/glsl_version: 1.00/' <${file} >${outfile}
done

# avoid known "bad" testcases that don't make sense for various versions of glsl es
# listed here

# change expected results for some test cases due to difference between 
# GLSL and GLSL ES
# listed here 

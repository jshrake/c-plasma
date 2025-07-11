/* (c)  oblong industries */

/* ob-vers-gen.h is generated from ob-ver-gen.h.in by configure.ac */

#ifndef OB_VERS_CTRL
#error ob-vers-gen.h should only be included from ob-vers.h
#endif

/* The g-speak (yovo) version number, as a string, as three integers,
 * and as a single integer. */
#define G_SPEAK_VERSION ""
#define G_SPEAK_VERSION_MAJOR ""
#define G_SPEAK_VERSION_MINOR ""
#define G_SPEAK_VERSION_MICRO ""
#define G_SPEAK_VERSION_NUMBER ""

/* This is a rather long version string, the format of which was defined
 * by Tom's gen-git-version.sh script in libProtist.  Unclear whether
 * we will necessarily want to keep this going forward. */
#define G_SPEAK_GIT_VERSION ""

/* This is meant to give some indication of whether the library and
 * header files match.  As our binary compatibility policy evolves,
 * we may wish to tweak the logic in configure.ac that generates this. */
#define G_SPEAK_ABI_VERSION ""

/* Where Oblong packages that aren't very g-speak version specific are installed */
#define YOBUILD_PREFIX ""

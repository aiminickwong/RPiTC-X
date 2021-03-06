#define PANGO_MAJOR_VERSION (1)
#define PANGO_MINOR_VERSION (36)
#define PANGO_MICRO_VERSION (6)
#define PANGO_CHECK_VERSION(major,minor,micro) \
	(PANGO_MAJOR_VERSION > (major) || \
	 (PANGO_MAJOR_VERSION == (major) && PANGO_MINOR_VERSION > (minor)) || \
	 (PANGO_MAJOR_VERSION == (major) && PANGO_MINOR_VERSION == (minor) && PANGO_MICRO_VERSION >= (micro)))

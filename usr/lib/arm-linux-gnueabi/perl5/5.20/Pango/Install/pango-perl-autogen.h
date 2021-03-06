/* This file is automatically generated. Any changes made here will be lost. */

/* This header defines simple perlapi-ish macros for creating SV wrappers
 * and extracting the GPerl value from SV wrappers.  These macros are used
 * by the autogenerated typemaps, and are defined here so that you can use
 * the same logic anywhere in your code (e.g., if you handle the argument
 * stack by hand instead of using the typemap). */

#ifdef PANGO_TYPE_ALIGNMENT
  /* GEnum PangoAlignment */
# define SvPangoAlignment(sv)	((PangoAlignment)gperl_convert_enum (PANGO_TYPE_ALIGNMENT, sv))
# define newSVPangoAlignment(val)	(gperl_convert_back_enum (PANGO_TYPE_ALIGNMENT, val))
#endif /* PANGO_TYPE_ALIGNMENT */

#ifdef PANGO_TYPE_ATTR_LIST
  /* GBoxed PangoAttrList */
  typedef PangoAttrList PangoAttrList_ornull;
# define SvPangoAttrList(sv)	((PangoAttrList *) gperl_get_boxed_check ((sv), PANGO_TYPE_ATTR_LIST))
# define SvPangoAttrList_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoAttrList (sv) : NULL)
  typedef PangoAttrList PangoAttrList_own;
  typedef PangoAttrList PangoAttrList_copy;
  typedef PangoAttrList PangoAttrList_own_ornull;
# define newSVPangoAttrList(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_ATTR_LIST, FALSE))
# define newSVPangoAttrList_ornull(val)	((val) ? newSVPangoAttrList(val) : &PL_sv_undef)
# define newSVPangoAttrList_own(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_ATTR_LIST, TRUE))
# define newSVPangoAttrList_copy(val)	(gperl_new_boxed_copy ((gpointer) (val), PANGO_TYPE_ATTR_LIST))
# define newSVPangoAttrList_own_ornull(val)	((val) ? newSVPangoAttrList_own(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_ATTR_LIST */

#ifdef PANGO_TYPE_ATTR_TYPE
  /* GEnum PangoAttrType */
# define SvPangoAttrType(sv)	((PangoAttrType)gperl_convert_enum (PANGO_TYPE_ATTR_TYPE, sv))
# define newSVPangoAttrType(val)	(gperl_convert_back_enum (PANGO_TYPE_ATTR_TYPE, val))
#endif /* PANGO_TYPE_ATTR_TYPE */

#ifdef PANGO_TYPE_COLOR
  /* GBoxed PangoColor */
  typedef PangoColor PangoColor_ornull;
# define SvPangoColor(sv)	((PangoColor *) gperl_get_boxed_check ((sv), PANGO_TYPE_COLOR))
# define SvPangoColor_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoColor (sv) : NULL)
  typedef PangoColor PangoColor_own;
  typedef PangoColor PangoColor_copy;
  typedef PangoColor PangoColor_own_ornull;
# define newSVPangoColor(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_COLOR, FALSE))
# define newSVPangoColor_ornull(val)	((val) ? newSVPangoColor(val) : &PL_sv_undef)
# define newSVPangoColor_own(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_COLOR, TRUE))
# define newSVPangoColor_copy(val)	(gperl_new_boxed_copy ((gpointer) (val), PANGO_TYPE_COLOR))
# define newSVPangoColor_own_ornull(val)	((val) ? newSVPangoColor_own(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_COLOR */

#ifdef PANGO_TYPE_CONTEXT
  /* GObject derivative PangoContext */
# define SvPangoContext(sv)	((PangoContext*)gperl_get_object_check (sv, PANGO_TYPE_CONTEXT))
# define newSVPangoContext(val)	(gperl_new_object (G_OBJECT (val), FALSE))
  typedef PangoContext PangoContext_ornull;
# define SvPangoContext_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoContext(sv) : NULL)
# define newSVPangoContext_ornull(val)	(((val) == NULL) ? &PL_sv_undef : gperl_new_object (G_OBJECT (val), FALSE))
typedef PangoContext PangoContext_noinc;
#define newSVPangoContext_noinc(val)	(gperl_new_object (G_OBJECT (val), TRUE))
typedef PangoContext PangoContext_noinc_ornull;
#define newSVPangoContext_noinc_ornull(val)	((val) ? newSVPangoContext_noinc(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_CONTEXT */

#ifdef PANGO_TYPE_COVERAGE_LEVEL
  /* GEnum PangoCoverageLevel */
# define SvPangoCoverageLevel(sv)	((PangoCoverageLevel)gperl_convert_enum (PANGO_TYPE_COVERAGE_LEVEL, sv))
# define newSVPangoCoverageLevel(val)	(gperl_convert_back_enum (PANGO_TYPE_COVERAGE_LEVEL, val))
#endif /* PANGO_TYPE_COVERAGE_LEVEL */

#ifdef PANGO_TYPE_DIRECTION
  /* GEnum PangoDirection */
# define SvPangoDirection(sv)	((PangoDirection)gperl_convert_enum (PANGO_TYPE_DIRECTION, sv))
# define newSVPangoDirection(val)	(gperl_convert_back_enum (PANGO_TYPE_DIRECTION, val))
#endif /* PANGO_TYPE_DIRECTION */

#ifdef PANGO_TYPE_FONT_DESCRIPTION
  /* GBoxed PangoFontDescription */
  typedef PangoFontDescription PangoFontDescription_ornull;
# define SvPangoFontDescription(sv)	((PangoFontDescription *) gperl_get_boxed_check ((sv), PANGO_TYPE_FONT_DESCRIPTION))
# define SvPangoFontDescription_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoFontDescription (sv) : NULL)
  typedef PangoFontDescription PangoFontDescription_own;
  typedef PangoFontDescription PangoFontDescription_copy;
  typedef PangoFontDescription PangoFontDescription_own_ornull;
# define newSVPangoFontDescription(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_FONT_DESCRIPTION, FALSE))
# define newSVPangoFontDescription_ornull(val)	((val) ? newSVPangoFontDescription(val) : &PL_sv_undef)
# define newSVPangoFontDescription_own(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_FONT_DESCRIPTION, TRUE))
# define newSVPangoFontDescription_copy(val)	(gperl_new_boxed_copy ((gpointer) (val), PANGO_TYPE_FONT_DESCRIPTION))
# define newSVPangoFontDescription_own_ornull(val)	((val) ? newSVPangoFontDescription_own(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_FONT_DESCRIPTION */

#ifdef PANGO_TYPE_FONT_FACE
  /* GObject derivative PangoFontFace */
# define SvPangoFontFace(sv)	((PangoFontFace*)gperl_get_object_check (sv, PANGO_TYPE_FONT_FACE))
# define newSVPangoFontFace(val)	(gperl_new_object (G_OBJECT (val), FALSE))
  typedef PangoFontFace PangoFontFace_ornull;
# define SvPangoFontFace_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoFontFace(sv) : NULL)
# define newSVPangoFontFace_ornull(val)	(((val) == NULL) ? &PL_sv_undef : gperl_new_object (G_OBJECT (val), FALSE))
typedef PangoFontFace PangoFontFace_noinc;
#define newSVPangoFontFace_noinc(val)	(gperl_new_object (G_OBJECT (val), TRUE))
typedef PangoFontFace PangoFontFace_noinc_ornull;
#define newSVPangoFontFace_noinc_ornull(val)	((val) ? newSVPangoFontFace_noinc(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_FONT_FACE */

#ifdef PANGO_TYPE_FONT_FAMILY
  /* GObject derivative PangoFontFamily */
# define SvPangoFontFamily(sv)	((PangoFontFamily*)gperl_get_object_check (sv, PANGO_TYPE_FONT_FAMILY))
# define newSVPangoFontFamily(val)	(gperl_new_object (G_OBJECT (val), FALSE))
  typedef PangoFontFamily PangoFontFamily_ornull;
# define SvPangoFontFamily_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoFontFamily(sv) : NULL)
# define newSVPangoFontFamily_ornull(val)	(((val) == NULL) ? &PL_sv_undef : gperl_new_object (G_OBJECT (val), FALSE))
typedef PangoFontFamily PangoFontFamily_noinc;
#define newSVPangoFontFamily_noinc(val)	(gperl_new_object (G_OBJECT (val), TRUE))
typedef PangoFontFamily PangoFontFamily_noinc_ornull;
#define newSVPangoFontFamily_noinc_ornull(val)	((val) ? newSVPangoFontFamily_noinc(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_FONT_FAMILY */

#ifdef PANGO_TYPE_FONT_MAP
  /* GObject derivative PangoFontMap */
# define SvPangoFontMap(sv)	((PangoFontMap*)gperl_get_object_check (sv, PANGO_TYPE_FONT_MAP))
# define newSVPangoFontMap(val)	(gperl_new_object (G_OBJECT (val), FALSE))
  typedef PangoFontMap PangoFontMap_ornull;
# define SvPangoFontMap_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoFontMap(sv) : NULL)
# define newSVPangoFontMap_ornull(val)	(((val) == NULL) ? &PL_sv_undef : gperl_new_object (G_OBJECT (val), FALSE))
typedef PangoFontMap PangoFontMap_noinc;
#define newSVPangoFontMap_noinc(val)	(gperl_new_object (G_OBJECT (val), TRUE))
typedef PangoFontMap PangoFontMap_noinc_ornull;
#define newSVPangoFontMap_noinc_ornull(val)	((val) ? newSVPangoFontMap_noinc(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_FONT_MAP */

#ifdef PANGO_TYPE_FONT_MASK
  /* GFlags PangoFontMask */
# define SvPangoFontMask(sv)	((PangoFontMask)gperl_convert_flags (PANGO_TYPE_FONT_MASK, sv))
# define newSVPangoFontMask(val)	(gperl_convert_back_flags (PANGO_TYPE_FONT_MASK, val))
#endif /* PANGO_TYPE_FONT_MASK */

#ifdef PANGO_TYPE_FONT_METRICS
  /* GBoxed PangoFontMetrics */
  typedef PangoFontMetrics PangoFontMetrics_ornull;
# define SvPangoFontMetrics(sv)	((PangoFontMetrics *) gperl_get_boxed_check ((sv), PANGO_TYPE_FONT_METRICS))
# define SvPangoFontMetrics_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoFontMetrics (sv) : NULL)
  typedef PangoFontMetrics PangoFontMetrics_own;
  typedef PangoFontMetrics PangoFontMetrics_copy;
  typedef PangoFontMetrics PangoFontMetrics_own_ornull;
# define newSVPangoFontMetrics(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_FONT_METRICS, FALSE))
# define newSVPangoFontMetrics_ornull(val)	((val) ? newSVPangoFontMetrics(val) : &PL_sv_undef)
# define newSVPangoFontMetrics_own(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_FONT_METRICS, TRUE))
# define newSVPangoFontMetrics_copy(val)	(gperl_new_boxed_copy ((gpointer) (val), PANGO_TYPE_FONT_METRICS))
# define newSVPangoFontMetrics_own_ornull(val)	((val) ? newSVPangoFontMetrics_own(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_FONT_METRICS */

#ifdef PANGO_TYPE_FONT
  /* GObject derivative PangoFont */
# define SvPangoFont(sv)	((PangoFont*)gperl_get_object_check (sv, PANGO_TYPE_FONT))
# define newSVPangoFont(val)	(gperl_new_object (G_OBJECT (val), FALSE))
  typedef PangoFont PangoFont_ornull;
# define SvPangoFont_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoFont(sv) : NULL)
# define newSVPangoFont_ornull(val)	(((val) == NULL) ? &PL_sv_undef : gperl_new_object (G_OBJECT (val), FALSE))
typedef PangoFont PangoFont_noinc;
#define newSVPangoFont_noinc(val)	(gperl_new_object (G_OBJECT (val), TRUE))
typedef PangoFont PangoFont_noinc_ornull;
#define newSVPangoFont_noinc_ornull(val)	((val) ? newSVPangoFont_noinc(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_FONT */

#ifdef PANGO_TYPE_FONTSET
  /* GObject derivative PangoFontset */
# define SvPangoFontset(sv)	((PangoFontset*)gperl_get_object_check (sv, PANGO_TYPE_FONTSET))
# define newSVPangoFontset(val)	(gperl_new_object (G_OBJECT (val), FALSE))
  typedef PangoFontset PangoFontset_ornull;
# define SvPangoFontset_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoFontset(sv) : NULL)
# define newSVPangoFontset_ornull(val)	(((val) == NULL) ? &PL_sv_undef : gperl_new_object (G_OBJECT (val), FALSE))
typedef PangoFontset PangoFontset_noinc;
#define newSVPangoFontset_noinc(val)	(gperl_new_object (G_OBJECT (val), TRUE))
typedef PangoFontset PangoFontset_noinc_ornull;
#define newSVPangoFontset_noinc_ornull(val)	((val) ? newSVPangoFontset_noinc(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_FONTSET */

#ifdef PANGO_TYPE_GLYPH_STRING
  /* GBoxed PangoGlyphString */
  typedef PangoGlyphString PangoGlyphString_ornull;
# define SvPangoGlyphString(sv)	((PangoGlyphString *) gperl_get_boxed_check ((sv), PANGO_TYPE_GLYPH_STRING))
# define SvPangoGlyphString_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoGlyphString (sv) : NULL)
  typedef PangoGlyphString PangoGlyphString_own;
  typedef PangoGlyphString PangoGlyphString_copy;
  typedef PangoGlyphString PangoGlyphString_own_ornull;
# define newSVPangoGlyphString(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_GLYPH_STRING, FALSE))
# define newSVPangoGlyphString_ornull(val)	((val) ? newSVPangoGlyphString(val) : &PL_sv_undef)
# define newSVPangoGlyphString_own(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_GLYPH_STRING, TRUE))
# define newSVPangoGlyphString_copy(val)	(gperl_new_boxed_copy ((gpointer) (val), PANGO_TYPE_GLYPH_STRING))
# define newSVPangoGlyphString_own_ornull(val)	((val) ? newSVPangoGlyphString_own(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_GLYPH_STRING */

#ifdef PANGO_TYPE_LANGUAGE
  /* GBoxed PangoLanguage */
  typedef PangoLanguage PangoLanguage_ornull;
# define SvPangoLanguage(sv)	((PangoLanguage *) gperl_get_boxed_check ((sv), PANGO_TYPE_LANGUAGE))
# define SvPangoLanguage_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoLanguage (sv) : NULL)
  typedef PangoLanguage PangoLanguage_own;
  typedef PangoLanguage PangoLanguage_copy;
  typedef PangoLanguage PangoLanguage_own_ornull;
# define newSVPangoLanguage(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_LANGUAGE, FALSE))
# define newSVPangoLanguage_ornull(val)	((val) ? newSVPangoLanguage(val) : &PL_sv_undef)
# define newSVPangoLanguage_own(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_LANGUAGE, TRUE))
# define newSVPangoLanguage_copy(val)	(gperl_new_boxed_copy ((gpointer) (val), PANGO_TYPE_LANGUAGE))
# define newSVPangoLanguage_own_ornull(val)	((val) ? newSVPangoLanguage_own(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_LANGUAGE */

#ifdef PANGO_TYPE_LAYOUT
  /* GObject derivative PangoLayout */
# define SvPangoLayout(sv)	((PangoLayout*)gperl_get_object_check (sv, PANGO_TYPE_LAYOUT))
# define newSVPangoLayout(val)	(gperl_new_object (G_OBJECT (val), FALSE))
  typedef PangoLayout PangoLayout_ornull;
# define SvPangoLayout_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoLayout(sv) : NULL)
# define newSVPangoLayout_ornull(val)	(((val) == NULL) ? &PL_sv_undef : gperl_new_object (G_OBJECT (val), FALSE))
typedef PangoLayout PangoLayout_noinc;
#define newSVPangoLayout_noinc(val)	(gperl_new_object (G_OBJECT (val), TRUE))
typedef PangoLayout PangoLayout_noinc_ornull;
#define newSVPangoLayout_noinc_ornull(val)	((val) ? newSVPangoLayout_noinc(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_LAYOUT */

#ifdef PANGO_TYPE_SCRIPT
  /* GEnum PangoScript */
# define SvPangoScript(sv)	((PangoScript)gperl_convert_enum (PANGO_TYPE_SCRIPT, sv))
# define newSVPangoScript(val)	(gperl_convert_back_enum (PANGO_TYPE_SCRIPT, val))
#endif /* PANGO_TYPE_SCRIPT */

#ifdef PANGO_TYPE_STRETCH
  /* GEnum PangoStretch */
# define SvPangoStretch(sv)	((PangoStretch)gperl_convert_enum (PANGO_TYPE_STRETCH, sv))
# define newSVPangoStretch(val)	(gperl_convert_back_enum (PANGO_TYPE_STRETCH, val))
#endif /* PANGO_TYPE_STRETCH */

#ifdef PANGO_TYPE_STYLE
  /* GEnum PangoStyle */
# define SvPangoStyle(sv)	((PangoStyle)gperl_convert_enum (PANGO_TYPE_STYLE, sv))
# define newSVPangoStyle(val)	(gperl_convert_back_enum (PANGO_TYPE_STYLE, val))
#endif /* PANGO_TYPE_STYLE */

#ifdef PANGO_TYPE_TAB_ALIGN
  /* GEnum PangoTabAlign */
# define SvPangoTabAlign(sv)	((PangoTabAlign)gperl_convert_enum (PANGO_TYPE_TAB_ALIGN, sv))
# define newSVPangoTabAlign(val)	(gperl_convert_back_enum (PANGO_TYPE_TAB_ALIGN, val))
#endif /* PANGO_TYPE_TAB_ALIGN */

#ifdef PANGO_TYPE_TAB_ARRAY
  /* GBoxed PangoTabArray */
  typedef PangoTabArray PangoTabArray_ornull;
# define SvPangoTabArray(sv)	((PangoTabArray *) gperl_get_boxed_check ((sv), PANGO_TYPE_TAB_ARRAY))
# define SvPangoTabArray_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoTabArray (sv) : NULL)
  typedef PangoTabArray PangoTabArray_own;
  typedef PangoTabArray PangoTabArray_copy;
  typedef PangoTabArray PangoTabArray_own_ornull;
# define newSVPangoTabArray(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_TAB_ARRAY, FALSE))
# define newSVPangoTabArray_ornull(val)	((val) ? newSVPangoTabArray(val) : &PL_sv_undef)
# define newSVPangoTabArray_own(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_TAB_ARRAY, TRUE))
# define newSVPangoTabArray_copy(val)	(gperl_new_boxed_copy ((gpointer) (val), PANGO_TYPE_TAB_ARRAY))
# define newSVPangoTabArray_own_ornull(val)	((val) ? newSVPangoTabArray_own(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_TAB_ARRAY */

#ifdef PANGO_TYPE_UNDERLINE
  /* GEnum PangoUnderline */
# define SvPangoUnderline(sv)	((PangoUnderline)gperl_convert_enum (PANGO_TYPE_UNDERLINE, sv))
# define newSVPangoUnderline(val)	(gperl_convert_back_enum (PANGO_TYPE_UNDERLINE, val))
#endif /* PANGO_TYPE_UNDERLINE */

#ifdef PANGO_TYPE_VARIANT
  /* GEnum PangoVariant */
# define SvPangoVariant(sv)	((PangoVariant)gperl_convert_enum (PANGO_TYPE_VARIANT, sv))
# define newSVPangoVariant(val)	(gperl_convert_back_enum (PANGO_TYPE_VARIANT, val))
#endif /* PANGO_TYPE_VARIANT */

#ifdef PANGO_TYPE_WEIGHT
  /* GEnum PangoWeight */
# define SvPangoWeight(sv)	((PangoWeight)gperl_convert_enum (PANGO_TYPE_WEIGHT, sv))
# define newSVPangoWeight(val)	(gperl_convert_back_enum (PANGO_TYPE_WEIGHT, val))
#endif /* PANGO_TYPE_WEIGHT */

#ifdef PANGO_TYPE_WRAP_MODE
  /* GEnum PangoWrapMode */
# define SvPangoWrapMode(sv)	((PangoWrapMode)gperl_convert_enum (PANGO_TYPE_WRAP_MODE, sv))
# define newSVPangoWrapMode(val)	(gperl_convert_back_enum (PANGO_TYPE_WRAP_MODE, val))
#endif /* PANGO_TYPE_WRAP_MODE */

#ifdef PANGO_TYPE_ATTRIBUTE
  /* GBoxed PangoAttribute */
  typedef PangoAttribute PangoAttribute_ornull;
# define SvPangoAttribute(sv)	((PangoAttribute *) gperl_get_boxed_check ((sv), PANGO_TYPE_ATTRIBUTE))
# define SvPangoAttribute_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoAttribute (sv) : NULL)
  typedef PangoAttribute PangoAttribute_own;
  typedef PangoAttribute PangoAttribute_copy;
  typedef PangoAttribute PangoAttribute_own_ornull;
# define newSVPangoAttribute(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_ATTRIBUTE, FALSE))
# define newSVPangoAttribute_ornull(val)	((val) ? newSVPangoAttribute(val) : &PL_sv_undef)
# define newSVPangoAttribute_own(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_ATTRIBUTE, TRUE))
# define newSVPangoAttribute_copy(val)	(gperl_new_boxed_copy ((gpointer) (val), PANGO_TYPE_ATTRIBUTE))
# define newSVPangoAttribute_own_ornull(val)	((val) ? newSVPangoAttribute_own(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_ATTRIBUTE */

#ifdef PANGO_TYPE_ATTR_ITERATOR
  /* GBoxed PangoAttrIterator */
  typedef PangoAttrIterator PangoAttrIterator_ornull;
# define SvPangoAttrIterator(sv)	((PangoAttrIterator *) gperl_get_boxed_check ((sv), PANGO_TYPE_ATTR_ITERATOR))
# define SvPangoAttrIterator_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoAttrIterator (sv) : NULL)
  typedef PangoAttrIterator PangoAttrIterator_own;
  typedef PangoAttrIterator PangoAttrIterator_copy;
  typedef PangoAttrIterator PangoAttrIterator_own_ornull;
# define newSVPangoAttrIterator(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_ATTR_ITERATOR, FALSE))
# define newSVPangoAttrIterator_ornull(val)	((val) ? newSVPangoAttrIterator(val) : &PL_sv_undef)
# define newSVPangoAttrIterator_own(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_ATTR_ITERATOR, TRUE))
# define newSVPangoAttrIterator_copy(val)	(gperl_new_boxed_copy ((gpointer) (val), PANGO_TYPE_ATTR_ITERATOR))
# define newSVPangoAttrIterator_own_ornull(val)	((val) ? newSVPangoAttrIterator_own(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_ATTR_ITERATOR */

#ifdef PANGO_TYPE_LAYOUT_ITER
  /* GBoxed PangoLayoutIter */
  typedef PangoLayoutIter PangoLayoutIter_ornull;
# define SvPangoLayoutIter(sv)	((PangoLayoutIter *) gperl_get_boxed_check ((sv), PANGO_TYPE_LAYOUT_ITER))
# define SvPangoLayoutIter_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoLayoutIter (sv) : NULL)
  typedef PangoLayoutIter PangoLayoutIter_own;
  typedef PangoLayoutIter PangoLayoutIter_copy;
  typedef PangoLayoutIter PangoLayoutIter_own_ornull;
# define newSVPangoLayoutIter(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_LAYOUT_ITER, FALSE))
# define newSVPangoLayoutIter_ornull(val)	((val) ? newSVPangoLayoutIter(val) : &PL_sv_undef)
# define newSVPangoLayoutIter_own(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_LAYOUT_ITER, TRUE))
# define newSVPangoLayoutIter_copy(val)	(gperl_new_boxed_copy ((gpointer) (val), PANGO_TYPE_LAYOUT_ITER))
# define newSVPangoLayoutIter_own_ornull(val)	((val) ? newSVPangoLayoutIter_own(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_LAYOUT_ITER */

#ifdef PANGO_TYPE_LAYOUT_LINE
  /* GBoxed PangoLayoutLine */
  typedef PangoLayoutLine PangoLayoutLine_ornull;
# define SvPangoLayoutLine(sv)	((PangoLayoutLine *) gperl_get_boxed_check ((sv), PANGO_TYPE_LAYOUT_LINE))
# define SvPangoLayoutLine_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoLayoutLine (sv) : NULL)
  typedef PangoLayoutLine PangoLayoutLine_own;
  typedef PangoLayoutLine PangoLayoutLine_copy;
  typedef PangoLayoutLine PangoLayoutLine_own_ornull;
# define newSVPangoLayoutLine(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_LAYOUT_LINE, FALSE))
# define newSVPangoLayoutLine_ornull(val)	((val) ? newSVPangoLayoutLine(val) : &PL_sv_undef)
# define newSVPangoLayoutLine_own(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_LAYOUT_LINE, TRUE))
# define newSVPangoLayoutLine_copy(val)	(gperl_new_boxed_copy ((gpointer) (val), PANGO_TYPE_LAYOUT_LINE))
# define newSVPangoLayoutLine_own_ornull(val)	((val) ? newSVPangoLayoutLine_own(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_LAYOUT_LINE */

#ifdef PANGO_TYPE_CAIRO_FONT_MAP
  /* GInterface derivative PangoCairoFontMap */
# define SvPangoCairoFontMap(sv)	((PangoCairoFontMap*)gperl_get_object_check (sv, PANGO_TYPE_CAIRO_FONT_MAP))
# define newSVPangoCairoFontMap(val)	(gperl_new_object (G_OBJECT (val), FALSE))
  typedef PangoCairoFontMap PangoCairoFontMap_ornull;
# define SvPangoCairoFontMap_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoCairoFontMap(sv) : NULL)
# define newSVPangoCairoFontMap_ornull(val)	(((val) == NULL) ? &PL_sv_undef : gperl_new_object (G_OBJECT (val), FALSE))
#endif /* PANGO_TYPE_CAIRO_FONT_MAP */

#ifdef PANGO_TYPE_GRAVITY
  /* GEnum PangoGravity */
# define SvPangoGravity(sv)	((PangoGravity)gperl_convert_enum (PANGO_TYPE_GRAVITY, sv))
# define newSVPangoGravity(val)	(gperl_convert_back_enum (PANGO_TYPE_GRAVITY, val))
#endif /* PANGO_TYPE_GRAVITY */

#ifdef PANGO_TYPE_GRAVITY_HINT
  /* GEnum PangoGravityHint */
# define SvPangoGravityHint(sv)	((PangoGravityHint)gperl_convert_enum (PANGO_TYPE_GRAVITY_HINT, sv))
# define newSVPangoGravityHint(val)	(gperl_convert_back_enum (PANGO_TYPE_GRAVITY_HINT, val))
#endif /* PANGO_TYPE_GRAVITY_HINT */

#ifdef PANGO_TYPE_CAIRO_FONT
  /* GInterface derivative PangoCairoFont */
# define SvPangoCairoFont(sv)	((PangoCairoFont*)gperl_get_object_check (sv, PANGO_TYPE_CAIRO_FONT))
# define newSVPangoCairoFont(val)	(gperl_new_object (G_OBJECT (val), FALSE))
  typedef PangoCairoFont PangoCairoFont_ornull;
# define SvPangoCairoFont_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoCairoFont(sv) : NULL)
# define newSVPangoCairoFont_ornull(val)	(((val) == NULL) ? &PL_sv_undef : gperl_new_object (G_OBJECT (val), FALSE))
#endif /* PANGO_TYPE_CAIRO_FONT */

#ifdef PANGO_TYPE_SCRIPT_ITER
  /* GBoxed PangoScriptIter */
  typedef PangoScriptIter PangoScriptIter_ornull;
# define SvPangoScriptIter(sv)	((PangoScriptIter *) gperl_get_boxed_check ((sv), PANGO_TYPE_SCRIPT_ITER))
# define SvPangoScriptIter_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoScriptIter (sv) : NULL)
  typedef PangoScriptIter PangoScriptIter_own;
  typedef PangoScriptIter PangoScriptIter_copy;
  typedef PangoScriptIter PangoScriptIter_own_ornull;
# define newSVPangoScriptIter(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_SCRIPT_ITER, FALSE))
# define newSVPangoScriptIter_ornull(val)	((val) ? newSVPangoScriptIter(val) : &PL_sv_undef)
# define newSVPangoScriptIter_own(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_SCRIPT_ITER, TRUE))
# define newSVPangoScriptIter_copy(val)	(gperl_new_boxed_copy ((gpointer) (val), PANGO_TYPE_SCRIPT_ITER))
# define newSVPangoScriptIter_own_ornull(val)	((val) ? newSVPangoScriptIter_own(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_SCRIPT_ITER */

#ifdef PANGO_TYPE_MATRIX
  /* GBoxed PangoMatrix */
  typedef PangoMatrix PangoMatrix_ornull;
# define SvPangoMatrix(sv)	((PangoMatrix *) gperl_get_boxed_check ((sv), PANGO_TYPE_MATRIX))
# define SvPangoMatrix_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoMatrix (sv) : NULL)
  typedef PangoMatrix PangoMatrix_own;
  typedef PangoMatrix PangoMatrix_copy;
  typedef PangoMatrix PangoMatrix_own_ornull;
# define newSVPangoMatrix(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_MATRIX, FALSE))
# define newSVPangoMatrix_ornull(val)	((val) ? newSVPangoMatrix(val) : &PL_sv_undef)
# define newSVPangoMatrix_own(val)	(gperl_new_boxed ((gpointer) (val), PANGO_TYPE_MATRIX, TRUE))
# define newSVPangoMatrix_copy(val)	(gperl_new_boxed_copy ((gpointer) (val), PANGO_TYPE_MATRIX))
# define newSVPangoMatrix_own_ornull(val)	((val) ? newSVPangoMatrix_own(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_MATRIX */

#ifdef PANGO_TYPE_ELLIPSIZE_MODE
  /* GEnum PangoEllipsizeMode */
# define SvPangoEllipsizeMode(sv)	((PangoEllipsizeMode)gperl_convert_enum (PANGO_TYPE_ELLIPSIZE_MODE, sv))
# define newSVPangoEllipsizeMode(val)	(gperl_convert_back_enum (PANGO_TYPE_ELLIPSIZE_MODE, val))
#endif /* PANGO_TYPE_ELLIPSIZE_MODE */

#ifdef PANGO_TYPE_RENDERER
  /* GObject derivative PangoRenderer */
# define SvPangoRenderer(sv)	((PangoRenderer*)gperl_get_object_check (sv, PANGO_TYPE_RENDERER))
# define newSVPangoRenderer(val)	(gperl_new_object (G_OBJECT (val), FALSE))
  typedef PangoRenderer PangoRenderer_ornull;
# define SvPangoRenderer_ornull(sv)	(gperl_sv_is_defined (sv) ? SvPangoRenderer(sv) : NULL)
# define newSVPangoRenderer_ornull(val)	(((val) == NULL) ? &PL_sv_undef : gperl_new_object (G_OBJECT (val), FALSE))
typedef PangoRenderer PangoRenderer_noinc;
#define newSVPangoRenderer_noinc(val)	(gperl_new_object (G_OBJECT (val), TRUE))
typedef PangoRenderer PangoRenderer_noinc_ornull;
#define newSVPangoRenderer_noinc_ornull(val)	((val) ? newSVPangoRenderer_noinc(val) : &PL_sv_undef)
#endif /* PANGO_TYPE_RENDERER */

#ifdef PANGO_TYPE_RENDER_PART
  /* GEnum PangoRenderPart */
# define SvPangoRenderPart(sv)	((PangoRenderPart)gperl_convert_enum (PANGO_TYPE_RENDER_PART, sv))
# define newSVPangoRenderPart(val)	(gperl_convert_back_enum (PANGO_TYPE_RENDER_PART, val))
#endif /* PANGO_TYPE_RENDER_PART */

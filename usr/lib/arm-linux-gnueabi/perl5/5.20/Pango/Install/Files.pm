package Pango::Install::Files;

$self = {
          'libs' => '-lpango-1.0 -lgobject-2.0 -lglib-2.0 -lpangocairo-1.0 -lpango-1.0 -lgobject-2.0 -lglib-2.0 -lcairo ',
          'deps' => [
                      'Cairo',
                      'Glib'
                    ],
          'inc' => '-pthread -I/usr/include/pango-1.0 -I/usr/include/glib-2.0 -I/usr/lib/arm-linux-gnueabi/glib-2.0/include  -I./build -pthread -I/usr/include/pango-1.0 -I/usr/include/cairo -I/usr/include/glib-2.0 -I/usr/lib/arm-linux-gnueabi/glib-2.0/include -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/libdrm -I/usr/include/libpng12 ',
          'typemaps' => [
                          'pango-perl.typemap',
                          'pango.typemap'
                        ]
        };

@deps = @{ $self->{deps} };
@typemaps = @{ $self->{typemaps} };
$libs = $self->{libs};
$inc = $self->{inc};

	$CORE = undef;
	foreach (@INC) {
		if ( -f $_ . "/Pango/Install/Files.pm") {
			$CORE = $_ . "/Pango/Install/";
			last;
		}
	}

	sub deps { @{ $self->{deps} }; }

	sub Inline {
		my ($class, $lang) = @_;
		if ($lang ne 'C') {
			warn "Warning: Inline hints not available for $lang language
";
			return;
		}
		+{ map { (uc($_) => $self->{$_}) } qw(inc libs typemaps) };
	}

1;

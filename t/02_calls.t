use strict;
use Test::More tests => 8;

my $m;

BEGIN {
    use_ok( $m = 'Template::Plugin::Filter::Base64' );
}

can_ok('Template::Plugin::Filter::Base64', 'init');
can_ok('Template::Plugin::Filter::Base64', 'filter');

my $out = '';
my $input = 'Hello!';
my $parser;
eval {
    use Template;
    $parser = Template->new({
        OUTPUT => \$out,
        TRIM => 1,
    });
};
ok($parser, 'new Template object is ok');
ok($parser->process(\$input), 'Template process method is ok');
ok($input eq $out, 'Simple output correct');

$out = '';
$input = q~[% USE Filter.Base64 trim => 1 %]
    [% FILTER b64 %]
        Hello, world!
    [% END %]
~;

ok($parser->process(\$input), 'Template process method with filter is ok');
ok($out eq 'SGVsbG8sIHdvcmxkIQ==', 'Test-filter output correct');

done_testing();

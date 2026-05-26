#!/usr/bin/env raku

use File::Find;

sub MAIN (:$filename, :$output = 'index.md') {

    my @files = $filename
        ?? $filename.Array
        !!
            find
                dir => 'rakudoc',
                name => /'.rakudoc' $/;

    my ($docsDir) = ($*CWD, '');
    unless $docsDir.add('rakudoc').e {
        say 'Please run this script from the project root directory.';
        exit;
    }

    $docsDir .= add('docs');
    $docsDir.mkdir;

    my @destFiles;
    for @files {
        my $newFile = $docsDir;

        for $*SPEC.splitdir( .relative ).skip(1) {
            $newFile .= add($_);
            $newFile.mkdir unless $newFile.Str.ends-with('.rakudoc');
        }

        print "Processing { $newFile }...";
        my $docs = qqx{raku --doc=Markdown $_};

        if $docs.trim {
            my $destFile = $newFile.extension('md');
            my $depth = $*SPEC.splitdir($destFile.relative).elems - 1;
            my $back = ('../' x $depth) ~ 'index.md';
            $destFile.spurt: "[← Index]($back)\n\n" ~ $docs;
            @destFiles.push($destFile);
            say "output written to { $destFile.relative }";
        } else {
            say "nothing to output";
        }
    }

    # If processing a single file, do NOT write out the index.
    unless $filename {
        # Write index file
        my $index = "Document Index\n";
        $index ~= '=' x $index.chars.chomp ~ "\n\n";

        for sort @destFiles {
            my $m = .extension('');
            my $module-name = $*SPEC.splitdir( $m.relative ).skip(1).join('::');

            my $n = .extension('md');
            $index ~= "- [{ $module-name }]({ $n.relative })\n";
        }

        my $index-page = $docsDir.parent.resolve.add($output);
        $index-page.resolve.spurt: $index;
    }

}

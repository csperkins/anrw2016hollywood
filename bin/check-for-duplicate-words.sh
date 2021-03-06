#!/usr/bin/env perl

# Finds duplicate adjacent words. Taken from:
# http://matt.might.net/articles/shell-scripts-for-passive-voice-weasel-words-duplicates/
 
use strict ;
 
my $DupCount = 0 ;
 
if (!@ARGV) {
  print "usage: bin/check-for-duplicate-words.sh <file> ...\n" ;
  exit ;
}
 
while (1) {
  my $FileName = shift @ARGV ;
 
  # Exit code = number of duplicates found.  
  #exit $DupCount if (!$FileName) ;
  exit if (!$FileName) ;
 
  open FILE, $FileName or die $!; 
   
  my $LastWord = "" ;
  my $LineNum = 0 ;
   
  while (<FILE>) {
    chomp ;
 
    $LineNum ++ ;
     
    my @words = split (/(\W+)/) ;
     
    foreach my $word (@words) {
      # Skip spaces:
      next if $word =~ /^\s*$/ ;
 
      # Skip punctuation:
      if ($word =~ /^\W+$/) {
        $LastWord = "" ;
        next ;
      }
       
      # Found a dup? 
      if (lc($word) eq lc($LastWord)) {
        print "$FileName:$LineNum duplicate word \"$word\"\n" ;
        $DupCount ++ ;
      } # Thanks to Sean Cronin for tip on case.
 
      # Mark this as the last word:
      $LastWord = $word ;
    }
  }
   
  close FILE ;
}


use strict;
use warnings;
use Test::More 'no_plan';

use Monad;
use Monad::IO;
use Monad::List;
use Monad::Maybe;

my $io = mapM (sub :IO { putStrLn(@_) }, [1..10]);
runIO($io);

my $maybe = mapM (sub :Maybe { Just($_[0]+1) }, [1..3]);
is_deeply(fromJust($maybe), [2,3,4], 'maybe');

my $xs = mapM (sub :List { [1,2,3] }, [1, 1]);
is_deeply($xs, [[1,1],[1,2],[1,3],[2,1],[2,2],[2,3],
                [3,1],[3,2],[3,3]], 'list');

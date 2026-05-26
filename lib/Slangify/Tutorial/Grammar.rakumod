grammar Slangify::Tutorial::Grammar {
    token TOP {
        <.ws>
        name        <.ws> <name>       <.ws>
        party       <.ws> <party>      <.ws>
        time        <.ws> <time>       <.ws>
        restaurant  <.ws> <restaurant> <.ws>
        date        <.ws> <date>       <.ws>?
        $
    }

    token name       { '"' <( <-["]>+ )> '"' }
    token party      { \d+                   }
    token time       { \d+ ':' \d\d          }
    token restaurant { '"' <( <-["]>+ )> '"' }
    token date       { \S+                   }
    token ws         { \h*                   }
}

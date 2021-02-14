      program htmler
C      parameter (pi = 3.141593)
C      real pi
      integer i,j,nalb,npg,nphot,junk,test1,test2
C      complex c11
      character fname*12,pname1*8,pname2*8,an*2,pn*2,cap1*60,
     $          cap2*60,name*12,st*1,pn2*2

   1  write(*,*) 'Album Number: '
      read(*,*) nalb
      if ((nalb.lt.0) .or. (nalb.ge.100)) goto 1

   2  write(*,*) 'Number of Pages: (1<=pages<=99)'
      read(*,*) npg
      if ((npg.le.0) .or. (npg.ge.100)) goto 2

      an = char((nalb-mod(nalb,10))/10+48) //
     $     char(mod(nalb,10)+48)
      name = 'album' // an // '.txt'
      open(5,file=name,status='old')

      do 51 i=1,npg
        pn = char((i-mod(i,10))/10+48) //
     $       char(mod(i,10)+48)
        fname = 'alb' // an // pn // '.htm'
        nphot = 2*(i-1)+1
        pname1 = 'alb' // char((nalb-mod(nalb,10))/10+48) //
     $           char(mod(nalb,10)+48) // 'p' //
     $           char((nphot-mod(nphot,10))/10+48) //
     $           char(mod(nphot,10)+48)
        pname2 = 'alb' // char((nalb-mod(nalb,10))/10+48) //
     $           char(mod(nalb,10)+48) // 'p' //
     $           char((nphot+1-mod(nphot+1,10))/10+48) //
     $           char(mod(nphot+1,10)+48)

        open(4,file=fname,status='new')
C       write(*,*) name
        write(*,*) fname

C  WRITING HTML FILE FOR ONE PAGE (with TWO PHOTOS on it)
        write(4,*) '<html>'
        write(4,*) '<head>'
        write(4,*) '<title>photoalbum</title>'
        write(4,*) '<link rel="stylesheet" type="text/css"',
     $             'href="album.css" />'
        write(4,*) '<script src="hotchocolate.js"> </script>'
        write(4,*) '</head>'
        write(4,*) '<body>'
        write(4,*) '<table class="album">'
        write(4,*) '<tr><td class="photo">'
        read(5,*) junk
        read(5,*) st
        if ((ichar(st)-48).gt.1) then
          test1=1
        else
          test1=0
        endif
        st = char(mod(ichar(st)-48,2)+48)
        write(4,*) '<a href="./' // pname1 // '.htm">',
     $             ' <img class="page' // st // '"',
     $             ' src="./' // pname1 // '.jpg" '
        write(4,*) 'name="' // pname1 // '"> </a>'
        write(4,*) '</td>'
        write(4,*) '<td class="photo">'
        read(5,*) cap1
        read(5,*) junk
        read(5,*) st
        if ((ichar(st)-48).gt.1) then
          test2=1
        else
          test2=0
        endif
        st = char(mod(ichar(st)-48,2)+48)
        write(4,*) '<a href="./' // pname2 // '.htm">',
     $             ' <img class="page' // st // '"',
     $             ' src="./' // pname2 // '.jpg" '
        write(4,*) 'name="' // pname2 // '"> </a>'
        write(4,*) '</td></tr>'
        write(4,*) '<tr><td class="caption">'
        if (test1 .eq. 1) then
          write(4,*) '<div id="beej" onMouseOver="back(''' // pname1 //
     $               ''')" onMouseOut="front(''' // pname1 //
     $               ''')">'
        else
          write(4,*) '<div id="beej" >'
        endif
        write(4,*) cap1
        write(4,*) '</div>'
        write(4,*) '</td>'
        write(4,*) '<td class="caption">'
        read(5,*) cap2
        if (test2 .eq. 1) then
          write(4,*) '<div id="beej" onMouseOver="back(''' // pname2 //
     $               ''')" onMouseOut="front(''' // pname2 //
     $               ''')">'
        else
          write(4,*) '<div id="beej" >'
        endif
        write(4,*) cap2
        write(4,*) '</div>'
        write(4,*) '</td></tr>'
        write(4,*) '</table>'
        write(4,*) '<br>'
        write(4,*) '<table class="nav">'
        write(4,*) '<tr><td class="left">'
        if (i.eq.1) then
          write(4,*) '<a class="bj" href="./index.html">',
     $               ' <h1> Cover </h1> </a>'
        else
          pn = char((i-1-mod(i-1,10))/10+48) //
     $         char(mod(i-1,10)+48)
          write(4,*) '<a class="bj" href="./alb' // an //
     $               pn // '.htm">',
     $               ' <h1> Previous Page </h1> </a>'
        endif
        write(4,*) '</td>'
        write(4,*) '<td class="center">'
        do 21 j=1,int(npg/5)
          pn2 = char((5*j-mod(5*j,10))/10+48) //
     $          char(mod(5*j,10)+48)
            write(4,*) '<a class="bj2" href="./alb' // an //
     $                 pn2 // '.htm"> '
     $                 // pn2 // ' </a>'
 21     continue
        write(4,*) '</td>'
        write(4,*) '<td class="right">'
        if (i.eq.npg) then
          write(4,*) '<a class="bj" href="./index.html">',
     $               ' <h1> Cover </h1> </a>'
        else
          pn = char((i+1-mod(i+1,10))/10+48) //
     $         char(mod(i+1,10)+48)
          write(4,*) '<a class="bj" href="./alb' // an //
     $               pn // '.htm">',
     $               ' <h1> Next Page </h1> </a>'
        endif
        write(4,*) '</td></tr>'
        write(4,*) '</table>'
        write(4,*) '</body>'
        write(4,*) '</html>'
        close(4)

C  WRITE FIRST PHOTO SOLO PAGE
        fname=pname1 // '.htm'
        open(4,file=fname,status='new')
        write(4,*) '<html>'
        write(4,*) '<head>'
        write(4,*) '<title>photo album</title>'
        write(4,*) '<link rel="stylesheet" type="text/css"',
     $             'href="album.css" media="all" />'
        write(4,*) '<link rel="stylesheet" type="text/css"',
     $             'href="print.css" media="print" />'
        write(4,*) '<script src="hotchocolate.js"> </script>'
        write(4,*) '</head>'
        write(4,*) '<body>'
        write(4,*) '<img class="solo" src="./' // pname1 // '.jpg"',
     $             ' name="' // pname1 // '">'
        write(4,*) '<br>'
        if (test1 .eq. 1) then
          write(4,*) '<div id="bee" onMouseOver="back(''' // pname1 //
     $               ''')" onMouseOut="front(''' // pname1 //
     $               ''')" '
          write(4,*) 'onclick="tog()"> '
        else
          write(4,*) '<div id="bee" >'
        endif
        write(4,*) cap1
        write(4,*) '</div>'
        write(4,*) '</body>'
        write(4,*) '</html>'
        close(4)

C  WRITE SECOND PHOTO SOLO PAGE
        fname=pname2 // '.htm'
        open(4,file=fname,status='new')
        write(4,*) '<html>'
        write(4,*) '<head>'
        write(4,*) '<title>photo album</title>'
        write(4,*) '<link rel="stylesheet" type="text/css"',
     $             'href="album.css" media="all" />'
        write(4,*) '<link rel="stylesheet" type="text/css"',
     $             'href="print.css" media="print" />'
        write(4,*) '<script src="hotchocolate.js"> </script>'
        write(4,*) '</head>'
        write(4,*) '<body>'
        write(4,*) '<img class="solo" src="./' // pname2 // '.jpg"',
     $             ' name="' // pname2 // '">'
        write(4,*) '<br>'
        if (test2 .eq. 1) then
          write(4,*) '<div id="bee" onMouseOver="back(''' // pname2 //
     $               ''')" onMouseOut="front(''' // pname2 //
     $               ''')" '
          write(4,*) 'onclick="tog()" >'
        else
          write(4,*) '<div id="bee" >'
        endif
        write(4,*) cap2
        write(4,*) '</div>'
        write(4,*) '</body>'
        write(4,*) '</html>'
        close(4)
 51   continue
      close(5)

      end
